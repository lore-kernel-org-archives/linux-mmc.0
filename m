From: Borislav Petkov <bp@alien8.de>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v2 0/2] Add
 modules to support realtek PCIE card reader
Date: Tue, 14 Aug 2012 18:14:20 +0200
Message-ID: <20120814161420.GA6971@x1.osrc.amd.com>
References: <cover.1344939464.git.wei_wang@realsil.com.cn>
 <20120814150550.GA4091@x1.osrc.amd.com>
 <637A8844983F7F4092120E33EA3F28CD31E74BE133@RSEX1.realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:43446 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989Ab2HNQO1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Aug 2012 12:14:27 -0400
Content-Disposition: inline
In-Reply-To: <637A8844983F7F4092120E33EA3F28CD31E74BE133@RSEX1.realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?B?546L54Kc?= <wei_wang@realsil.com.cn>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Tue, Aug 14, 2012 at 11:22:38PM +0800, =E7=8E=8B=E7=82=9C wrote:

> Hi Boris:
>
> Can you tell me the detailed information about your pc and the SD
> card? Do you have ever tried to use another SD card? I have tested
> all of the SD cards that we have in our company, and everything runs
> smoothly. Maybe it is compatibilty issue and we have to debug it
> specifically.
>
> Please help to check the VID:PID of the card reader using lspci, and =
I
> will send you our SCSI driver for this reader to test the card.

Ok,

here's some info:

* Card is: http://tinyurl.com/cadsmb9

It is in German but should be clear. Otherwise, ask me.

* lspci output:

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS520=
9 PCI Express Card Reader (rev 01)
=2E..
03:00.0 ff00: 10ec:5209 (rev 01)
        Subsystem: 17aa:21ec
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f0000000 (32-bit, non-prefetchable) [size=3D=
4K]
        Expansion ROM at f0400000 [disabled] [size=3D64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,=
D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<1us, L1 <8us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- U=
nsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr=
- TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, =
Latency L0 unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- Retrai=
n- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+=
 DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-, Selectable De-emphasis: -6dB
                         Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, Link=
EqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonF=
atalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap=
+ ChkEn-
        Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e=
0-00

HTH.

--=20
Regards/Gruss,
Boris.
