From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: SDIO wifi card is not detected with 4.5-rc kernels
Date: Wed, 17 Feb 2016 19:06:07 +0100
Message-ID: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35857 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423530AbcBQSGJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 13:06:09 -0500
Received: by mail-wm0-f54.google.com with SMTP id g62so173681054wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 17 Feb 2016 10:06:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

The SDIO wifi card is not detected in my Baytrail tablet with 4.5-RC kernels,
which worked fine with pre-4.5 kernels.

Kernel v4.0-4.4 versions worked nicely:

$ grep mmc dmesg-4.4.0-rc2-next-20151127.txt
[    2.421329] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    2.425847] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    2.431164] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[    2.561342] mmc0: MAN_BKOPS_EN bit is not set
[    2.569496] mmc0: new HS200 MMC card at address 0001
[    2.571164] mmcblk0: mmc0:0001 032GE4 29.1 GiB
[    2.571453] mmcblk0boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
[    2.571655] mmcblk0boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
[    2.571863] mmcblk0rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
[    2.573835]  mmcblk0: p1 p2 p3 p4 p5 p6
[    2.647372] mmc1: new high speed SDIO card at address 0001
[    2.812340] mmc2: new high speed SDXC card at address 0001
[    2.812719] mmcblk1: mmc2:0001 00000 59.6 GiB

With v4.5:

$ grep mmc dmesg-4.5.0-rc4.txt
[    2.678828] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
[    2.683332] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
[    2.705315] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
[    2.850013] mmc2: new high speed SDXC card at address 0001
[    2.858675] mmcblk0: mmc2:0001 00000 59.6 GiB
[    2.871384] mmc0: MAN_BKOPS_EN bit is not set
[    2.883166] mmc0: new HS200 MMC card at address 0001
[    2.883725] mmcblk1: mmc0:0001 032GE4 29.1 GiB
[    2.884029] mmcblk1boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
[    2.884322] mmcblk1boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
[    2.884518] mmcblk1rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
[    2.886442]  mmcblk1: p1 p2 p3 p4 p5 p6

Notice that the following line is missing with v4.5:

mmc1: new high speed SDIO card at address 0001

And of course the out-of-tree wifi driver (rtl8723bs) cannot find the
hardware with kernel v4.5.

The hardware is a Teclast X80h Baytrail tablet.
Cpu:  Intel(R) Atom(TM) CPU  Z3735F

I've opened a bug report for it:
https://bugzilla.kernel.org/show_bug.cgi?id=112571

The full dmesg of 4.5-rc4 is available in the bug report.

Bye,
Laszlo Fiat
