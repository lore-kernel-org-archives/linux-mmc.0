Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBFDC4338F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974DB60F6F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Aug 2021 11:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbhHDLfe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhHDLfe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2021 07:35:34 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B25C0613D5
        for <linux-mmc@vger.kernel.org>; Wed,  4 Aug 2021 04:35:21 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id b138so828162vsd.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2021 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFmNv8bWnnhaUEfEbtd/dIDab8KFB9ZFGv6zOrp9yb4=;
        b=iu0kyRPpYLdd/jKrXz1byoUVslMvTNXKDP5os4v7jpIA9Q4eZ9ui2ItYYzm14Ep4dl
         ovQWvTdkAoGV/HM55AZMcYojzijUvBsmwjyLPGu0ajgS9yg+HSdYM/DjDuTE17r2kwku
         A+KsLof1HDrPTHh9X4WNRSZ47BKMaPTBXgjUPbKDxD5p3F1e9ikCH9SB/1sGkt0AhztT
         M73vqhZO16i6VffkAeO6/HB5YHRQsL1u+GxNm9q+8l7dx+BQdsx+PgRnG85naHFHwF+S
         Txfpfm+vz2kG5lnH4z1nUXucc4va+QumoW539vaWHuhUsrmG7osUGfM8sVu4nHtsY2kb
         9xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFmNv8bWnnhaUEfEbtd/dIDab8KFB9ZFGv6zOrp9yb4=;
        b=htvBeVbHtby1ECzMRTEqFViPmmYtDSw7pmrGwylFuXxBpj1UfIX527Ir2DNVmsPHkF
         eneHKmPzknf7QLzyLe9UInbzevbvYMvF3YUvud18y6rviSOY6jMIfRqokuw3GcQzfAlC
         /dTtR/5zBF5//0V7wUmXSjRe01KMFLHc7mXWqZZFm7MCiTKuxVcIpephUme9clIqXCqA
         5XCzxCeNulkfJcKfDiPkiXZUsXNYo120t76WsZ2/CAPMtu8M8iYA1HBcIS4207tms3Z7
         zp+4VFTbAgSvMA4IYj47nJQA6GcifjZnkRxL2nAnJ7P+kIaZecQ423W9htgQ3BNAkYjF
         //JA==
X-Gm-Message-State: AOAM531Y/VbNYmoq8Z4NG5FfzDe66YyPQn5dkYkwtuNe1kDqialMhf3B
        AuD8NFM7YUbN+r3Gn5Xj7/duAB4dvAB3swE1qAu7Mg==
X-Google-Smtp-Source: ABdhPJyCx3nRY/4KqOLvHiEA42E1G/VVl/48vDkQI4N1BE+4zhkOavjC4jVwnhhJLmbbutkiekBOZaTnqYfqHAut40o=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr9769573vsc.42.1628076920860;
 Wed, 04 Aug 2021 04:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210701143353.13188-1-yann.gautier@foss.st.com>
In-Reply-To: <20210701143353.13188-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:44 +0200
Message-ID: <CAPDyKFoCABbyKaejhzAqM9hv7Emg4WyfbtORoW_XMnmoxKSVAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: check when the voltage switch procedure
 should be done
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 1 Jul 2021 at 16:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> If the card has not been power cycled, it may still be using 1.8V
> signaling. This situation is detected in mmc_sd_init_card function and
> should be handled in mmci stm32 variant.
> The host->pwr_reg variable is also correctly protected with spin locks.
>
> Fixes: 94b94a93e355 ("mmc: mmci_sdmmc: Implement signal voltage callbacks")
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 51db30acf4dc..fdaa11f92fe6 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -479,8 +479,9 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
>         u32 status;
>         int ret = 0;
>
> -       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 &&
> +           host->pwr_reg & MCI_STM32_VSWITCHEN) {
>                 mmci_write_pwrreg(host, host->pwr_reg | MCI_STM32_VSWITCH);
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> @@ -492,9 +493,11 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
>
>                 writel_relaxed(MCI_STM32_VSWENDC | MCI_STM32_CKSTOPC,
>                                host->base + MMCICLEAR);
> +               spin_lock_irqsave(&host->lock, flags);
>                 mmci_write_pwrreg(host, host->pwr_reg &
>                                   ~(MCI_STM32_VSWITCHEN | MCI_STM32_VSWITCH));
>         }
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         return ret;
>  }
> --
> 2.17.1
>
