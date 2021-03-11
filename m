Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A60BC43619
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A5464FD0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhCKLuA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhCKLtj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 06:49:39 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F514C061574
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:39 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id g26so505483uam.9
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFTIqFdLWWdY29/pRWKsrCjVVaUcvjydilTqihigIMs=;
        b=cu4PSIOj96NZbIS+1jrpPVRxPh9/bAfihyDQaoU03m758Y6gyvh6OMia8ws4vOZcMc
         M7Qhx87oZNkO35S7goR6IRdaiTw0/19mhWGN6uPE1o2Iu3gJHmqkImd22aPQMWErZepZ
         Ant7OZm5qaFM6K9Ma9hfyUHxXTtOU+vaGGt8vpppf3zH2oFjMHclSozE1aQF7yMwEYxE
         2UXsFllf891X2O1C3xSRyFoAFNoIa4MY3eM5yFHnZlEycgare9N/5WQTgkZfUkGA5QB4
         T2CpILr5SH5dgP6n+RdqCQBY2wRpHUjge3bMbG96M9sUigQmcn6ZWwLhYN/aJKpqDhb1
         UNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFTIqFdLWWdY29/pRWKsrCjVVaUcvjydilTqihigIMs=;
        b=mROXv0zxBNXRG4vIWglv5/6Zbo91J4ErMEynKc8BeUniz2CB6jnIO+lzi6/0+y9P7O
         wDm3Y/vHumduXOe2cEbIHHrhmCtLIxvhavArdU4CI5JETeoibcDRAqDB7XpYmIERLsQs
         nal1oI02Ll4RJJKL5qeuoKjBta9bF0UEYEpQ148NdfCSfxXOsYqDCO6Envqsh9OumOyd
         HyZ4sS+hjUoioLa6ce8prhWHkotEDQhw2sSrtjxmPJ/fRtvCUkvttfsw/uDLrVS6dDz5
         tcDlZ4MNfJiDdyDp5Gvw76QuWZ+AJ1R8VfSkyHC3T+9tyeM7dMS5bwpiWXbWubLDAccG
         zErQ==
X-Gm-Message-State: AOAM531Bq24cZW7LjuUIADe0yrYYCLNn56YeRprea48EuOSx7XM0s+2w
        sOLx29zwmdCmWaB4/kx3d8d81HpzgACWZc7fifMs8A==
X-Google-Smtp-Source: ABdhPJzBpiiAn3iYlmdGnO4PxGr42qjfn3ntKhGt7ALLe3Ir5hku6BDAAIf9Rrv6P+aH6nXKT2JjbSj2QlXEp2yFmh4=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr4562650ual.100.1615463378649;
 Thu, 11 Mar 2021 03:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20210311174046.597d1951@xhacker.debian>
