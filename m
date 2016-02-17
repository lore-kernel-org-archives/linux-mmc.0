From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: SDIO wifi card is not detected with 4.5-rc kernels
Date: Wed, 17 Feb 2016 21:18:19 +0000
Message-ID: <20160217211818.GI19428@n2100.arm.linux.org.uk>
References: <CA+7w51i3Kf2Jm=AXP5QhDj_8ZmzhUowbwwNEtu8UgiNkWwMYxg@mail.gmail.com>
 <CAOMZO5DzhVMaE76Y_ZVzRMpCMyovSs4seWXKyCqeA9f=nb2CJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59067 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422654AbcBQVS1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 16:18:27 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5DzhVMaE76Y_ZVzRMpCMyovSs4seWXKyCqeA9f=nb2CJg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>
Cc: Laszlo Fiat <laszlo.fiat@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Feb 17, 2016 at 04:41:04PM -0200, Fabio Estevam wrote:
> On Wed, Feb 17, 2016 at 4:06 PM, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
> > Hello,
> >
> > The SDIO wifi card is not detected in my Baytrail tablet with 4.5-RC kernels,
> > which worked fine with pre-4.5 kernels.
> >
> > Kernel v4.0-4.4 versions worked nicely:
> >
> > $ grep mmc dmesg-4.4.0-rc2-next-20151127.txt
> > [    2.421329] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
> > [    2.425847] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
> > [    2.431164] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
> > [    2.561342] mmc0: MAN_BKOPS_EN bit is not set
> > [    2.569496] mmc0: new HS200 MMC card at address 0001
> > [    2.571164] mmcblk0: mmc0:0001 032GE4 29.1 GiB
> > [    2.571453] mmcblk0boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
> > [    2.571655] mmcblk0boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
> > [    2.571863] mmcblk0rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
> > [    2.573835]  mmcblk0: p1 p2 p3 p4 p5 p6
> > [    2.647372] mmc1: new high speed SDIO card at address 0001
> > [    2.812340] mmc2: new high speed SDXC card at address 0001
> > [    2.812719] mmcblk1: mmc2:0001 00000 59.6 GiB
> >
> > With v4.5:
> >
> > $ grep mmc dmesg-4.5.0-rc4.txt
> > [    2.678828] mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
> > [    2.683332] mmc1: SDHCI controller on ACPI [INT33BB:00] using ADMA
> > [    2.705315] mmc2: SDHCI controller on ACPI [80860F14:02] using ADMA
> > [    2.850013] mmc2: new high speed SDXC card at address 0001
> > [    2.858675] mmcblk0: mmc2:0001 00000 59.6 GiB
> > [    2.871384] mmc0: MAN_BKOPS_EN bit is not set
> > [    2.883166] mmc0: new HS200 MMC card at address 0001
> > [    2.883725] mmcblk1: mmc0:0001 032GE4 29.1 GiB
> > [    2.884029] mmcblk1boot0: mmc0:0001 032GE4 partition 1 4.00 MiB
> > [    2.884322] mmcblk1boot1: mmc0:0001 032GE4 partition 2 4.00 MiB
> > [    2.884518] mmcblk1rpmb: mmc0:0001 032GE4 partition 3 4.00 MiB
> > [    2.886442]  mmcblk1: p1 p2 p3 p4 p5 p6
> >
> > Notice that the following line is missing with v4.5:
> >
> > mmc1: new high speed SDIO card at address 0001
> >
> > And of course the out-of-tree wifi driver (rtl8723bs) cannot find the
> > hardware with kernel v4.5.
> >
> > The hardware is a Teclast X80h Baytrail tablet.
> > Cpu:  Intel(R) Atom(TM) CPU  Z3735F
> >
> > I've opened a bug report for it:
> > https://bugzilla.kernel.org/show_bug.cgi?id=112571
> >
> > The full dmesg of 4.5-rc4 is available in the bug report.
> 
> I noticed the same on a imx6q-cubox-i board: the Broadcom Wifi chip
> could not be detected with 4.5-rc.
> 
> Haven't had a chance to debug this yet.

Looks strange - my patch series was tested on Hummingboards and
Armada38x, though that was before 4.4.  The Hummingboards have
the same Broadcom wifi chip(s) as the Cubox-i, and they worked
fine with my original set patches - here's 4.4-rc6 on a
Hummingboard:

[    0.000000] Linux version 4.4.0-rc6+ (rmk@rmk-PC.arm.linux.org.uk) (gcc version 4.7.4 (GCC) ) #1972 SMP Sat Jan 2 18:55:35 GMT 2016
[    5.158107] brcmfmac: F1 signature read @0x18000000=0x16044330
[    5.528484] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jan 23 2013 17:47:32 version 5.90.195.114 FWID 01-f9e7e464
[    5.567722] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[    5.629961] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code

Since then, I rebased my patch series on 4.5-rc1 before re-posting
it - though I didn't test it on the Wifi capable HBs, but now that I
try, I find that there's more serious issues here: the SDHCI driver
doesn't even probe the device, returning -ENODEV.  So, something _else_
has broken in SDHCI/MMC for the Broadcom WIFI here - tracing through
the code seems to point at the pwrseq stuff being the culpret:

[   52.175162] match->alloc failed: -517
[   52.178874] sdhci-esdhc-imx 2190000.usdhc: mmc_of_parse failed: -517
[   52.185271] sdhci-esdhc-imx 2190000.usdhc: imx probe failed

-517 is -EPROBE_DEFER, and looking at what's in the clk_summary
debugfs file, my guess is that the clk_sdio gpio-gate-clock is not
being registered for some unknown reason.  Adding Michael - any
ideas why gpio-gate-clock has stopped working between 4.4 and
present?

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
