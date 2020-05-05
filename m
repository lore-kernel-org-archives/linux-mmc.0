Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C4C47254
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 13:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482312078C
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6M4ixDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgEENOV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 09:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgEENOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 09:14:21 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125EBC061A10
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 06:14:21 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id b14so460283vkk.10
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsKPjiGD3v4nUxVeceFtJMoKp1s3SQbqenpM+1b5fpE=;
        b=Q6M4ixDU2PotV5YdJgoaS65scBDD6EAK+e/FJ2k1P714fM2+ma/nd5sp+bpfD27UVO
         2kOF/9ZAJFgzAKFeADd0tl29NS0TvsAh3YeCxegL5YSiVjF7ksh76GSUbvaUDqTX8uXh
         o9S/F0lMuVNGeszZH3z6ZofBBG1wX7LqQR6Scd2p98dIUlxRKKpJx0Yf8mIwC28JTX4r
         38nGUJEoUmUkwtPmtVrgDrX3SI3ZoEFcf5KoUF9GQUAlwZ/Oc3/7RgT/gHspux4FJccO
         4s/pqW1rIJtiHAEZiptpqSbPzaE3wp0fhO8/2DpcnjTSSlZLAs1b3k3HVHHlhAMSXD2H
         bVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsKPjiGD3v4nUxVeceFtJMoKp1s3SQbqenpM+1b5fpE=;
        b=a9n+psn1s4xZ7+Yts7Tz0PHZEisiwV0oMg47dN69lJdurkBtqBKmQWDdRGt941oanQ
         8GJbskB/DZau0BopkUSaBGswKU9RLmrNfoKXicH22So5UQ38UKWBuJKyd6vw6mtn0OzS
         P/bh3SaoIvI7WK9kdcfwXgAdbmbxEjH9UzEJkbMFW5Zd4oAgbUh7OGoiYrZ7cdmEfIzB
         jijJ06Dl1HOKS9eZXy/lYDSo1PW41d6C5ke/f5bd2q7HQk+OW73tugF4z1Hyrkdj3Hl5
         L4X5RUt3vRwSrL4F+OjZ6Ka/jAVmSyubhcbkTSCrUjfZSZZcVWnoOlQ23V/uwCwQJPWf
         CxQg==
X-Gm-Message-State: AGi0PuaScxj5wYeN14FH9XI4HorKJJk8UoCHr//ETDX/7r1q4wprkF8z
        J2oKrAn6yiNR6ZQXhdttIjahBDZstuqVvRlQFRFAvw==
X-Google-Smtp-Source: APiQypL23qkTilWzBqjmhYQagYrDFEGN5QpB7ggXhJdp6TA6imXwX7wzy+FyjvuNooK6Ym4XpnfNvG/wJBlCpSZu2PQ=
X-Received: by 2002:a1f:ff11:: with SMTP id p17mr2234355vki.25.1588684458767;
 Tue, 05 May 2020 06:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
 <1586835611-13857-2-git-send-email-yong.mao@mediatek.com> <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
 <1588066038.30914.28.camel@mhfsdcap03> <CAPDyKFrBd0E2Qy89JgTE3YH0iiXB7due0JmnSVAhYL5aubSczA@mail.gmail.com>
 <1588148417.10768.18.camel@mhfsdcap03>
