#pragma author DexrnZacAttack
#pragma description Minecraft 3DS Edition CDB files
#pragma contributors Anonymous941
#pragma endian little

struct FileHeader {
    // both are always 1
    u16 something0;
    u16 something1;
    u32 subfileCount; // total number of subfiles
    u32 footerSize; // the footer seems to be all 0's
    u32 subfileSize; // size of each subfile
    u32 unknown0; // 0x4 for CDB, 0x100 for VDB
};

struct CDBSubfileHeader {
    padding[sizeof(FileHeader)]; // the first subfile has a file header and the rest have garbage here
    u32 magic;
    u8 unknown0[0x8]; // zero-terminated u8's?
};

struct VDBSubfileHeader {
    padding[sizeof(FileHeader)];
    u32 magic;
    u16 nameSize;
    padding[0x6];
};

struct VDBSubfile {
    VDBSubfileHeader header;
    u32 constant0; // always 0x6
    char name[header.nameSize];
    u32 nbtSize;
    // NBT data
};

struct ChunkSection {
    s32 index; // -1 = empty
    s32 position; // -1 = empty; subtract 0xC to get the position within the chunk
    s32 compressedSize; // 0 = empty
    s32 decompressedSize; // 0 = empty
};  

struct ChunkHeader {
    CDBSubfileHeader subfileHeader;
    u32 constant0; // always 0x3
    ChunkSection sections[0x6];
};

struct Chunk {
    ChunkHeader header;
};

FileHeader file @ 0;
struct CDBTest {
    ChunkHeader common [[inline]];
    padding[file.subfileSize - sizeof(common)];
};
struct VDBTest {
    VDBSubfile common [[inline]];
    padding[file.subfileSize - sizeof(common)];
};
// uncomment to choose CDB or VDB
//CDBTest entries[file.subfileCount] @ 0;
//VDBTest entries[file.subfileCount] @ 0;
