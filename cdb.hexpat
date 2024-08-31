#pragma author DexrnZacAttack
#pragma description Minecraft 3DS Edition CDB files
#pragma contributors Anonymous941

#pragma endian little

struct commonHeader {
    // I think these are 16-bit, and are usually 1
    u16 unknown0;
    u16 unknown1;

    u8 unknownBitmask; // USUALLY only has one bit set at a time, for some reaso
    padding[0xF];
    u32 BOM;
};

struct CDBHeader {
    commonHeader common;
    padding[0x10];
    u32 unknown;
    u32 compressedSize;
    u32 decompressedSize;
};

struct CDB {
    CDBHeader header;
};

CDB cdb @ 0x00;
