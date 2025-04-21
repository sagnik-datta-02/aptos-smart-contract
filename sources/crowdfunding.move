module 0x56f769d0aebed213452a886485ae751b434547c6c70d10b21cb9b17470028597::Crowdfunding {
    use aptos_framework::account;
    use aptos_framework::signer;
    use std::vector;

    /// Error codes
    const E_CAMPAIGN_CLOSED: u64 = 1;
    const E_GOAL_ALREADY_MET: u64 = 2;

    /// Structure to store crowdfunding campaign information
    struct Campaign has key {
        creator: address,
        goal: u64,
        funds_raised: u64,
        contributors: vector<address>,
        is_active: bool
    }

    /// Creates a new crowdfunding campaign
    public entry fun create_campaign(
        creator: &signer,
        goal: u64
    ) {
        let creator_addr = signer::address_of(creator);

        let campaign = Campaign {
            creator: creator_addr,
            goal,
            funds_raised: 0,
            contributors: vector::empty<address>(),
            is_active: true
        };

        move_to(creator, campaign);
    }

    /// Contribute funds to a specific campaign
    public entry fun contribute(
        contributor: &signer,
        campaign_creator: address,
        amount: u64
    ) acquires Campaign {
        let campaign = borrow_global_mut<Campaign>(campaign_creator);
        let contributor_addr = signer::address_of(contributor);

        // Check if the campaign is still active
        assert!(campaign.is_active, E_CAMPAIGN_CLOSED);

        // Check if the funding goal is already met
        assert!(campaign.funds_raised < campaign.goal, E_GOAL_ALREADY_MET);

        // Add funds to the campaign
        campaign.funds_raised = campaign.funds_raised + amount;
        vector::push_back(&mut campaign.contributors, contributor_addr);

        // Deactivate the campaign if the goal is met
        if (campaign.funds_raised >= campaign.goal) {
            campaign.is_active = false;
        }
    }

    /// Withdraw funds from the campaign if the goal is met
    public entry fun withdraw(
        creator: &signer
    ) acquires Campaign {
        let creator_addr = signer::address_of(creator);
        let campaign = borrow_global_mut<Campaign>(creator_addr);

        // Ensure the campaign goal is met
        assert!(campaign.funds_raised >= campaign.goal, E_GOAL_ALREADY_MET);

        // Transfer funds to the creator and deactivate the campaign
        campaign.is_active = false;
        // Logic to transfer funds would go here (e.g., using Aptos coin transfer)
    }
}