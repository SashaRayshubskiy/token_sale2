pragma solidity >=0.4.22 <0.9.0;

contract DappToken {
	string public name = "BaCoin";
	string public symbol = "BAC";
	string public standard = "BaCoin Token v1.0";
	uint256 public totalSupply;

	event Transfer(
		address indexed _from,
		address indexed _to,
		uint256 _value
	);


	event Approval (
		address indexed _owner,
		address indexed _spender,
		uint256 _value
	);


	mapping(address => uint256) public balanceOf;

	mapping(address => mapping(address => uint256)) public allowance;

	constructor (uint256 _initialSupply) public {
		totalSupply = _initialSupply;

		// allocate the initial supply
		balanceOf[msg.sender] = _initialSupply;
	}

	// Transfer function
	function transfer(address _to, uint256 _value) public returns (bool success) {
		// Exception if the account doesn't have enough
		require( balanceOf[msg.sender] >= _value, "Not enough funds revert" );

		balanceOf[msg.sender] -= _value;
		balanceOf[_to] += _value;

		emit Transfer( msg.sender, _to, _value );

		return true;
	}

	// approve
	function approve(address _spender, uint256 _value) public  returns (bool success) {

		// allowance
		allowance[msg.sender][_spender] = _value;

		// approve event
		emit Approval( msg.sender, _spender, _value );

		return true;
	}

	// transfer_from
	function transferFrom( address _from, address _to, uint256 _value) public returns (bool success) {

		// Transfer event
		require( balanceOf[_from] >= _value, 'insufficient balance in from');
		require( allowance[_from][msg.sender] >= _value, 'insufficient allowance' );

		balanceOf[_from] -= _value;
		balanceOf[_to] += _value;
		allowance[_from][msg.sender] -= _value;

		emit Transfer(_from, _to, _value);
		
		return true;
	}



}