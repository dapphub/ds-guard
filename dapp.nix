dapp: with dapp; solidityPackage {
  name = "ds-guard";
  deps = with dappsys; [ds-auth ds-test];
  src = ./src;
}
