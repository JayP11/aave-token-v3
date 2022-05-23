// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGovernancePowerDelegationToken {
  enum GovernancePowerType {VOTING, PROPOSITION}

  /**
   * @dev emitted when a user delegates to another
   * @param delegator the delegator
   * @param delegatee the delegatee
   * @param delegationType the type of delegation (VOTING, PROPOSITION)
   **/
  event DelegateChanged(
    address indexed delegator,
    address indexed delegatee,
    GovernancePowerType delegationType
  );

  /**
   * @dev emitted when an action changes the delegated power of a user
   * @param user the user which delegated power has changed
   * @param amount the amount of delegated power for the user
   * @param delegationType the type of delegation (VOTING, PROPOSITION)
   **/
  event DelegatedPowerChanged(
    address indexed user,
    uint256 amount,
    GovernancePowerType delegationType
  );

  /**
   * @dev delegates the specific power to a delegatee
   * @param delegatee the user which delegated power has changed
   * @param delegationType the type of delegation (VOTING, PROPOSITION)
   **/
  function delegateByType(address delegatee, GovernancePowerType delegationType) external;

  /**
   * @dev delegates all the governance powers to a specific user
   * @param delegatee the user to which the powers will be delegated
   **/
  function delegate(address delegatee) external;

  /**
   * @dev returns the delegatee of an user
   * @param delegator the address of the delegator
   **/
  function getDelegateeByType(address delegator, GovernancePowerType delegationType)
    external
    view
    returns (address);

  /**
   * @dev returns the current voting or proposition power of a user.
   * @param user the user
   * @param delegationType the type of delegation (VOTING, PROPOSITION)
   **/
  function getPowerCurrent(address user, GovernancePowerType delegationType)
    external
    view
    returns (uint256);

  function DELEGATE_BY_TYPE_TYPEHASH() external view returns (bytes32);

  function DELEGATE_TYPEHASH() external view returns (bytes32);

  /**
   * @dev implements the permit function as for https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md
   * @param owner the owner of the funds
   * @param delegatee the user to who ownwer delegates his governance power
   * @param delegationType the type of governance power delegation (VOTING, PROPOSITION)
   * @param deadline the deadline timestamp, type(uint256).max for no deadline
   * @param v signature param
   * @param s signature param
   * @param r signature param
   */
  function metaDelegateByType(
    address owner,
    address delegatee,
    GovernancePowerType delegationType,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;

  /**
   * @dev implements the permit function as for https://github.com/ethereum/EIPs/blob/8a34d644aacf0f9f8f00815307fd7dd5da07655f/EIPS/eip-2612.md
   * @param owner the owner of the funds
   * @param delegatee the user to who ownwer delegates his voting and proposition governance power
   * @param deadline the deadline timestamp, type(uint256).max for no deadline
   * @param v signature param
   * @param s signature param
   * @param r signature param
   */
  function metaDelegate(
    address owner,
    address delegatee,
    uint256 deadline,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) external;
}
