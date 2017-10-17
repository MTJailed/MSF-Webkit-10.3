# Metasploit Webkit Modules
A metasploit module for webkit exploits and PoC's targeting devices running iOS 10+.

## CVE-2017-7061
PoC Author: Lokihardt, Google Project Zero.

Bug Type: Type confusion, string changed to integer.

Useful for: Memory corruption, remote arbitrary code execution.

PoC result: Webkit Denial of Service.

## How to install these modules
git clone https://github.com/MTJailed/MSF-Webkit-10.3

cd MSF-Webkit-10.3

cp *.rb /usr/share/metasploit-framework/modules/exploit/apple_ios/browser/


## Module Authors
OxFEEDFACE (Sem Voigtlander)
