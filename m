From: Panagiotis Papadakos <papadako@ics.forth.gr>
Subject: SONY CR21Z MMC problem
Date: Wed, 25 Apr 2012 14:31:23 +0300
Message-ID: <17808456.kG7zSea45C@cray-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgate-4.ics.forth.gr ([139.91.1.7]:31085 "EHLO
	mailgate-4.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758589Ab2DYLot (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 07:44:49 -0400
Received: from av1.ics.forth.gr (smtp-out.ics.forth.gr. [139.91.1.71])
	by mailgate-4.ics.forth.gr (8.14.5/ICS-FORTH/V10-1.9-GATE-OUT) with ESMTP id q3PBVTJ8044177
	for <linux-mmc@vger.kernel.org>; Wed, 25 Apr 2012 14:31:31 +0300 (EEST)
Received: from cray-7.localnet (athedsl-4471500.home.otenet.gr [94.71.122.188])
	(authenticated bits=0)
	by enigma.ics.forth.gr (8.14.3//ICS-FORTH/V10.3.0C-EXTNULL-SSL-SASL) with ESMTP id q3PBVSev011550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mmc@vger.kernel.org>; Wed, 25 Apr 2012 14:31:29 +0300
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello.

I am using the latest git kernel code and I can't get my MMC work
with the tifm_7xx1 module.

lspci -vv reports:

08:07.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card 
Reader (SD/MMC/MS/MS PRO/xD)
        Subsystem: Sony Corporation Device 9015
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at fc101000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: tifm_7xx1
        Kernel modules: tifm_7xx1

Can anybody help?

Thank you in advance.

