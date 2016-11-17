From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/9] mmc: core: Re-work CMD13 polling method for CMD6 for mmc
Date: Thu, 17 Nov 2016 10:06:32 +0100
Message-ID: <CACRpkdaWnwY+gty9bCZhpGtzcjpAz5Z8nqS9HT+pb+LHtcPRXw@mail.gmail.com>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35456 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbcKQJGe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 04:06:34 -0500
Received: by mail-qk0-f170.google.com with SMTP id n204so210010301qke.2
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2016 01:06:33 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On Wed, Nov 16, 2016 at 11:51 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> To improve this behaviour and shorten the card initialization time, we need to
> allow using CMD13 as polling method to find out when the card stops signaling
> busy. Although, enabling CMD13 polling may also introduce other issues as
> according to the JEDEC spec, it's not the recommended method. Especially it
> mentions that CRC errors may be triggered when sending a CMD13 command during a
> bus timing change.
>
> To deal with these issues, we need to change from ignoring those CRC errors but
> instead continue to treat the card as being busy and continue to poll with
> CMD13. Perhaps this behaviour is one of reasons to why the earlier CMD13 polling
> method didn't work out well.
>
> This series requires extensive testing, please help with that!

I cloned the MMC tree "next" and applied the patches on top.

(I guess if you want wider testing it's good to publish a branch,
but I'd recommend just putting it into linux-next, it seems solid
to me.)

Tested on my previously problematic APQ8060 Dragonboard, it switches
to highspeed and works like a charm! Now the eMMC comes up smacky
right after registering the host:

[    1.955105] mmci-pl18x 12400000.sdcc: mmc0: PL180 manf 51 rev0 at
0x12400000 irq 197,0 (pio)
[    1.955149] mmci-pl18x 12400000.sdcc: DMA channels RX none, TX none
[    1.964202] mmci-pl18x 12400000.sdcc: Voltage switch failed
[    2.031744] mmci-pl18x 12180000.sdcc: Got CD GPIO
[    2.031829] mmci-pl18x 12180000.sdcc: Got WP GPIO
[    2.040263] mmci-pl18x 12180000.sdcc: DMA channels RX none, TX none
[    2.094161] mmc0: new high speed MMC card at address 0001
[    2.095590] mmcblk0: mmc0:0001 SEM04G 3.69 GiB
[    2.120905] mmcblk0boot0: mmc0:0001 SEM04G partition 1 1.00 MiB
[    2.133068] mmcblk0boot1: mmc0:0001 SEM04G partition 2 1.00 MiB
[    2.139657] mmcblk0rpmb: mmc0:0001 SEM04G partition 3 128 KiB
[    2.158004]  mmcblk0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11 p12 p13
p14 p15 p16 p17 p18 p19 p20 p21 >

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
