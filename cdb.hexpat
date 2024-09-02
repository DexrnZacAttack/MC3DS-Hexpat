#pragma author DexrnZacAttack
#pragma description Minecraft 3DS Edition CDB files
#pragma contributors Anonymous941
#pragma endian little

struct commonHeader {
    // I think these are 16-bit, and are usually 1
    u16 unknown0;
    u16 unknown1;

    u32 unknownBitmask; // USUALLY only has one bit set at a time, for some reason
    s32 unknown2;
    s32 entrySize; // size of the entry, after that there will either be EOF or another header
    s32 unknown3;
    u32 magic;
    padding[0x8];
};

struct ChunkSection {
    s32 index; // -1 = empty
    s32 compressedSize; // -1 = empty
    s32 decompressedSize; // 0 = empty
    u32 unknown;
};

struct ChunkHeader {
    commonHeader common;
    padding[0x4];
    ChunkSection sections[6];
};

struct Chunk {
    ChunkHeader header;
};

// there are multiple chunks per database, this only finds the first one for now
Chunk chunk0 @ 0x00;
