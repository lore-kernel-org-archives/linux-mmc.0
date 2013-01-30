From: sandeep kumar <sandeep.kumar.dayal@gmail.com>
Subject: timeout error with jmb38x rev30
Date: Wed, 30 Jan 2013 10:33:12 +0530
Message-ID: <CAJHNB_9h3R9KhG0vevqtoxtE62ySVNMfAu3pgjwpNJNkhcq-zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56771 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab3A3FDN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 00:03:13 -0500
Received: by mail-qc0-f172.google.com with SMTP id b25so567774qca.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jan 2013 21:03:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,
   I am using an HP probook 4430 with Jmicron 38x rev30 Host
controller. I am using a sdio wlan card with 3.5.6 kernel and see
timeout errors when running heavy traffic.

   The MMC debug log is below.

Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533998] mmc0: starting
CMD53 arg 10002240 flags 000001b5
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534001] mmc0:
blksz 64 blocks 1 flags 00000200 tsac 1000 ms nsac 0
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534029] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534035] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534043] mmc0: req done
(CMD53): 0: 00002000 00000000 00000000 00000000
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534045] mmc0:     64
bytes transferred: 0
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534052] mmc0: starting
CMD53 arg 10002080 flags 000001b5
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534054] mmc0:
blksz 128 blocks 1 flags 00000200 tsac 1000 ms nsac 0
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534073] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.534077] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560607] mmc0: Timeout
waiting for hardware interrupt.
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560620] qqqqq 0,
21554, 682243, 72
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560624] sdhci:
=========== REGISTER DUMP (mmc0)===========
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560632] sdhci: Sys
addr: 0x00c100c0 | Version:  0x0000ad01
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560639] sdhci: Blk
size: 0x00007080 | Blk cnt:  0x00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560647] sdhci:
Argument: 0x10002080 | Trn mode: 0x00000013
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560654] sdhci:
Present:  0x01df0000 | Host ctl: 0x00000003
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560660] sdhci: Power:
  0x0000000f | Blk gap:  0x00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560668] sdhci:
Wake-up:  0x00000000 | Clock:    0x00000107
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560675] sdhci:
Timeout:  0x0000000d | Int stat: 0x00000002
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560682] sdhci: Int
enab: 0x02ff008b | Sig enab: 0x02ff008b
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560689] sdhci: AC12
err: 0x00000000 | Slot int: 0x00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560696] sdhci: Caps:
  0x054032b2 | Caps_1:   0x00000007
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560703] sdhci: Cmd:
  0x0000353a | Max curr: 0x00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560708] sdhci: Host
ctl2: 0x00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560710] sdhci:
===========================================
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560750] mmc0: req done
(CMD53): 0: 00002000 00000000 00000000 00000000
Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560754] mmc0:     0
bytes transferred: -110


In the logs above, we see the command complete interrupt, but the
transfer complete interrupt never reaches the mmc stack, but it can be
seen in the register dump above.
"Jan 30 01:41:12 HP-ProBook-4430s kernel: [ 3037.560675] sdhci:
Timeout:  0x0000000d | Int stat: 0x00000002"

Also with the addition of looping in  the sdhci interrupt handler, I
generally see the card interrupt causes a full loop to run as below,
but this is not seen in the failure case.
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533731] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533738] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533744] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533751] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533758] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533764] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533770] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533778] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533784] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533791] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533798] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533802] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533805] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533810] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533813] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100
Jan 30 01:41:02 HP-ProBook-4430s kernel: [ 3027.533818] sdhci
[sdhci_irq()]: *** mmc0 got interrupt: 0x00000100


Would be glad for some helpful pointers to resolve this. Would this be
a controller problem or the card since the card interrupt seems to
disappear at the failing cmd.

Thanks,
Sandeep.
