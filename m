Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905BCC11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795EC6142B
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbhF3OXg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbhF3OXe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 10:23:34 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222D7C061766
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 07:21:04 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id v12so1763800vsg.10
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul+xfgqMRCF8BIHYL3fuS5RV/KFPrPSsd3KoauRtG+E=;
        b=g1/Yz7J7EbTwoG2FKUYTMNDjHw+J0zuJngzLKCwBAi92YOaR1H/rH1Aimab0guY8m9
         HL/RTgwaI2Pnx4QodfDqzcVF+2fVtDzDjgzxvrWp43H85z8lJcKW4y0ZAJujo4vS844T
         kNdioF3dVQG6vf2b+LRTRYXBY6PtwEEjEs0UjWFreSepzJaqTWsDKGrZq0rRq8OspE7M
         34m4qoTX3DwPYz3H9ab6koTkroo3lby4TQi3BmjealppKuiQrgn1P9pAlFhN5dgo0KPX
         vFVDgL04i/qvHMuCRfwbhiArPVr37rvlk4i2Hi3CrR9v2MdhEQH6F9jJFOQJ5nDLSyot
         iJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul+xfgqMRCF8BIHYL3fuS5RV/KFPrPSsd3KoauRtG+E=;
        b=NZQEdIuRbv25kotzKKId9KYmV1N8XXB33PU3qvXyilPac3c5JRZ1nQ3RMMRjbqYe54
         Dalu8U8KlIw5gznEAON0hgrCz5PV9ovn5AiQknT+Wvh2XCKPxX2KIa3LMoANyMVo1DA8
         YGPVguGkmkIma0Ial26WHibAY5ukYfg3/kncA7gerLQK7SbJlZALa+Vn4ck7E+z2SHqQ
         9abADTkzFWDHC+qwxQZrbOrdbV2PJhWjKr5y7I1T0NO+hxCUSpYPFunlR7VrWlMvSZdN
         E1hagfJHFGtvS3LMFpi9mI6rg0GgbjZaYKX4MngZOqaAB1KiiBc5nnAcpdZAvsee3n1i
         8vXA==
X-Gm-Message-State: AOAM531uEtNzKLnXg02fj08YqqVfpjHskJOViC+RXzy33tpCp0QNVI9f
        YbHKNtbJtgM2i7Oz11r/g7XpEZrfhN5LaIK4Yn/O0g==
X-Google-Smtp-Source: ABdhPJwSZ0Nw8q+87tEXQ8Kz1ZEXL/lCsklv41CrRimd986bvtdFFmZpnkAGKH67f1m9IPzvusrw7mFjxJzIYXr5/E8=
X-Received: by 2002:a67:8783:: with SMTP id j125mr7711177vsd.42.1625062863038;
 Wed, 30 Jun 2021 07:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210624163045.33651-1-alcooperx@gmail.com>
In-Reply-To: <20210624163045.33651-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 16:20:26 +0200
Message-ID: <CAPDyKFqwrX64W8t-PYrN-JYTttu6Bsfg40abPOOYFdZqDH0qMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in
 HS400 mode
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Jun 2021 at 18:31, Al Cooper <alcooperx@gmail.com> wrote:
>
> When an eMMC device is being run in HS400 mode, any access to the
> RPMB device will cause the error message "mmc1: Invalid UHS-I mode
> selected". This happens as a result of tuning being disabled before
> RPMB access and then re-enabled after the RPMB access is complete.
> When tuning is re-enabled, the system has to switch from HS400
> to HS200 to do the tuning and then back to HS400. As part of
> sequence to switch from HS400 to HS200 the system is temporarily
> put into HS mode. When switching to HS mode, sdhci_get_preset_value()
> is called and does not have support for HS mode and prints the warning
> message and returns the preset for SDR12. The fix is to add support
> for MMC and SD HS modes to sdhci_get_preset_value().
>
> This can be reproduced on any system running eMMC in HS400 mode
> (not HS400ES) by using the "mmc" utility to run the following
> command: "mmc rpmb read-counter /dev/mmcblk0rpmb".
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

I assume we want this for stable kernels, but it would be nice to add
a fixes tag as well.

Do you know if there is a specific commit that this fixes?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bf238ade1602..6b39126fbf06 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>         u16 preset = 0;
>
>         switch (host->timing) {
> +       case MMC_TIMING_MMC_HS:
> +       case MMC_TIMING_SD_HS:
> +               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
> +               break;
>         case MMC_TIMING_UHS_SDR12:
>                 preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
>                 break;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..960fed78529e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -253,6 +253,7 @@
>
>  /* 60-FB reserved */
>
> +#define SDHCI_PRESET_FOR_HIGH_SPEED    0x64
>  #define SDHCI_PRESET_FOR_SDR12 0x66
>  #define SDHCI_PRESET_FOR_SDR25 0x68
>  #define SDHCI_PRESET_FOR_SDR50 0x6A
>
> base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
> --
> 2.17.1
>
