# Crowdfunding Module

This Move module implements a simple crowdfunding system on the Aptos blockchain. It allows users to create campaigns, contribute funds, and withdraw funds once the campaign's goal is met.

## Features

1. **Create Campaign**: 
   - Users can create a new crowdfunding campaign by specifying a funding goal.
   - Campaigns are associated with the creator's address.

2. **Contribute to Campaign**:
   - Contributors can add funds to a specific campaign.
   - Contributions are tracked, and the campaign is deactivated once the funding goal is reached.

3. **Withdraw Funds**:
   - Campaign creators can withdraw funds if the campaign's funding goal is met.
   - Once funds are withdrawn, the campaign is marked as inactive.

## Data Structures

### Campaign
The `Campaign` struct stores the following information:
- `creator`: Address of the campaign creator.
- `goal`: The funding goal for the campaign.
- `funds_raised`: Total funds raised so far.
- `contributors`: A list of addresses that contributed to the campaign.
- `is_active`: A boolean indicating whether the campaign is still active.

## Error Codes

- `E_CAMPAIGN_CLOSED (1)`: Raised when attempting to contribute to a closed campaign.
- `E_GOAL_ALREADY_MET (2)`: Raised when attempting to contribute to or withdraw from a campaign where the funding goal is already met.

## Functions

### `create_campaign`
- **Parameters**: 
  - `creator`: The signer of the transaction.
  - `goal`: The funding goal for the campaign.
- **Description**: Creates a new campaign and associates it with the creator's address.

### `contribute`
- **Parameters**: 
  - `contributor`: The signer of the transaction.
  - `campaign_creator`: The address of the campaign creator.
  - `amount`: The amount to contribute.
- **Description**: Allows a user to contribute funds to a campaign. Deactivates the campaign if the funding goal is reached.

### `withdraw`
- **Parameters**: 
  - `creator`: The signer of the transaction.
- **Description**: Allows the campaign creator to withdraw funds if the funding goal is met. Marks the campaign as inactive.

## Contract Details

### Module Address
The module is deployed at the following address:
```
0x56f769d0aebed213452a886485ae751b434547c6c70d10b21cb9b17470028597
```
Trasnaction Hash : 
```
0x0aa11056f1d2876b747ce89aeba97044f31b645ef8d4a702adcf48cda5da28f6
```
![image](https://github.com/user-attachments/assets/02758299-e6ba-4ee7-973b-a977af2e9c62)

### Dependencies
This module depends on the following Aptos framework modules:
- `aptos_framework::account`
- `aptos_framework::signer`
- `std::vector`

### Access Control
- Only the campaign creator can withdraw funds from their campaign.
- Any user can contribute to an active campaign.

### State Management
- Campaigns are stored on-chain and associated with the creator's address.
- The `Campaign` struct is marked with the `key` ability, allowing it to be stored in global storage.

## Usage

1. **Create a Campaign**:
   ```move
   create_campaign(&signer, 1000);
   ```

2. **Contribute to a Campaign**:
   ```move
   contribute(&signer, campaign_creator_address, 500);
   ```

3. **Withdraw Funds**:
   ```move
   withdraw(&signer);
   ```

## Notes
- Ensure that the funding goal is realistic and achievable.
- Contributions are tracked, but the module does not currently implement refund functionality for failed campaigns.
- The module assumes the use of Aptos coins for contributions.

## License
This module is provided as-is under an open-source license. Feel free to modify and use it as needed.
