Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9201EC433DB
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425C464E62
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbhCCBqi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349604AbhCBKml (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:42:41 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A204C061A29
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:40:39 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id j188so4291677vke.13
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs3aFYj5lDwWpMkhgX+vmRNoLw6eyqE+e72Cvwu8vBk=;
        b=ToEs2IVLIl0MtkeQXFndYK8lCO+lXPNZFM3errsVl5pQqRpY7LrHelfh1FFvgGvYBp
         0gqhijGNEGXqGl1T0K3/N53d2mVVhXeaWYSsgjhT0ZJzpG+gmbmT0JurcWaSyaLzZOpi
         8LtvYAq81Q0DpIEah8otXb8gryswM8KFpelDADsolgqYkV+SShg5kbE4U3XUY0EApSrQ
         3ACWW+2qOPu7/FPnQEYQSD5qTWBDNJK3NXXin6TA3Jnlob3mJwpewe7AdubCXb17Sv/R
         jXQ9Kyl7aRiV1woyMDdsjBe5eH1Ek7fdZm2YUp9wVd9kpx2c/LRFDYHT+WRT2gyT/F4E
         FF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs3aFYj5lDwWpMkhgX+vmRNoLw6eyqE+e72Cvwu8vBk=;
        b=bYTz+67pW+L+2vvQ5ZLayYwpkkR0cpLSuX9dMPTaKW1VgsFC+xPEmufHXM9eyreq+F
         FD+GEPquWd0LoWqT3aVRXV/TETtiZeHVHF7IzL84u5CaztnFRlQFTERR2npr2suNQ+hG
         drVJwThk2FsTLyfvht97ywKitzDEk00ZBOig/saJotByPEcngGoJhfzCqpQXfL5Uk0Nb
         lB/bbX+bHjcZ89iHurUwh1GIPCRBylzC9+fPEJd9Tb9ArI+257mlWzsNIeBBuRl+b+nJ
         wXOj35LWDVqjIUZtLgWwuC93KksYm9gmmM0ezzpx2bO1urRXKR7SlIkc4uc4E2B/pRN4
         A1rg==
X-Gm-Message-State: AOAM530UR3HSrWBsOGwXYM81Cl6d7r2n65T4a4sIMxC6tNrD6pVAFat7
        meLE4p60z3W4zjmH/2buPgAWX2l11+v/9xv8BpXFzw==
X-Google-Smtp-Source: ABdhPJxYFL17WoK6xDGbyRm9sJUh1M3Fmjg8cvD8NbL+WhqWEHetCeB7mvwoOHS5jK5CbyPdRi8GrPSEvMZdOOHYOu0=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr1850179vke.6.1614681638153;
 Tue, 02 Mar 2021 02:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20210225145454.12780-1-yann.gautier@foss.st.com>
In-Reply-To: <20210225145454.12780-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:40:02 +0100
Message-ID: <CAPDyKFo-98OWNg4QJ1cgY2QwYFB9d-6tVrMs0RYt6-=cU3-73w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_CAP_NEED_RSP_BUSY for stm32 variant
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Feb 2021 at 15:55, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> To properly manage commands awaiting R1B responses, the capability
> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for stm32 variant.
> The issue was seen on STM32MP157C-EV1 board, with an erase command,
> with secure erase argument, letting the card stuck, possibly waiting
> for 4 hours before timeout.
>
> Fixes: 94fe2580a2f3 ("mmc: core: Enable erase/discard/trim support for all mmc hosts")
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> ---
> This is somehow a v2 for patch [1].
> Changes:
> - Only apply MMC_CAP_NEED_RSP_BUSY to stm32 variant
> - Cap the used timeout written to MMCIDATATIMER (when using
> MMC_CAP_NEED_RSP_BUSY, cmd->busy_timeout may be greater than
> host->max_busy_timeout)
>
>  [1] https://patchwork.kernel.org/project/linux-mmc/patch/20210204120547.15381-2-yann.gautier@foss.st.com/
>
>  drivers/mmc/host/mmci.c             | 8 +++++++-
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 17dbc81c221e..89e0e9ccfb71 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1242,7 +1242,13 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                 if (!cmd->busy_timeout)
>                         cmd->busy_timeout = 10 * MSEC_PER_SEC;
>
> -               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +               if (host->mmc->caps & MMC_CAP_NEED_RSP_BUSY &&
> +                   host->mmc->max_busy_timeout &&
> +                   cmd->busy_timeout > host->mmc->max_busy_timeout)

We are already within "if (host->variant->busy_timeout ....", a few
lines above, which means this can be simplified into:

if (cmd->busy_timeout > host->mmc->max_busy_timeout)

> +                       clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
> +               else
> +                       clks = (unsigned long long)cmd->busy_timeout * host->cclk;
> +
>                 do_div(clks, MSEC_PER_SEC);
>                 writel_relaxed(clks, host->base + MMCIDATATIMER);
>         }
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 51db30acf4dc..2ad577618324 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -522,6 +522,7 @@ void sdmmc_variant_init(struct mmci_host *host)
>
>         host->ops = &sdmmc_variant_ops;
>         host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
> +       host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;

To make it more clear that this is for variants having the
->busy_timeout flag set, I suggest to move this into mmci_probe().

>
>         base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
>         if (IS_ERR(base_dlyb))
> --
> 2.17.1
>

Well, I decided to help out a bit. I have amend the patch according to
the above and extended the commit message with some valuable
information, based upon our earlier discussions.

Patch is applied at my fixes branch with a stable tag, please have a
look, test and shout at me if there is something that looks wrong!

Thanks and kind regards
Uffe
