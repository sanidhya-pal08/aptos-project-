module MyModule::RebaseToken {
    use aptos_framework::coin;
    use aptos_framework::signer;
    use aptos_framework::aptos_coin::AptosCoin;
    
    struct TokenSupply has store, key {
        total_supply: u64,
    }
    
    /// Function to initialize the token supply.
    public fun initialize_supply(owner: &signer, initial_supply: u64) {
        let supply = TokenSupply { total_supply: initial_supply };
        move_to(owner, supply);
    }
    
    /// Function to rebase the token supply by a percentage.
    public fun rebase(owner: &signer, percentage: u64) acquires TokenSupply {
        let supply = borrow_global_mut<TokenSupply>(signer::address_of(owner));
        let increase = supply.total_supply * percentage / 100;
        supply.total_supply = supply.total_supply + increase;
    }
}
