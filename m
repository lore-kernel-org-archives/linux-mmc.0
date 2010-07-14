From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 16390] New: Memory card reader does not
 function [Dell Latitude E6510, Ricoh device]
Date: Wed, 14 Jul 2010 12:33:26 -0700
Message-ID: <20100714123326.8d76306b.akpm@linux-foundation.org>
References: <bug-16390-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34450 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753236Ab0GNTgg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 15:36:36 -0400
In-Reply-To: <bug-16390-10286@https.bugzilla.kernel.org/>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, oyvinst@ifi.uio.no


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 14 Jul 2010 19:13:33 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=16390
> 
>            Summary: Memory card reader does not function [Dell Latitude
>                     E6510, Ricoh device]
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.35
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: MMC/SD
>         AssignedTo: drivers_mmc-sd@kernel-bugs.osdl.org
>         ReportedBy: oyvinst@ifi.uio.no
>         Regression: No
> 
> 
> Memory card reader reports the following during boot:
> 
> [    3.018008] mmc0: Unknown controller version (2). You may experience
> problems.
> 
> When inserting a Mini-SD card inside an SD-adapter, it is /not/ mounted, and
> the following appears in the kernel log:
> 
>   724.044751] mmc0: ADMA error
> [  724.046769] mmc0: Got data interrupt 0x02000000 even though no data
> operation was in progress.
> [  724.046774] sdhci: ============== REGISTER DUMP ==============
> [  724.046782] sdhci: Sys addr: 0x00000000 | Version:  0x00000402
> [  724.046789] sdhci: Blk size: 0x00007008 | Blk cnt:  0x00000001
> [  724.046796] sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
> [  724.046803] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000011
> [  724.046810] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
> [  724.046817] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
> [  724.046824] sdhci: Timeout:  0x0000000a | Int stat: 0x00000000
> [  724.046831] sdhci: Int enab: 0x02ff00cb | Sig enab: 0x02ff00cb
> [  724.046838] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
> [  724.046845] sdhci: Caps:     0x21e832b2 | Max curr: 0x00000040
> [  724.046852] sdhci: ADMA Err: 0x00000001 | ADMA Ptr: 0x0224a050
> [  724.046854] sdhci: ===========================================
> [  724.047879] mmc0: error -5 whilst initialising SD card
> 
> 
> 
> PCI device info:
> 04:00.1 SD Host controller [0805]: Ricoh Co Ltd Device [1180:e822] (rev 03)
> (prog-if 01)
>         Subsystem: Dell Device [1028:040b]
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin B routed to IRQ 19
>         Region 0: Memory at d5930000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0
> Enable-
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [78] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME+
>         Capabilities: [80] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> unlimited, L1 unlimited
>                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr-
> TransPend-
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency
> L0 <4us, L1 <64us
>                         ClockPM+ Suprise- LLActRep- BwNot-
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain-
> CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
> DLActive- BWMgmt- ABWMgmt-
>         Kernel driver in use: sdhci-pci
>         Kernel modules: sdhci-pci
> 
> Hardware:
> Dell Latitude E6510 laptop.
> 
> Didn't work in default Ubuntu 10.04 2.6.32-based kernel, and still doesn't work
> in 2.6.35-rc it seems.
> 

