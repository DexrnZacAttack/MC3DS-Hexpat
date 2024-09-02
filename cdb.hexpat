#pragma author DexrnZacAttack
#pragma description Minecraft 3DS Edition CDB files
#pragma contributors Anonymous941
#pragma endian little

struct FileHeader {
    // both are always 1
    u16 something0;
    u16 something1;
    u32 subfileCount; // total number of subfiles
    u32 unknown0;
    u32 subfileSize; // size of each subfile
    u32 unknown1;
};

struct SubfileHeader {
    padding[sizeof(FileHeader)]; // the first subfile has a file header and the rest have garbage here
    u32 magic;
    padding[0x8]; // unknown
};

struct ChunkSection {
    s32 index; // -1 = empty
    s32 compressedSize; // -1 = empty
    s32 decompressedSize; // 0 = empty
    u32 unknown;
};

struct ChunkHeader {
    SubfileHeader subfileHeader;
    u8 unknown0;
    u8 unknown1;
    u8 unknown2;
    u8 unknown3;
    ChunkSection sections[6];
};

struct Chunk {
    ChunkHeader header;
};

FileHeader file @ 0;
struct Test {
    SubfileHeader common [[inline]];
    padding[file.subfileSize - sizeof(common)];
};
Test entries[file.subfileCount] @ 0;