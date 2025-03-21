#pragma author DexrnZacAttack
#pragma contributors Anonymous941
#pragma description Minecraft 3DS Edition index files
#pragma endian little
#pragma pattern_limit 200000

struct IndexHeader {
    u32 version;
    u32 entryCount;
    u32 unknown0;
    u32 entrySize;
    u32 pointerCount;
    u32 unknown1;
};
struct IndexPointer {
    u32 unknown; // seems to be related to slt numbers
};

struct CDBEntry {
    u16 xBitfield;
    u16 zBitfield;
    u16 slotNumber; // slot number, unless it's <32?
    u16 subfile;
    u16 constant0; // always 0x20FF
    u16 unknown0; // usually 0xA, but not always
    u16 unknown1; // usually 0x1, sometimes 0x2 or 0x3
    u16 constant1; // always 0x8000, entry count?
};
struct VDBEntry {
    char name[];
    padding[0x20 - sizeof(name)]; // name is padded with garbage to fit into 0x20 bytes
    // it turns out that 99% of this is just uninitialized garbage data!
    // I spent almost 8 hours trying desperately to find a pattern, and only the name and last 0xC bytes even matter
    padding[0xE0]; // uninitialized garbage data
    u16 slot;
    u16 subfile;
    u16 unknown0;
    u16 unknown1;
    u16 unknownMirroredInVDB; // also in the VDB data
    u16 unknown2;
};

// if the entry struct (specific to CDB or VDB) is unknown
struct UnknownEntry<auto entrySize> {
    u8 content[entrySize] [[single_color]];
};
struct Entry<auto entrySize, Type> {
    Type entry [[inline]];
    padding[entrySize - sizeof(entry)];
};
struct Index<Type> {
    IndexHeader header;
    IndexPointer pointers[header.pointerCount];
    Entry<header.entrySize, Type> entries[header.entryCount];
};

// uncomment to choose CDB or VDB index
//Index<CDBEntry> index @ 0;
//Index<VDBEntry> index @ 0;
