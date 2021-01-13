Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A8C43331
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F97B233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbhAML1S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbhAML1R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:27:17 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6643AC0617B9
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:54 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id b23so900701vsp.9
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY0StSf2+N5zefAWzCUaAzXJcItnmm9Fa8mEZdMQe/Y=;
        b=NqJxW9NFl6Mpmiw179v+oVixBzv5BFOOzZs4jkT6kMz7Bu4B9hEHxWecVQlqajpiDI
         u4BINGsA8Z/jvKTUpEgwHKAa91r/bE1I313SR2ab7Hkgul0pvRSbvQH/qIRaDbeq7khZ
         o2IiSd8oGNQZb+YJh6A67boEZpPAer0R4CJUz8vIHILxQwyF3c83bmAu5s6yQ0U5fT/T
         Ob/FQXbPFg5IVSFi6ijA9yZq84Wkc1fb9NJWs9ZIA2OOpsyu1HOT7gUQTriGuhN+CzeB
         bvEmoOxauMNhuyFgJX959/TywUpU15oOCWJPRsMUWL5HbLQa8Q+3uwPCrGXzC4kvbQvI
         JXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY0StSf2+N5zefAWzCUaAzXJcItnmm9Fa8mEZdMQe/Y=;
        b=faKEkt+Bnjv2tQST1UjXt7TEbBS1DoJYtWW6F6sruj0RLz0ebIrLWxpnNKyl0UYOJJ
         lgp+SUVEUOUINJJEGcNy5uQHJwPgIAdFNiaE77IB/dbTdvRx60DFPm++WUkLoc6VJGtY
         rWEotoNHHXVjDQrLS3zwROL3TtXnxgu7zpeRhFTFQn7ZY2FAJthhr1d/rkR7GwpToZ8n
         YCJVaAplAA0MOwYTWvNYSNfoYiCsMCls0OJGagaWkbRgI8r7ZU+3aYOPFUwqMqTYh3Ou
         xCSBgpS0qgIsKhGt591Kp9SQwI5na1Z+/wm7F3u2apRO+psdXTEaFnlBCy0WyHFnKDOo
         W1+g==
X-Gm-Message-State: AOAM530nkqZkBT8Zs2mADczw3O/Z2vlYQiUsb8YQAGx/BuSTMKnhYasm
        0Tc8n3Z/0CEmWwQCdA2/k8HYP45nUTKUY/cN//vRJw==
X-Google-Smtp-Source: ABdhPJxmIxYl1NunM1cg14JUdbGuw0lAyEMiH7zhCkebWu1/bDnqufJtPRRxfcFqBrE/5wP5Gz7wdB/uYTO3CnEeUIY=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1629067vsf.42.1610537153628;
 Wed, 13 Jan 2021 03:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20201230090401.12627-1-ricky_wu@realtek.com> <20201230090401.12627-2-ricky_wu@realtek.com>
In-Reply-To: <20201230090401.12627-2-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:17 +0100
Message-ID: <CAPDyKFrL+ykvw85SiLQojF9PnYoYzraOOvkS8qg5w-LL7xPvNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: rtsx: Add MMC_CAP2_NO_SDIO flag
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Dec 2020 at 10:04, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Added flag MMC_CAP2_NO_SDIO to mmc->caps2
> Card Reader not support SDIO
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index d21b99962b36..6a8b0282f272 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1427,7 +1427,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>         if (pcr->rtd3_en)
>                 mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
> -       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
> +       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
> +               MMC_CAP2_NO_SDIO;
>         mmc->max_current_330 = 400;
>         mmc->max_current_180 = 800;
>         mmc->ops = &realtek_pci_sdmmc_ops;
> --
> 2.17.1
>
