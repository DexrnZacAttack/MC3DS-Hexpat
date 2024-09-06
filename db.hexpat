#pragma author DexrnZacAttack
#pragma description Minecraft 3DS Edition CDB files
#pragma contributors Anonymous941
#pragma endian little

struct FileHeader {
    // both are always 1
    u16 something0;
    u16 something1;
    u32 subfileCount; // total number of subfiles
    u32 unknown0; // always 3
    u32 subfileSize; // size of each subfile
    u32 unknown1;
};

struct SubfileHeader {
    padding[sizeof(FileHeader)]; // the first subfile has a file header and the rest have garbage here
    u32 magic;
    u8 unknown0[8];
    u16 unknown1;
    u16 unknown2;
};

struct ChunkSection {
    s32 index; // -1 = empty    
    s32 position; // -1 = empty; subtract 0xC to get the position within the chunk
    s32 compressedSize; // 0 = empty
    s32 decompressedSize; // 0 = empty
};

struct CDBHeader {
    SubfileHeader subfileHeader;
    ChunkSection sections[6];
};

enum Type : u16 {
    normal,
    map
};

struct VDBHeader {
    SubfileHeader subfileHeader;
    char name[subfileHeader.unknown0[0]];
    u16 unknown1; // size-related
    Type type; // normal = 0x0, map = 0x1
};

FileHeader file @ 0;
struct CDB {
    CDBHeader common [[inline]];
    u8 data[file.subfileSize - sizeof(common)] [[hidden]];
} [[hex::visualize("hex_viewer", data)]];
struct VDB {
    VDBHeader common [[inline]];
    u8 data[file.subfileSize - sizeof(common)];
};
CDB entries[file.subfileCount] @ 0;
//VDB entries[file.subfileCount] @ 0;