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
    u16 constant1; // always 0xA
    u16 unknown0; // usually 0x1, sometimes 0x2 or 0x3
    u16 constant2; // always 0x8000, entry count?
};

struct VDBArray {
    u32 unknown0;
};
struct VDBEntry {
    char name[];
    char unknownString[]; // it's sometimes a string
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

//Index<VDBEntry> index @ 0;
Index<CDBEntry> index @ 0;