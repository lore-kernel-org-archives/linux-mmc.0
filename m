From: Oliver Freyermuth <o.freyermuth@googlemail.com>
Subject: ASPM issues with realtek PCIe card reader 5287 / RTL8411B
Date: Sun, 23 Aug 2015 20:07:52 +0200
Message-ID: <55DA0BF8.5080408@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f196.google.com ([209.85.212.196]:35270 "EHLO
	mail-wi0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbHWSH6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Aug 2015 14:07:58 -0400
Received: by wicxr16 with SMTP id xr16so9444044wic.2
        for <linux-mmc@vger.kernel.org>; Sun, 23 Aug 2015 11:07:56 -0700 (PDT)
Received: from ?IPv6:2a01:5c0:11:e6e1:4851:90a:ef7e:8ba? ([2a01:5c0:11:e6e1:4851:90a:ef7e:8ba])
        by smtp.googlemail.com with ESMTPSA id lj2sm13170562wic.1.2015.08.23.11.07.52
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 11:07:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear MMC-experts, 

I hope this is the correct place to ask, feel free to direct me to a bugtracker. If answering, please include me directly (I'm not subscribed). 

I have a Clevo W230SD laptop (sold as Schenker XMG A305) with a 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5287 (rev 01)
        Subsystem: CLEVO/KAPOK Computer Device 6504
inside (full output below the mail). 

After booting, ASPM is off, i.e. "lspci -xxx -s 4:00.0" reports "0x40" for address 0x80. This prevents my Haswell-machine from entering PC6 state. 

I try to force it on with: setpci -s 04:00.0 0x80.B=0x43
Success - PC6 is used, battery runtime increased by > 50 % (I also had to hack with the Realtek NIC, but that's a different story). 

However, once I plug in an SD card and remove some time later, I now get: 
[ 1112.308909] mmc0: cannot verify signal voltage switch
[ 1112.402839] mmc0: card lacks mandatory switch function, performance might suffer
[ 1112.403081] mmc0: new SD card at address 0000
[ 1152.186603] mmc0: card 0000 removed
Needlessly to say, I cannot mount. 

Re-disabling ASPM:
setpci -s 04:00.0 0x80.B=0x40
Plugging card and unplugging again: 
[ 1158.097421] mmc0: cannot verify signal voltage switch
[ 1158.196616] mmc0: new ultra high speed SDR50 SDHC card at address 59b4
[ 1158.196783] mmcblk0: mmc0:59b4 USD 14.7 GiB
[ 1158.197585] mmcblk0: p1
[ 1201.275228] mmc0: card 59b4 removed

Note each time running lspci in either case I get in kernel log: 
[  989.551713] rtsx_pci 0000:04:00.0: vpd r/w failed.  This is likely a firmware bug on this device.  Contact the card vendor for a firmware update

Is there anything that can be done on driver side to get ASPM working, can I provide better information? I am willing to experiment with any patches or suggestions you may have. 
It works with ASPM on using Realtek's Driver on Windows 10. 

Further info: The machine has a modded BIOS which supposedly *should* force-enable ASPM-L0 on all devices, and Kernel is (UEFI-SecureBoot)-booted with pcie_aspm=force:
# cat /proc/cmdline
\boot\bzImage-4.1.5.efi root=/dev/sdb1 ro pcie_aspm=force i915.enable_fbc=1 initrd=boot\initramfs-4.1.5-gentoo.img

Cheers and thanks in advance,
Oliver Freyermuth



# lspci -xxx -s 4:00.0
04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5287 (rev 01)
00: ec 10 87 52 06 04 10 00 01 00 00 ff 10 00 80 00
10: 00 50 81 f7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 15 04 65
30: 00 00 80 f7 40 00 00 00 00 00 00 00 ff 02 00 00
40: 01 50 c3 f7 00 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 81 00 0c f0 ef fe 00 00 00 00 62 41 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 b0 02 00 c0 8c 90 05 00 20 19 00 11 7c 47 00
80: 40 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 1f 08 0c 00 00 00 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 11 d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device 5287 (rev 01)
        Subsystem: CLEVO/KAPOK Computer Device 6504
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 30
        Region 0: Memory at f7815000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at f7800000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000feeff00c  Data: 4162
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via message/WAKE#
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
                Vector table: BAR=0 offset=00000000
                PBA: BAR=0 offset=00000000
        Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Connection timed out
                Not readable
        Kernel driver in use: rtsx_pci
        Kernel modules: rtsx_pci

