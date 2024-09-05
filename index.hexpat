struct IndexHeader {
    u32 unknown0;
    u32 entryCount;
    u32 unknown1;
    u32 entrySize;
    u32 pointerCount;
    u32 unknown2;
};
struct IndexPointer {
    u32 unknown;
};

u32 entrySize;
struct Entry {
    u8 content[entrySize] [[single_color]];
};
struct CDBEntry {
    u32 unknown0;
    u32 unknown1;
    u32 unknown2;
    u32 unknown3;
};
struct Index {
    IndexHeader header;
    IndexPointer pointers[header.pointerCount];
    entrySize = header.entrySize;
    Entry entries[header.entryCount];
};

Index index @ 0;