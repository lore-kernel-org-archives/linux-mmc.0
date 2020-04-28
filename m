Return-Path: <SRS0=tofm=6M=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3921C83000
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 12:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D036E206D6
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Apr 2020 12:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5Sijg+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD1MOG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726448AbgD1MOG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2020 08:14:06 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB2C03C1A9
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2020 05:14:06 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z16so21017522uae.11
        for <linux-mmc@vger.kernel.org>; Tue, 28 Apr 2020 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si7QUx2lJaDXoOqwKRzvd/FqwJiW8O4bymVE3/8B3ns=;
        b=A5Sijg+k44OBG56boCW5SC8UnJ7ex3iO/soWNrUQ5voF2m/ptYSQIKN71PHSiPPkoO
         eigYpYxmn6IxQ9IL7wRTmGeXrXf71r2La7KtTzOtGIfY1YtExiSFtYxvPIXBiJfIovsD
         VOcBL9NUzfeaw+ldYSjxbBxWl8FO3zJGE8Tt/4pjWZqRZFxEhgYYLmK1ornUQMBAqnm0
         WTv3YzAb4txKP30dESYuDYf7O+vmvPoky1fidkQ52iKdlVE49UK6+Y9UvKgxjx7/kA8N
         EbUWenpXx5R1hjPo4LxyJaRTmL4Hf2L1g/UGjW8rCflH6my2LPpxPAQpUjZoU2WNixyw
         39aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si7QUx2lJaDXoOqwKRzvd/FqwJiW8O4bymVE3/8B3ns=;
        b=lXoNTcAh+P+Gr6rrOntgpn7I3ZKLCKHJPhCFxJpGTMoJGisC3NUqLOqsJXFWMxka6b
         tRswRpwhsH/3I1isPK+DpIHyYPInqvb8XDgycDo8HpgcKOXghFT/GtIkyNJlMHQngmEC
         4CsCbvbDR7Mn/RhUZuht+8CVSb3HknAvCSrOuSYnsOswvzFY290r7BlMhcxLvwpIEs1W
         uAY2oLedIfMQALnLxriQ9pn7xEbOWOBpS4Km90td2d1OWsAcy5KiueoRKGqHbElO1lhK
         Qsvk6WJ1Gjx/7164mAnR3lg5scdIphRD+5PGC8OTtFl1WfEtbLJlLN2GGvtJrq0U/VQN
         ldlA==
X-Gm-Message-State: AGi0PuY1OGvmMyA0TabYY6PKMSBl3lM104JA2wQMw6F/AGa55OkgrgJh
        stBeI62QZpiAU2T9Yw+Wn7RefDd85NqRpjvMQyA9iHgDrpc=
X-Google-Smtp-Source: APiQypLbHUMx3UMDbWJ6CNDiWmz1dbLLDJ3jr2Zb9fx7iExKVYW+P1I0WNBMwukiq/PNOP+qA0Yx6/Ewnd9S2sheWhk=
X-Received: by 2002:a67:f24b:: with SMTP id y11mr20631794vsm.165.1588076045066;
 Tue, 28 Apr 2020 05:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <1586835611-13857-1-git-send-email-yong.mao@mediatek.com>
 <1586835611-13857-2-git-send-email-yong.mao@mediatek.com> <CAPDyKFo40tBpowmWN3gxH8b=jMmCK8O5ALNQ7y6XZ5AosX=GUA@mail.gmail.com>
 <1588066038.30914.28.camel@mhfsdcap03>
In-Reply-To: <1588066038.30914.28.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Apr 2020 14:13:28 +0200
Message-ID: <CAPDyKFrBd0E2Qy89JgTE3YH0iiXB7due0JmnSVAhYL5aubSczA@mail.gmail.com>
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

