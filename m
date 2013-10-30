From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 4/8] sdhci: Use threaded IRQ handler
Date: Wed, 30 Oct 2013 12:30:52 -0700
Message-ID: <CAOesGMhLx8P5TOz7spejD6iHOm0TruoOJc=rCULw1m4M5sY2VA@mail.gmail.com>
References: <1382369157-16129-1-git-send-email-jeremie.samuel.ext@parrot.com>
	<1382369157-16129-5-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:50412 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab3J3Tax (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 15:30:53 -0400
Received: by mail-qc0-f169.google.com with SMTP id x12so1091154qcv.14
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 12:30:52 -0700 (PDT)
In-Reply-To: <1382369157-16129-5-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, =?ISO-8859-1?Q?Gr=E9gor_Boirie?= <gregor.boirie@parrot.com>, Matthieu Castet <matthieu.castet@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Hi,

On Mon, Oct 21, 2013 at 8:25 AM, Jeremie Samuel
<jeremie.samuel.ext@parrot.com> wrote:
> We only need atomic context to disable SDHCI interrupts, after that
> we can run in a kernel thread.
>
> Note that irq handler still grabs an irqsave spinlock, we'll deal
> with it in a subsequent patch.
>
> Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.
>
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>

It seems like this patch is causing problems on Marvell Dove (such as
SolidRun Cubox). I've bisected a boot issue on that hardware down on
linux-next.

A good boot without this patch (i.e. with this patch reverted)
contains two spurious interrupts at probe time, both of them with
timeout+error set.

Below is the output with MMC_DEBUG turned on. Given the proximity to
the merge window, if we can't sort this out I think I'd prefer to see
this patch merged and retargeted to 3.14...


Good boot without this patch:

[    0.962882] sdhci: Secure Digital Host Controller Interface driver
[    0.969045] sdhci: Copyright(c) Pierre Ossman
[    0.973375] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.979149] sdhci [sdhci_add_host()]: mmc0: Auto-CMD23 unavailable
[    0.985320] mmc0: no vqmmc regulator found
[    0.989396] mmc0: no vmmc regulator found
[    0.993409] sdhci: =========== REGISTER DUMP (mmc0)===========
[    0.999221] sdhci: Sys addr: 0x00000000 | Version:  0x00000000
[    1.005035] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.010840] sdhci: Argument: 0x00000000 | Trn mode: 0x00000001
[    1.016656] sdhci: Present:  0x017f0000 | Host ctl: 0x00000000
[    1.022461] sdhci: Power:    0x0000000c | Blk gap:  0x00000000
[    1.028275] sdhci: Wake-up:  0x00000000 | Clock:    0x00000100
[    1.034080] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[    1.039888] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
[    1.045701] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.051500] sdhci: Caps:     0x01e032b2 | Caps_1:   0x00000000
[    1.057313] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
[    1.063111] sdhci: Host ctl2: 0x00000000
[    1.067014] sdhci: ===========================================
[    1.073201] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width
0 timing 0
[    1.094119] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    1.114117] mmc0: SDHCI controller on f1092000.sdio-host
[f1092000.sdio-host] using DMA
[    1.122155] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    1.128750] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    1.134710] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    1.140953] mmc0: Unexpected interrupt 0x00008000.
[    1.145717] sdhci: =========== REGISTER DUMP (mmc0)===========
[    1.151516] sdhci: Sys addr: 0x00000000 | Version:  0x00000000
[    1.157313] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.163110] sdhci: Argument: 0x00000c00 | Trn mode: 0x00000001
[    1.168908] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000001
[    1.174705] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
[    1.180503] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
[    1.186300] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[    1.192099] sdhci: Int enab: 0x00ff0083 | Sig enab: 0x00ff0083
[    1.197903] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.203702] sdhci: Caps:     0x01e032b2 | Caps_1:   0x00000000
[    1.209499] sdhci: Cmd:      0x0000341a | Max curr: 0x00000000
[    1.215295] sdhci: Host ctl2: 0x00000000
[    1.219191] sdhci: ===========================================
[    1.225037] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
[    1.232144] mmc0: starting CMD52 arg 80000c08 flags 00000195
[    1.237807] ata1: SATA link down (SStatus 0 SControl F300)
[    1.243266] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    1.249503] mmc0: Unexpected interrupt 0x00008000.
[    1.254270] sdhci: =========== REGISTER DUMP (mmc0)===========
[    1.260069] sdhci: Sys addr: 0x00000000 | Version:  0x00000000
[    1.265866] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.271664] sdhci: Argument: 0x80000c08 | Trn mode: 0x00000001
[    1.277462] sdhci: Present:  0x01ff0000 | Host ctl: 0x00000001
[    1.283266] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
[    1.289064] sdhci: Wake-up:  0x00000000 | Clock:    0x00004007
[    1.294862] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[    1.300660] sdhci: Int enab: 0x00ff0083 | Sig enab: 0x00ff0083
[    1.306456] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.312255] sdhci: Caps:     0x01e032b2 | Caps_1:   0x00000000
[    1.318052] sdhci: Cmd:      0x0000341a | Max curr: 0x00000000
[    1.323848] sdhci: Host ctl2: 0x00000000
[    1.327745] sdhci: ===========================================


A bad boot with this patch applied instead only gives:

[    0.962875] sdhci: Secure Digital Host Controller Interface driver
[    0.969042] sdhci: Copyright(c) Pierre Ossman
[    0.973373] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.979146] sdhci [sdhci_add_host()]: mmc0: Auto-CMD23 unavailable
[    0.985318] mmc0: no vqmmc regulator found
[    0.989394] mmc0: no vmmc regulator found
[    0.993478] sdhci: =========== REGISTER DUMP (mmc0)===========
[    0.999290] sdhci: Sys addr: 0x00000000 | Version:  0x00000000
[    1.005104] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
[    1.010907] sdhci: Argument: 0x00000000 | Trn mode: 0x00000001
[    1.016715] sdhci: Present:  0x017f0000 | Host ctl: 0x00000000
[    1.022519] sdhci: Power:    0x0000000c | Blk gap:  0x00000000
[    1.028326] sdhci: Wake-up:  0x00000000 | Clock:    0x00000100
[    1.034139] sdhci: Timeout:  0x0000000e | Int stat: 0x00000000
[    1.039938] sdhci: Int enab: 0x00ff0003 | Sig enab: 0x00ff0003
[    1.045751] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
[    1.051550] sdhci: Caps:     0x01e032b2 | Caps_1:   0x00000000
[    1.057363] sdhci: Cmd:      0x00000000 | Max curr: 0x00000000
[    1.063161] sdhci: Host ctl2: 0x00000000
[    1.067064] sdhci: ===========================================
[    1.073351] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width
0 timing 0
[    1.094093] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21
width 0 timing 0
[    1.114093] mmc0: SDHCI controller on f1092000.sdio-host
[f1092000.sdio-host] using DMA
[    1.122130] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
[    1.128731] mmc0: starting CMD52 arg 00000c00 flags 00000195
[    1.134692] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    1.140936] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[    1.147183] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
[ ... repeat forever ]


-Olof
