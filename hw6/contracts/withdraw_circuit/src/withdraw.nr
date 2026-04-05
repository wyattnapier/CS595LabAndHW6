use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    //TODO: fill in inputs
    r: Field,
    index: Field,
    path: [Field; 8], // The old Merkle tree path to the empty leaf [Field; depth] and depth is 8 because is tree has 256 leaves so 2^8 levels
    root: pub Field,
    id: pub Field
) {
    // CONSTRAINTS PROVEN
    // - value PedersenHash(id, r) exists within the tree at the given index along the provided path.
    // - supplied root is the correct Merkle tree root corresponding to this path.

    let c: Field = pedersen_hash([id, r]); // selected leaf
    let computedRoot: Field = compute_merkle_root(c, index, path);
    assert(computedRoot == root); // confirms that supplied root is correct and that the leaf is in the tree
}
