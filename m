Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF15EC11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EEB6147D
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 15:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235508AbhF3Pal (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhF3Pal (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 11:30:41 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC17C061787
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 08:28:12 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id h5so173829vsg.12
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUWiDtJj6RLCmSbjVw2d2AiCqh7YRspmj66BCZBaYbI=;
        b=xJvjeBR0bkglNo1Ml3d8DB03lWqqJEgTLfwazL9G+kCGbFH5eX3XuY8ja9gyRSDwS/
         0nMTcziAgE3sbJJYC5HZXheFQaLSheRyYz/X2heLR+OpWON/oUgzyJZ020cpfjBfIEcZ
         ir7L4/wTjtbQ18XhJqV7D9uYXZV3PAoaH3Kt3+AoBzj0qu8n+9T/iBiugf/krC16XW+J
         Yxt0IlnH+uhOLjhqH7zy+9cGnaJZWZpKoyZljF26KDApg58x8ZR9wZq3fVeNJse1V/R/
         rrPjwRYzmur+Av3hZThM4HwG99lodaV0Ftpo8zqAGwvSKz+coZZ80Fn93D9+czUnXnF3
         V5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUWiDtJj6RLCmSbjVw2d2AiCqh7YRspmj66BCZBaYbI=;
        b=sgDT5JnKwOraksWj+0j8Wod28dW04u6mfGwCx2Vg1Y4Oz7zlDjlqvmMTGHUBMQF91L
         83fy9cN9p9xC4O8Pj0rJf/+0qpcHhmQXX+9UZOhADy0wO/8ceBCAU1W5rkCn1JnAmkJa
         7s88KbBAbWwIfO9gC1zvhjbf8Xry9tS39m+2a04GDO5A4SwRAUBmQYEyHs7Dnqk3DiuD
         g8pN+h7tKfwpc1VtdiljnDIlb2OqVElHC3JZQf1vHgQ6EEwKTD3/BbaF5iNaDtOt4JR6
         ULMnwWQhmrrjFmr7j9/7ix5etRvJxK+8bCid/bWQAMVLkOTC3Lw67HGcJIKAJ187WLIk
         MW0Q==
X-Gm-Message-State: AOAM533cyUD/51IMrdTKt6wBHZ2xFaeZz8KNHjSNM4lQ72UQDrtSSg9S
        RyT5hiT12Z+eUnjnHPFOAIr3oNiKNFvs/bl8BIIcBA==
X-Google-Smtp-Source: ABdhPJyEOTGfachURpgXYwFQwVJcnm05uDBGBEsBTBD4/wHhX/upCDNBWpA+ZrfaarCqvQIgMyZlft8Sr2mERuxoUVs=
X-Received: by 2002:a67:8783:: with SMTP id j125mr8158589vsd.42.1625066891402;
 Wed, 30 Jun 2021 08:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
 <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com>
 <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
 <CAPDyKFoj47-4XuKbV6jYkJ2pesAfHK999vudWDGTQA-J5eQXrg@mail.gmail.com> <CACRpkdYX5RiUy7u_SeCqhytbyL1Ta9iVmx500uwAq8sNmW+3Ug@mail.gmail.com>
In-Reply-To: <CACRpkdYX5RiUy7u_SeCqhytbyL1Ta9iVmx500uwAq8sNmW+3Ug@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 17:27:35 +0200
Message-ID: <CAPDyKForEi09uyXL4nDn27bth+btEYAhzd6+YusMrRBygCdtEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, phone-devel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>, newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Jun 2021 at 16:26, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jun 30, 2021 at 1:50 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > > We wait forever in mmc_wait_for_req_done() since the completion
> > > never arrives.
> >
> > Thanks for sharing these details. It looks like the mmci driver is
> > waiting for the busy completion IRQ, forever.
>
> Yep
>
> > Either the HW busy detection isn't working properly in mmci or the
> > eMMC card is behaving a bit odd (continues to deassert the DAT0 line
> > forever).
>
> Yep. I think the card is odd because I have this working fine on
> 3 other ux500 phones, this is the odd one out. I will try to check
> what eMMC is in the others as well.
>
> > What certainly is missing in the mmci driver, is a software based
> > timeout for cases like these. The mmci driver should better complete
> > the request with -ETIMEDOUT error for the cmd, rather than hanging
> > forever and waiting for the busy completion IRQ.
>
> That is true, it would make the driver more robust.
>
> > > I think you also mentioned the timeout in EXT_CSD maybe not being
> > > long enough? How do I play around with this?
> > > MMC_QUIRK_LONG_READ_TIME?
> >
> > As mmci doesn't care about busy timeouts, but waits forever, this is
> > likely not the problem.
> >
> > However, I would like to try to narrow down the problem even further.
> > Would you mind try the below debug patch?
>
> With this patch mmc2 comes up and I can mount and browse
> the eMMC.
>
> I think it is because these lines in mmci_cmd_irq() will not
> be executed:
>
>         /* Handle busy detection on DAT0 if the variant supports it. */
>         if (busy_resp && host->variant->busy_detect)
>                 if (!host->ops->busy_complete(host, status, err_msk))
>                         return;
>
> These seemed to be especially problematic to me.

Yes, exactly. The IRQ based busy detection code gets disabled with my
debug patch.

It looks like there are some race conditions in the HW busy detection
path for mmci, which gets triggered by this eMMC card.

>
> However the core can still use ->card_busy() at times?

It can and will.

Although, it's more optimal to receive an IRQ when busy on DAT0 is
de-asserted, rather than polling with ->card_busy(). Hence we also
have MMC_CAP_WAIT_WHILE_BUSY.

I will have another look at the code in mmci, to see if there is
something we can try to improve.

Kind regards
Uffe
