{ solidityPackage, dappsys }: solidityPackage {
  name = "ds-guard";
  deps = with dappsys; [ds-auth ds-test];
  src = ./src;
}
