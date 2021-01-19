# ChocolateyPackages

## Windows Virtual Desktop
The packages below always install the latest version of the Agent and/or Bootloader, regardless of the version specified in the chocolatey package. Microsoft do not officially offer older versions for download as the tools are self-updating. Because of this you may get checksum mismatch between the time Microsoft releases a new installer, and the package is automatically updated.

### Windows Virtual Desktop Agent
- choco pack
- choco install wvd-agent -s . -y --params="'/REGISTRATIONTOKEN:[Registration key for WVD Host Pool]'" --pre
### Windows Virtual Desktop Bootloader
- choco pack
- choco install wvd-boot-loader -s . -y --pre
