Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FBC433E9
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48D564E7B
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhBHPGg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 10:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhBHPFL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 10:05:11 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE6C06178B
        for <linux-mmc@vger.kernel.org>; Mon,  8 Feb 2021 07:04:30 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id c44so2769527uad.12
        for <linux-mmc@vger.kernel.org>; Mon, 08 Feb 2021 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jl1PZS6Z4xx6ic0CScHYnCftVci+4yGkziwnsAGCYoI=;
        b=cz6rcclIQelMUkfinCmu0NuCPhuVYHrGtze5sLLSgPjgCJyg+rSCmqs+30bCrV9PK1
         UJktsXblbQNfPlD0E8STVOJg1Ww39HKBWBYAd8+ThRD5TiqK5Jqe8LDGvUk9VrqzQnJJ
         /PS714l61/Kw+HfpJTy2DucqZjk5Sa979Tzibskl/8VwY7f7A9FO5SGHBcRyvZ4ijl+J
         lTHYITvQ3bf7d+hrn20jSByzgeEy/sNGa87AS5vKuy5SMflPGsRrmMjjIjVoTzEATlkb
         zXMHBnwQPGC3jxav5OlckrNEStmfEj+roppi2X255c0XxBNkPhlKcpjgZUvBt0fFqxfX
         /nWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jl1PZS6Z4xx6ic0CScHYnCftVci+4yGkziwnsAGCYoI=;
        b=GHFDbDUA9NgMWiC4cuoVQGJ82pCWjdm+z/5/crIBz7KgBje5RnDHrwsLem5ZLZu01W
         qCTi8taCVSjrTcnDIKDOnIVyT5pAECljUYhr8Hxj0JRbf28DKa9WEZOT7pQoU7LCOPr4
         4HVAEpU4pbGhnsEIZ/i/r4fvjqW/MGXXJBuOtLM6U2xezNrblLHLIHRGYa3veAUfaYfH
         5fSEz4SCYkChoiBsj09XG1/tpdL3B7IJsbo4hXewvR899VYeMdkaKSKzz2tAATib/LVr
         Xp/09c6jfVp1vIUAFbqq196wEYdJICA0Ta097Nxda4eAKowvoLvPq/3OFfJrZrZe8TSf
         cbOA==
X-Gm-Message-State: AOAM530tvJElfUtxQd2lMkw5SXRs5mCJkbV0dyYe1/6jEVd6p2WC2KrY
        m5bOgz48qyIOOlCLyD3eCTsj8JgzL5IUmUEvLerJLglvoWLve80d
X-Google-Smtp-Source: ABdhPJxdmmqm8yd6jaDr+v6FqBsRK/ZYOcQC+aRvXzq8qQbnJM/n8/zETFz2ZizJ8xD8URSFCgQD93lJBLwroLEjgs4=
X-Received: by 2002:ab0:3496:: with SMTP id c22mr10780274uar.100.1612796669681;
 Mon, 08 Feb 2021 07:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20210204120547.15381-1-yann.gautier@foss.st.com>
 <20210204120547.15381-2-yann.gautier@foss.st.com> <CAPDyKFqdtK33HSW_AM0s9172V=cBM6wnKuHubXSOGCVqJ8nzFg@mail.gmail.com>
 <e31df871-ae1a-7c80-d741-0813f90532c7@foss.st.com> <1c1814dc-f87b-ef5c-24b4-b9a6ec570dbc@foss.st.com>