In-Reply-To: <20210311174046.597d1951@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:49:02 +0100
Message-ID: <CAPDyKFodwp4BLdyGu7GoU7H3f+juF1o4UBqZ4zgz-CXJoeT=oA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Use "mmc" directly rather than "host->mmc"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Mar 2021 at 10:40, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Clean up the code to use the "mmc" directly instead of "host->mmc".
> If the code sits in hot code path, this clean up also brings trvial
> performance improvement. Take the sdhci_post_req() for example:
>
> before the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000161        cbz     w1, 910 <sdhci_post_req+0x50>
>      8e8:       f9424400        ldr     x0, [x0, #1160]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9401a61        ldr     w1, [x19, #24]
>      8f4:       b9403262        ldr     w2, [x19, #48]
>      8f8:       f9400000        ldr     x0, [x0]
>      8fc:       f278003f        tst     x1, #0x100
>      900:       f9401e61        ldr     x1, [x19, #56]
>      904:       1a9f17e3        cset    w3, eq  // eq = none
>      908:       11000463        add     w3, w3, #0x1
>      90c:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> After the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000141        cbz     w1, 90c <sdhci_post_req+0x4c>
>      8e8:       b9401a61        ldr     w1, [x19, #24]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9403262        ldr     w2, [x19, #48]
>      8f4:       f9400000        ldr     x0, [x0]
>      8f8:       f278003f        tst     x1, #0x100
>      8fc:       f9401e61        ldr     x1, [x19, #56]
>      900:       1a9f17e3        cset    w3, eq  // eq = none
>      904:       11000463        add     w3, w3, #0x1
>      908:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> We saved one ldr instruction: "ldr     x0, [x0, #1160]"
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2d73407ee52e..b1afabab9cae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -907,7 +907,7 @@ static void sdhci_calc_sw_timeout(struct sdhci_host *host,
>
>         if (data) {
>                 blksz = data->blksz;
> -               freq = host->mmc->actual_clock ? : host->clock;
> +               freq = mmc->actual_clock ? : host->clock;
>                 transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
>                 do_div(transfer_time, freq);
>                 /* multiply by '2' to account for any unknowns */
> @@ -2269,14 +2269,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
>                     host->clock) {
> -                       host->timeout_clk = host->mmc->actual_clock ?
> -                                               host->mmc->actual_clock / 1000 :
> +                       host->timeout_clk = mmc->actual_clock ?
> +                                               mmc->actual_clock / 1000 :
>                                                 host->clock / 1000;
> -                       host->mmc->max_busy_timeout =
> +                       mmc->max_busy_timeout =
>                                 host->ops->get_max_timeout_count ?
>                                 host->ops->get_max_timeout_count(host) :
>                                 1 << 27;
> -                       host->mmc->max_busy_timeout /= host->timeout_clk;
> +                       mmc->max_busy_timeout /= host->timeout_clk;
>                 }
>         }
>
> @@ -2399,7 +2399,7 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>                 return 0;
>
>         /* If nonremovable, assume that the card is always present. */
> -       if (!mmc_card_is_removable(host->mmc))
> +       if (!mmc_card_is_removable(mmc))
>                 return 1;
>
>         /*
> @@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         unsigned long flags;
>
>         if (enable)
> -               pm_runtime_get_noresume(host->mmc->parent);
> +               pm_runtime_get_noresume(mmc->parent);
>
>         spin_lock_irqsave(&host->lock, flags);
>         sdhci_enable_sdio_irq_nolock(host, enable);
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (!enable)
> -               pm_runtime_put_noidle(host->mmc->parent);
> +               pm_runtime_put_noidle(mmc->parent);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
>
> @@ -2837,7 +2837,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 goto out;
>         }
>
> -       host->mmc->retune_period = tuning_count;
> +       mmc->retune_period = tuning_count;
>
>         if (host->tuning_delay < 0)
>                 host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
> @@ -2886,11 +2886,10 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>                                 int err)
>  {
> -       struct sdhci_host *host = mmc_priv(mmc);
>         struct mmc_data *data = mrq->data;
>
>         if (data->host_cookie != COOKIE_UNMAPPED)
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +               dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
>                              mmc_get_dma_dir(data));
>
>         data->host_cookie = COOKIE_UNMAPPED;
> @@ -2941,9 +2940,9 @@ static void sdhci_card_event(struct mmc_host *mmc)
>         /* Check sdhci_has_requests() first in case we are runtime suspended */
>         if (sdhci_has_requests(host) && !present) {
>                 pr_err("%s: Card removed during transfer!\n",
> -                       mmc_hostname(host->mmc));
> +                       mmc_hostname(mmc));
>                 pr_err("%s: Resetting controller.\n",
> -                       mmc_hostname(host->mmc));
> +                       mmc_hostname(mmc));
>
>                 sdhci_do_reset(host, SDHCI_RESET_CMD);
>                 sdhci_do_reset(host, SDHCI_RESET_DATA);
> @@ -3675,7 +3674,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                         host->ops->enable_dma(host);
>         }
>
> -       if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
> +       if ((mmc->pm_flags & MMC_PM_KEEP_POWER) &&
>             (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
>                 /* Card keeps power but host controller does not */
>                 sdhci_init(host, 0);
> @@ -3683,7 +3682,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>                 host->clock = 0;
>                 mmc->ops->set_ios(mmc, &mmc->ios);
>         } else {
> -               sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
> +               sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
>         }
>
>         if (host->irq_wake_enabled) {
> @@ -3691,7 +3690,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>         } else {
>                 ret = request_threaded_irq(host->irq, sdhci_irq,
>                                            sdhci_thread_irq, IRQF_SHARED,
> -                                          mmc_hostname(host->mmc), host);
> +                                          mmc_hostname(mmc), host);
>                 if (ret)
>                         return ret;
>         }
> @@ -4378,7 +4377,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>
>         if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>             mmc_card_is_removable(mmc) &&
> -           mmc_gpio_get_cd(host->mmc) < 0)
> +           mmc_gpio_get_cd(mmc) < 0)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
>         if (!IS_ERR(mmc->supply.vqmmc)) {
> --
> 2.30.2
>
