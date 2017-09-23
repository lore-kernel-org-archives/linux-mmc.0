From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2] mmc: core: apply NO_CMD23 quirk to an ATP card
Date: Sat, 23 Sep 2017 21:51:26 +0200
Message-ID: <1506196286.1683.7.camel@googlemail.com>
References: <1504998772.4004.2.camel@googlemail.com>
         <1505000687.23171.20.camel@googlemail.com>
         <CAPDyKFp5JJUp7Rec=eFZd_m9yVKbO91CNR_HbN+rpUm5KTYJgA@mail.gmail.com>
         <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34148 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdIWTva (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 23 Sep 2017 15:51:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so3969326wma.1
        for <linux-mmc@vger.kernel.org>; Sat, 23 Sep 2017 12:51:29 -0700 (PDT)
In-Reply-To: <27444e34-fcad-2244-5125-fc31a5755a12@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, info@atpinc.com

Hi Ulf and Shawn,

 thanks for your input, I'm replying to both of you by this mail, please
see comments below.

On Fri, 2017-09-22 at 17:26 +0800, Shawn Lin wrote:
> Hi
> 
> On 2017/9/22 16:42, Ulf Hansson wrote:
> > On 10 September 2017 at 01:44, Christoph Fritz <chf.fritz@googlemail.com> wrote:
> >> To get an ATP card work reliable on a high speed bus, CMD23 needs
> >> to be disabled.
> >>
> >> Without this patch:
> >>
> >>   $ dd if=/dev/urandom of=/mnt/test bs=1M count=10
> >>
> >>      <mmc0: starting CMD23 arg 00000400 flags 00000015>
> >>      mmc0: starting CMD25 arg 00a71f00 flags 000000b5
> >>      mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 3000 ms nsac 0
> >>      mmc0:     CMD12 arg 00000000 flags 0000049d
> >>      sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
> >>      mmc0: Timeout waiting for hardware interrupt.
> > 
> > Seems like you are using some sdhci variant. Would it be possible for
> > you to test this card on another platform? That to make sure it's not
> > a driver thing.

SoC am335x (omap_hsmmc) works fine because it lacks CMD23 host support.
My RK3288 board supports only micro-SD cards. If you want me to, I could
get an adapter (micro-SD -> SD) but the shipping takes ~40 days.

> > 
> 
> I'm just curious about if these ATP cards could work for ACMD23?
> 
> Could you kindly try this patch?
> 
> |https://patchwork.kernel.org/patch/9887651/

By looking at your patch I can see that bool variable 'need_acmd23' is
only set when card does not support CMD23. But here this card (falsely)
claims to support CMD23, which is the whole point of the NO_CMD23 quirk.

So testing your patch would not make any difference, because its
functionality would be disabled, or do I miss something?

> 
> 
> >>
> >> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> >> ---
> >> Changes since v1:
> >>   - s/CMD32/CMD23
> >>
> >>   drivers/mmc/core/card.h   | 1 +
> >>   drivers/mmc/core/quirks.h | 6 ++++++
> >>   2 files changed, 7 insertions(+)
> >>
> >> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> >> index f06cd91..af9c48c 100644
> >> --- a/drivers/mmc/core/card.h
> >> +++ b/drivers/mmc/core/card.h
> >> @@ -75,6 +75,7 @@ struct mmc_fixup {
> >>   #define EXT_CSD_REV_ANY (-1u)
> >>
> >>   #define CID_MANFID_SANDISK      0x2
> >> +#define CID_MANFID_ATP          0x9
> >>   #define CID_MANFID_TOSHIBA      0x11
> >>   #define CID_MANFID_MICRON       0x13
> >>   #define CID_MANFID_SAMSUNG      0x15
> >> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> >> index fb72593..3205f0e 100644
> >> --- a/drivers/mmc/core/quirks.h
> >> +++ b/drivers/mmc/core/quirks.h
> >> @@ -52,6 +52,12 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
> >>                    MMC_QUIRK_BLK_NO_CMD23),
> >>
> >>          /*
> >> +        * Some SD cards lockup while using CMD23 multiblock transfers.
> >> +        */
> >> +       MMC_FIXUP("AF SD", CID_MANFID_ATP, CID_OEMID_ANY, add_quirk_sd,
> >> +                 MMC_QUIRK_BLK_NO_CMD23),
> > 
> > Is really all ATP cards having this problem? Perhaps we should
> > consider making this a bit more fine grained?
> > 
> > On the other hand, this may be the safest way to do it...

I also thought about this and set CID_OEMID_ANY because I wanted to be
on the safe side. Maybe ATP can comment on this (in CC)?

Thanks
 -- Christoph