In-Reply-To: <1c1814dc-f87b-ef5c-24b4-b9a6ec570dbc@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 16:03:53 +0100
Message-ID: <CAPDyKFq26Q3jwwJ71vp6s-+ux3jUnL6+m2FEzfi_gh5z8meqrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: mmci: enable MMC_CAP_NEED_RSP_BUSY
To:     Yann GAUTIER <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        ludovic.barre@foss.st.com,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 8 Feb 2021 at 13:16, Yann GAUTIER <yann.gautier@foss.st.com> wrote:
>
> On 2/5/21 1:19 PM, Yann GAUTIER wrote:
> > On 2/5/21 10:53 AM, Ulf Hansson wrote:
> >> - trimmed cc-list
> >>
> >> On Thu, 4 Feb 2021 at 13:08, <yann.gautier@foss.st.com> wrote:
> >>>
> >>> From: Yann Gautier <yann.gautier@foss.st.com>
> >>>
> >>> To properly manage commands awaiting R1B responses, the capability
> >>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for variants that
> >>> manage busy detection.
> >>> This R1B management needs both the flags MMC_CAP_NEED_RSP_BUSY and
> >>> MMC_CAP_WAIT_WHILE_BUSY to be enabled together.
> >>
> >> Would it be possible for you to share a little bit more about the
> >> problem? Like under what circumstances does things screw up?
> >>
> >> Is the issue only occurring when the cmd->busy_timeout becomes larger
> >> than host->max_busy_timeout. Or even in other cases?
> >>
> >>>
> >>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> >>> ---
> >>>   drivers/mmc/host/mmci.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >>> index 1bc674577ff9..bf6971fdd1a6 100644
> >>> --- a/drivers/mmc/host/mmci.c
> >>> +++ b/drivers/mmc/host/mmci.c
> >>> @@ -2148,7 +2148,7 @@ static int mmci_probe(struct amba_device *dev,
> >>>                  if (variant->busy_dpsm_flag)
> >>>                          mmci_write_datactrlreg(host,
> >>>
> >>> host->variant->busy_dpsm_flag);
> >>> -               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> >>> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
> >>> MMC_CAP_NEED_RSP_BUSY;
> >>
> >> This isn't correct as the ux500 (and likely also other legacy
> >> variants) don't need this. I have tried it in the past and it works
> >> fine for ux500 without MMC_CAP_NEED_RSP_BUSY.
> >>
> >> The difference is rather that the busy detection for stm32 variants
> >> needs a corresponding HW busy timeout to be set (its
> >> variant->busy_timeout flag is set). Perhaps we can use that
> >> information instead?
> >>
> >> Note that, MMC_CAP_NEED_RSP_BUSY, means that cmd->busy_timeout will
> >> not be set by the core for erase commands, CMD5 and CMD6.
> >>
> >> By looking at the code in mmci_start_command(), it looks like we will
> >> default to a timeout of 10s, when cmd->busy_timeout isn't set. At
> >> least for some erase requests, that won't be sufficient. Would it be
> >> possible to disable the HW busy timeout in some way - and maybe use a
> >> software timeout instead? Maybe I already asked Ludovic about this?
> >> :-)
> >>
> >> BTW, did you check that the MMCIDATATIMER does get the correct value
> >> set for the timer in mmci_start_command() and if
> >> host->max_busy_timeout gets correctly set in
> >> mmci_set_max_busy_timeout()?
> >>
> >> [...]
> >>
> >> Kind regards
> >> Uffe
> >>
> >
> > Hi Ulf,
> >
> > Thanks for the hints.
> > I'll check all of that and get back with updated patches.
> >
> > As I tried to explain in the cover letter and in reply to Adrian, I saw
> > a freeze (BUSYD0) in test 37 during MMC_ERASE command  with
> > SECURE_ERASE_ARG, when running this test just after test 36 (or any
> > other write test). But maybe, as you said that's mostly a incorrect
> > timeout issue.
> >
> > Regards,
> > Yann
>
> Hi,
>
> I made some extra tests, and the timeout value set in MMCIDATATIMER
> correspond to the one computed:
> card->ext_csd.erase_group_def is set to 1 in mmc_init_card()
> In mmc_mmc_erase_timeout(), we have:
> erase_timeout = card->ext_csd.hc_erase_timeout; // 300ms * 0x07 (for the
> eMMC card I have: THGBMDG5D1LBAIL
> erase_timeout *= card->ext_csd.sec_erase_mult; // 0xDC
> erase_timeout *= qty; // 32 (from = 0x1d0000, to = 0x20ffff)
>
> This leads to a timeout of 14784000ms (~4 hours).
> The max_busy_timeout is 86767ms.
>
> After those 4 hours, I get this message:
> mmc1: Card stuck being busy! __mmc_poll_for_busy

Okay, I see.

This means that we end up polling for busy in __mmc_poll_for_busy().
However, not by using CMD13 but rather with the ->card_busy() ops (as
mmci has this callback set).

Could it be that the ->card_busy() callback isn't working correctly
for the stm32 variant?

What happens if you temporarily drop the assignment of the
->card_busy() callback, thus force the mmc core to poll with CMD13
instead? Would this work?

>
> The second erase with MMC_ERASE_ARG finds an erase timeout of 67200ms,
> and uses R1B command.
> But as the first erase failed, the DPSMACT is still enabled, the busy
> timeout doesn't seem to happen. Something may be missing in the error path.

Assuming the eMMC card completed the first erase operation
successfully, then yes, the second erase should work.

However, what if the eMMC actually failed with the first erase? How can we know?

>
> Anyway, I'll push an update of the second patch of the series, and just
> drop this first one.
>
>
> Regards,
> Yann

Kind regards
Uffe
