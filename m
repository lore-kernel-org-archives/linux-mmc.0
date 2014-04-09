From: "Frank A. Kingswood" <frank@kingswood-consulting.co.uk>
Subject: Re: [PATCH 0/2] add support of O2Mirco/BayHubTech SD hosts
Date: Wed, 09 Apr 2014 17:48:18 +0100
Message-ID: <534579D2.3050906@kingswood-consulting.co.uk>
References: <1387376619-8050-1-git-send-email-adam.lee@canonical.com> <86wqi5dv13.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kingswood-consulting.co.uk ([88.97.16.53]:56310 "EHLO
	andromeda.kingswood-consulting.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932898AbaDIQxe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Apr 2014 12:53:34 -0400
In-Reply-To: <86wqi5dv13.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Adam Lee <adam.lee@canonical.com>, linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Guo <peter.guo@bayhubtech.com>

On 12/01/14 16:28, Chris Ball wrote:
> Hi, thanks for doing this,
>
> On Wed, Dec 18 2013, Adam Lee wrote:
>> BugLink: http://bugs.launchpad.net/bugs/1239938
>>
>> Card readers on Lenovo ThinkPad W540, Dell Latitude E5440 and Dell Latitude
>> E6540 don't work without this patch.

Dell E7240 has an O2Micro 8520 controller as well.

With this driver (from a vanilla 3.14.0 kernel) it is working OK, but I 
have only used it very lightly and not done any systematic testing.

If it is of interest, I can see these messages in the kernel log:

mmc0: Unknown controller version (3). You may experience problems.
sdhci [sdhci_add_host()]: mmc0: Auto-CMD23 available
sdhci: =========== REGISTER DUMP (mmc0)===========
sdhci: Sys addr: 0x00000000 | Version:  0x00000603
sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
sdhci: Argument: 0x00000000 | Trn mode: 0x00000000
sdhci: Present:  0x00080000 | Host ctl: 0x00000000
sdhci: Power:    0x00000000 | Blk gap:  0x00000000
sdhci: Wake-up:  0x00000000 | Clock:    0x00000002
sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
sdhci: Caps:     0x25fec8bf | Caps_1:   0x10002078
sdhci: Cmd:      0x00000000 | Max curr: 0x005800c8
sdhci: Host ctl2: 0x00000000
sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
sdhci: ===========================================
mmc0: SDHCI controller on PCI [0000:03:00.0] using ADMA

The lspci output for this device:

03:00.0 0805: 1217:8520 (rev 01)
         Subsystem: 1028:05ca

03:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller 
(rev 01) (prog-if 01)
	Subsystem: Dell Device 05ca
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f7c01000 (32-bit, non-prefetchable) [size=4K]
	Region 1: Memory at f7c00000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [6c] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [80] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <512ns, L1 unlimited
			ClockPM+ Surprise- LLActRep- BwNot-
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- 
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, OBFF 
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, 
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [200 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq+ ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout+ NonFatalErr+
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
	Capabilities: [230 v1] Latency Tolerance Reporting
		Max snoop latency: 3145728ns
		Max no snoop latency: 0ns
	Kernel driver in use: sdhci-pci

Thanks,
Frank
-- 
------------------------------------------------------------------------
Frank A. Kingswood                      frank@kingswood-consulting.co.uk
Cambridge, United Kingdom                               +44-7545-209 100


