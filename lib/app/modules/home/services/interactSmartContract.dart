import 'package:dapp/app/shared/constant.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'Voting'),
    EthereumAddress.fromHex(contactAddress),
  );
  return contract;
}

Future<String> callFunctionSmartContract(String funcName, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);

  return result;
}

Future<String> startVoting(String name, Web3Client ethClient) async {
  var response = await callFunctionSmartContract(
      "startVoting", [name], ethClient, ownerPk);
  print('voting start success');
  return response;
}

Future<String> addCandidate(String name, Web3Client ethClient) async {
  var response = await callFunctionSmartContract(
      "addCandidate", [name], ethClient, ownerPk);
  print('candidade added success');
  return response;
}

Future<String> authorizeVoter(String address, Web3Client ethClient) async {
  var response = await callFunctionSmartContract(
      "authorizeVoter", [EthereumAddress.fromHex(address)], ethClient, ownerPk);
  print('voter authorized success');
  return response;
}

Future<List> getCandidatesNumber(Web3Client ethClient) async {
  List<dynamic> result = await ask('getNumberCandidates', [], ethClient);
  return result;
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<String> vote(int candidateIndex, Web3Client ethClient) async {
  var response = await callFunctionSmartContract(
      'vote', [BigInt.from(candidateIndex)], ethClient, ownerPk);
  print('vote counted success');
  return response;
}