On Tue, 28 Apr 2020 at 11:28, yong.mao@mediatek.com
<yong.mao@mediatek.com> wrote:
>
>
> On Fri, 2020-04-24 at 12:09 +0200, Ulf Hansson wrote:
> > On Tue, 14 Apr 2020 at 05:40, Yong Mao <yong.mao@mediatek.com> wrote:
> > >
> > > From: yong mao <yong.mao@mediatek.com>
> > >
> > > When mmc_sdio_resned_if_cond is invoked, it indicates the SDIO
> > > device is not in the right state. In this condition, the previous
> > > implementation of mmc_sdio_resend_if_cond can't make sure SDIO
> > > device be back to idle state. mmc_power_cycle can reset the SDIO
> > > device by HW and also make sure SDIO device enter to idle state
> > > correctly.
> > >
> > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > > ---
> > >  drivers/mmc/core/sdio.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > > index ebb387a..ada0a80 100644
> > > --- a/drivers/mmc/core/sdio.c
> > > +++ b/drivers/mmc/core/sdio.c
> > > @@ -546,6 +546,7 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
> > >  static void mmc_sdio_resend_if_cond(struct mmc_host *host,
> > >                                     struct mmc_card *card)
> > >  {
> > > +       mmc_power_cycle(host, host->card->ocr);
> >
> > This looks wrong to me. mmc_sdio_resend_if_cond() is called from two places.
> >
> > 1. In the case when mmc_set_uhs_voltage() fails in
> > mmc_sdio_init_card(), which means a call to mmc_power_cycle() has
> > already been done.
> >
>   Thanks for your comment.
>   Yes. It is right that mmc_power_cycle() has already been done when
>   mmc_sdio_resend_if_cond() is called. In normal re-initialization case,
>   this mmc_power_cycle() (currently in 1.8v voltage and 208Mhz clock)
>   can make SDIO device really back to idle state. Unfortunately, in some
>   special SDIO device, it will enter to unstable state.
>
>   At this unstable state, device may keep data0 always low after receiving CMD11.
>   And then every other SDIO CMD can't be sent to device any more due to card
>   is busy(data0 is low). Therefore, previous implementation can't save the
>   device. At this time, mmc_power_cycle() may be the final solution to make
>   sure SDIO device can back to idle state correctly.

Well, this still sounds a bit vague to me. I need to understand more
exactly under what circumstances the problem occurs.

What platform are you testing with and what SDIO card is being used?

Is the problem happening during the system resume phase?

Are the SDIO func driver using runtime PM and then is the host capable
of MMC_CAP_POWER_OFF_CARD?

Is it easy to reproduce the problem for you?

>
> > 2. Wen sdio_read_cccr() fails and when we decide to retry the UHS-I
> > voltage switch. Then perhaps it could make sense to run a power cycle.
> > But if so, we better do it only for that path.
> >
> > I will continue to look a bit, as I think there are really more issues
> > that we may want to look into while looking at this piece of code.
> > However, allow me some more time before I can provide some more ideas
> > of how to move forward.
>   In the actual project, we do encounter many relative issues about re-initialized card.
>   The following two categories are the most common issue we met before.
>   A. the SDIO card is initialized by UHS-I mode at the first time, but will be
>      re-initialized by High Speed mode at the second time.
>      ==> All this type of issues is relative with S18A in response of CMD5.
>          And most of the issues are related to the interval between powering off and
>          powering on card.
>   B. If there is something wrong in the flow of voltage switch(after CMD11), card will
>      always keep all data pins to low. And then it hangs up because data0 is always low.
>   Hope this information will be helpful for you.

Thanks for sharing these details! I think we need to continue to debug
this issue, to fully understand.

In principle, it sounds to me that maybe mmc_power_cycle(), isn't
really successfully power-cycling the SDIO card. Perhaps insert a few
delays or so in that code to see how that would affect things?

Anyway, how is the power to the SDIO card controlled in this case? Are
you using a mmc-pwrseq?

>
>   Anyway, we will wait for your advises.
> >
> > >         sdio_reset(host);
> > >         mmc_go_idle(host);
> > >         mmc_send_if_cond(host, host->ocr_avail);
> > > --
> > > 1.9.1
> >
> > Kind regards
> > Uffe

I have a few patches in the pipe, which fixes some other problems in
mmc_sdio_init_card(). Possibly those can be related, but I need a day
or so to post them, let's see.

Kind regards
Uffe
