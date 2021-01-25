// // SPDX-License-Identifier: GPL-3.0
pragma solidity >0.7.0 <0.9.0;

struct Asset {

        uint Value;
        string Name;
        string Description;
        string Initials;
 }

 struct Collateral {
     Asset[] Assets;
     uint CreateDate;
 }  

 //Titular => has the rigth about the asset
 //Laucher => has of duty to buy
 enum Participant { Launcher, Titular }
 enum TypeParticipant { Put, Call}
 enum StatusOption { Open, Finish }

abstract contract OptionBase 
{
    Asset public AssetObject;
    
    uint public Strike;
    uint public Premium;
    uint public MaturityDate;
    uint public AquisitionDate;

    Collateral[] public Collaterals;
    StatusOption public Status;
    TypeParticipant public Type;
    
    /// @return if collateral has add with sucess
    function AddCollateral() public virtual returns (bool);
    
    /// @return if collateral has retired with sucess
    function RetireCollateral()  public  virtual returns (bool);

    function Execute()  public  virtual;

    modifier HasCollateral {
        require(true, 'Without collateral to do transfer');
        _;
    }

    modifier AlredyFinishTransaction {
        require(Status == StatusOption.Finish, 'Transaction already not Finish');
        _;
    }

    function AddColateral() public  {

    }
    
    /// @param balance the balance
    function AddPremium(uint balance, address launcher) payable public {

    }

    function StartOption() HasCollateral public {
        this.AddCollateral();
        this.Execute();
    }

    function FinishOption() public {
        this.RetireCollateral();
        this.Execute();
    }
}

contract OptionCall is OptionBase {

    function AddCollateral() public override pure returns (bool) {
        return true;
    }

    function RetireCollateral() public override pure returns (bool) {
        return true;
    }

    function Execute() public override {

    }
}

contract PutCall is OptionBase 
{
    function AddCollateral() public override pure returns (bool) {
        return true;
    }

    function RetireCollateral() public override pure returns (bool) {
        return true;
    }

    function Execute() override public {

    }
}