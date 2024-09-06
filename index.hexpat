#pragma pattern_limit 200000
struct IndexHeader {
    u32 unknown0; // always 0x2
    u32 entryCount;
    u32 unknown1;
    u32 entrySize;
    u32 pointerCount;
    u32 unknown2;
};
struct IndexPointer {
    u32 unknown; // seems to be related to slt numbers
};

struct CDBEntry {
    s8 unknown0; // x?
    s8 unknown1; // z?
    u16 unknown2; // how many blocks make up a row?
    u16 slot; // slot (corresponds to a CDB file), unless it's <16?
    u16 subfile; // subfile within the slot
    u16 constant0; // always 0x20FF
    u16 constant1; // always 0xA
    u16 unknown4; // usually 0x1, sometimes 0x2 or 0x3, and on large worlds as high as 0x6e
    u16 constant2; // always 0x8000, subfile count?
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