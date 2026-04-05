use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    id: Field,
    r: Field,
    hashPath: [Field; 8], // The old Merkle tree path to the empty leaf [Field; depth] and depth is 8 because is tree has 256 leaves so 2^8 levels
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field, // must equal PedersenHash(id, r)
    index: pub Field, // leaf index
) {
    // CONSTRAINTS PROVEN
    // - commitment == PedersenHash(id, r)
    // - The new Merkle tree root is correctly computed by inserting commitment at the specified index, updating the old path.
    // - The provided old Merkle path is valid for oldRoot
    
    // hash commitment c for new leaf
    let c: Field = pedersen_hash([id, r]);

    // enforce commitment == PedersenHash(id, r)
    assert(commitment == c, "Commitment isn't equal to PedersenHash(id, r)");

    // compute and verify old root
    let oldLeaf: Field = 0x2df8b940e5890e4e1377e05373fae69a1d754f6935e6a780b666947431f2cdcd; // old leaf initialized to PedersenHash(0)
    let oldRootComputed: Field = compute_merkle_root(oldLeaf, index, hashPath);
    assert(oldRoot == oldRootComputed, "Old root doesn't match computed old root");

    // compute and verify new root
    let newRootComputed: Field = compute_merkle_root(c, index, hashPath);
    assert(newRoot == newRootComputed, "New root doesn't match computer new root");

}