In-Reply-To: <1588148417.10768.18.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 15:13:42 +0200
Message-ID: <CAPDyKFrtaCcFK+nRMH4wysA2ALguea8E+gdnr-CfQhQtpr5jdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: core: need do mmc_power_cycle in mmc_sdio_resend_if_cond
To:     "yong.mao@mediatek.com" <yong.mao@mediatek.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Apr 2020 at 10:21, yong.mao@mediatek.com
<yong.mao@mediatek.com> wrote:
>
> On Tue, 2020-04-28 at 14:13 +0200, Ulf Hansson wrote:
> > On Tue, 28 Apr 2020 at 11:28, yong.mao@mediatek.com
> > <yong.mao@mediatek.com> wrote:
> > >
> > >
> > > On Fri, 2020-04-24 at 12:09 +0200, Ulf Hansson wrote:
> > > > On Tue, 14 Apr 2020 at 05:40, Yong Mao <yong.mao@mediatek.com> wrote:
> > > > >
> > > > > From: yong mao <yong.mao@mediatek.com>
> > > > >
> > > > > When mmc_sdio_resned_if_cond is invoked, it indicates the SDIO
> > > > > device is not in the right state. In this condition, the previous
> > > > > implementation of mmc_sdio_resend_if_cond can't make sure SDIO
> > > > > device be back to idle state. mmc_power_cycle can reset the SDIO
> > > > > device by HW and also make sure SDIO device enter to idle state
> > > > > correctly.
> > > > >
> > > > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > > > > ---
> > > > >  drivers/mmc/core/sdio.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > > > > index ebb387a..ada0a80 100644
> > > > > --- a/drivers/mmc/core/sdio.c
> > > > > +++ b/drivers/mmc/core/sdio.c
> > > > > @@ -546,6 +546,7 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
> > > > >  static void mmc_sdio_resend_if_cond(struct mmc_host *host,
> > > > >                                     struct mmc_card *card)
> > > > >  {
> > > > > +       mmc_power_cycle(host, host->card->ocr);
> > > >
> > > > This looks wrong to me. mmc_sdio_resend_if_cond() is called from two places.
> > > >
> > > > 1. In the case when mmc_set_uhs_voltage() fails in
> > > > mmc_sdio_init_card(), which means a call to mmc_power_cycle() has
> > > > already been done.
> > > >
> > >   Thanks for your comment.
> > >   Yes. It is right that mmc_power_cycle() has already been done when
> > >   mmc_sdio_resend_if_cond() is called. In normal re-initialization case,
> > >   this mmc_power_cycle() (currently in 1.8v voltage and 208Mhz clock)
> > >   can make SDIO device really back to idle state. Unfortunately, in some
> > >   special SDIO device, it will enter to unstable state.
> > >
> > >   At this unstable state, device may keep data0 always low after receiving CMD11.
> > >   And then every other SDIO CMD can't be sent to device any more due to card
> > >   is busy(data0 is low). Therefore, previous implementation can't save the
> > >   device. At this time, mmc_power_cycle() may be the final solution to make
> > >   sure SDIO device can back to idle state correctly.
> >
> > Well, this still sounds a bit vague to me. I need to understand more
> > exactly under what circumstances the problem occurs.
> >
> > What platform are you testing with and what SDIO card is being used?
>  The platform information is mt8173 + Marvell sdio device + kernel-3.18

I see, thanks for sharing this information. Forward/backporting
against 3.18 is hard, perhaps impossible when it comes to this, sorry.

A lot of SDIO core parts, especially related to re-initialization and
power management have been changed since v3.18.

"git log --oneline v3.18..v5.7-rc4 drivers/mmc/core/sdio*" will tell you.

Would it be possible to move to a later kernel and test instead? I
mean, the problem may already have been solved!? mt8173 should be
rather well supported upstream, but perhaps lots are missing for the
SDIO parts?

>
> >
> > Is the problem happening during the system resume phase?
>   The problem happen when mmc_sdio_runtime_resume is invoked.
> >
> > Are the SDIO func driver using runtime PM and then is the host capable
> > of MMC_CAP_POWER_OFF_CARD?
> >
>   Yes. SDIO func driver uses runtime PM and MMC_CAP_POWER_OFF_CARD is
> enabled.

Alright, that explains the use case, thanks!

>
> > Is it easy to reproduce the problem for you?
> >
>  There are only two units out of many produced units that can always
> reproduce this issue.

An idea to possibly help to narrow down the problem, could be to
implement an "test SDIO func driver" and use that rather than the
mwifiex driver (which I assume is the one you are using?). Then we
could run various tests from it, like calling pm_runtime_get|put() for
example.

We already have a similar thing to replace the mmc/sd block device
driver, so this could be useful for testing SDIO cards/funcs I think.

>
> > >
> > > > 2. Wen sdio_read_cccr() fails and when we decide to retry the UHS-I
> > > > voltage switch. Then perhaps it could make sense to run a power cycle.
> > > > But if so, we better do it only for that path.
> > > >
> > > > I will continue to look a bit, as I think there are really more issues
> > > > that we may want to look into while looking at this piece of code.
> > > > However, allow me some more time before I can provide some more ideas
> > > > of how to move forward.
> > >   In the actual project, we do encounter many relative issues about re-initialized card.
> > >   The following two categories are the most common issue we met before.
> > >   A. the SDIO card is initialized by UHS-I mode at the first time, but will be
> > >      re-initialized by High Speed mode at the second time.
> > >      ==> All this type of issues is relative with S18A in response of CMD5.
> > >          And most of the issues are related to the interval between powering off and
> > >          powering on card.

This sounds a bit like the card gets re-initialized without it first
being properly power cycled.

Perhaps you call mmc_sw_reset() for a "test SDIO func driver", which
re-initializes the card, but without doing a power cycle. Then that
should give you the similar problem?

> > >   B. If there is something wrong in the flow of voltage switch(after CMD11), card will
> > >      always keep all data pins to low. And then it hangs up because data0 is always low.
> > >   Hope this information will be helpful for you.

I keep repeating myself, but there seems to be a problem with the
power cycling of the SDIO card.

> >
> > Thanks for sharing these details! I think we need to continue to debug
> > this issue, to fully understand.
> >
> > In principle, it sounds to me that maybe mmc_power_cycle(), isn't
> > really successfully power-cycling the SDIO card. Perhaps insert a few
> > delays or so in that code to see how that would affect things?
> >
> > Anyway, how is the power to the SDIO card controlled in this case? Are
> > you using a mmc-pwrseq?
> >
>   vmmc is controlled through GPIO to supply 3.3v power.
>   And the vqmmc is supplied from PMIC which is always 1.8v.
>   (There is no 3.3v here. Perhaps this is one of the reasons to happen
> this issues)

If it's the Marvell 8787/8897/8997 SDIO module you are using, you most
likely need a mmc-pwrseq to properly control the power to the SDIO
module. Perhaps that is what is missing?

See Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
and arch/arm/boot/dts/rk3288-veyron.dtsi for an example.

>
> > >
> > >   Anyway, we will wait for your advises.
> > > >
> > > > >         sdio_reset(host);
> > > > >         mmc_go_idle(host);
> > > > >         mmc_send_if_cond(host, host->ocr_avail);
> > > > > --
> > > > > 1.9.1
> > > >
> > > > Kind regards
> > > > Uffe
> >
> > I have a few patches in the pipe, which fixes some other problems in
> > mmc_sdio_init_card(). Possibly those can be related, but I need a day
> > or so to post them, let's see.
> The codebase of this project is kernel-3.18. Maybe it is hard to apply
> these new patches. Anyway, We will try it when we get the patches.
> Thanks.

As you are on a 3.18 kernel, the tests seem quite irrelevant, so I
wouldn't bother with the backports.

Kind regards
Uffe
