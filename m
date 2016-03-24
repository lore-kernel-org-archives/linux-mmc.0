From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Thu, 24 Mar 2016 18:45:25 +0100
Message-ID: <CA+7w51gXWgfU0NzfKSkRtimgOH7v5G3TMTb8WNGg6GXg-xTf5w@mail.gmail.com>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38388 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbcCXRp1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 13:45:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id l68so76875957wml.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2016 10:45:26 -0700 (PDT)
In-Reply-To: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

The original issue I reported on 17 Feb is that the SDIO WIFI card is
not detected with 4.5RC and now mainline 4.5.0 kernel on baytrail
tablets.
BzukTuk commented on the bug report, that he has bisected the problem,
and found that reverting  patch
520bd7a8b4152aacfbd34eb7f7a447354b631039 ("mmc: core:
Optimize boot time by detecting cards simultaneously")  solves the problem.
I tested this, by compiling a 4.5.0 kernel with that patch reverted,
and the SDIO WiFi works that way.

Bye,
Laszlo Fiat

On Wed, Feb 17, 2016 at 7:06 PM, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
> Hello,
>
> The SDIO wifi card is not detected in my Baytrail tablet with 4.5-RC kernels,
> which worked fine with pre-4.5 kernels.
>
> Kernel v4.0-4.4 versions worked nicely:
>
> $ grep mmc dmesg-4.4.0-rc2-next-20151127.txt
> [    2.421329] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
> [    2.425847] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
> [    2.431164] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
> [    2.561342] mmc0: MAN_BKOPS_EN bit is not set
> [    2.569496] mmc0: new HS200 MMC card at address 0001
> [    2.571164] mmcblk0: mmc0:0001 032GE4 29.1 GiB
> [    2.571453] mmcblk0boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
> [    2.571655] mmcblk0boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
> [    2.571863] mmcblk0rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
> [    2.573835]  mmcblk0: p1 p2 p3 p4 p5 p6
> [    2.647372] mmc1: new high speed SDIO card at address 0001
> [    2.812340] mmc2: new high speed SDXC card at address 0001
> [    2.812719] mmcblk1: mmc2:0001 00000 59.6 GiB
>
> With v4.5:
>
> $ grep mmc dmesg-4.5.0-rc4.txt
> [    2.678828] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
> [    2.683332] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
> [    2.705315] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
> [    2.850013] mmc2: new high speed SDXC card at address 0001
> [    2.858675] mmcblk0: mmc2:0001 00000 59.6 GiB
> [    2.871384] mmc0: MAN_BKOPS_EN bit is not set
> [    2.883166] mmc0: new HS200 MMC card at address 0001
> [    2.883725] mmcblk1: mmc0:0001 032GE4 29.1 GiB
> [    2.884029] mmcblk1boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
> [    2.884322] mmcblk1boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
> [    2.884518] mmcblk1rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
> [    2.886442]  mmcblk1: p1 p2 p3 p4 p5 p6
>
> Notice that the following line is missing with v4.5:
>
> mmc1: new high speed SDIO card at address 0001
>
> And of course the out-of-tree wifi driver (rtl8723bs) cannot find the
> hardware with kernel v4.5.
>
> The hardware is a Teclast X80h Baytrail tablet.
> Cpu:  Intel(R) Atom(TM) CPU  Z3735F
>
> I've opened a bug report for it:
> https://bugzilla.kernel.org/show_bug.cgi?id=112571
>
> The full dmesg of 4.5-rc4 is available in the bug report.
>
> Bye,
> Laszlo Fiat
