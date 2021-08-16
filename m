Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C4C4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3772B63305
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhHPOAs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhHPOAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE8DC0612A7
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id e9so11003974vst.6
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrII97R9ADzSkpz5bm6tsH8fcBbWSF/zk08tsiVqE3g=;
        b=qsJ8Ou9oVBxPwrXLQY0RRC7ivFXF3gnatanqcUcKV8RSdE/kQnZ65vI9NxlvZFyUKT
         YALl4pBaf0W3xBC2bWl+M95bVlfBMIW7DUzBn6kiI5JksNr5tXYSuKzMdwlf8j0BCoPo
         fgW/J7ym0NzCOYeFrbBXSFGvNkhw44DQ3JkJisPshO8hE5iIMS4oVi02KZZYHOPrnPOI
         dIwis+hIE8IIY60q7LJaYR6tCBm3sE/YRh2mv5fYXocF17GD2hkotspKGQIwGcxnVZ+B
         6JAkzB1+joJoHVAIjIxK5FTuEEKoTN6fdYMr0GOo9iNuRTY7oZfUlUWIzpwGbh4H5uli
         oyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrII97R9ADzSkpz5bm6tsH8fcBbWSF/zk08tsiVqE3g=;
        b=nYsXuBiIUyeOB1k7m4MOYggjWsVL3z1nuyM/79Pal3IF+BIs4LdZ1sgIRLdBDm7+ln
         n0pf34bEg/gYhdBCmQzQhO09oOnGs7279zhqy057v63gqxAeufoW7bWroUXiF4BC7NNK
         K2XF83MxrIezj5YRWMbQx9SylK3RIrXcAarU7p8HCYfo9n0uJAxYMEj09kOfq4iFidxO
         Tc6ObeyJnhh0o43F7OUR1SFtReM/PGzDmO0ocdyvmfsXEn70DYpprXOHN+xLFeF8cl/O
         wb7hYyj1P8nELoE4TOUrdyh4VzOu2nBCSgDD1UuCmBdv0h4sxYbYXTHyMI2hm6zxH2xa
         zdeg==
X-Gm-Message-State: AOAM5332R6//pSWedhEkaYyoPafT26LfLGEHITKDx90b7bJKCxiFTe7Q
        CygbDsvP9fpBS4N/fuL1qabNWrK9yiTZ0jAzb1LIEA==
X-Google-Smtp-Source: ABdhPJwokJtd5yc9yJUou2gAS8aHmlXPKBVY+W8VtEDj9mdLwmXmFeHQYZSmwY2vonD7cu7RrYdco4+ENtJDgoZ43mM=
X-Received: by 2002:a67:7949:: with SMTP id u70mr1602635vsc.55.1629122376058;
 Mon, 16 Aug 2021 06:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com>
In-Reply-To: <2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:58:58 +0200
Message-ID: <CAPDyKFr7QAsDbE8TrZtTcUL1hKAw2_dMZRU5QngzT3VwUTktfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: fix long reads when clock is prescaled
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricky Wu <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 1 Aug 2021 at 13:46, Thomas Hebb <tommyhebb@gmail.com> wrote:
>
> For unexplained reasons, the prescaler register for this device needs to
> be cleared (set to 1) while performing a data read or else the command
> will hang. This does not appear to affect the real clock rate sent out
> on the bus, so I assume it's purely to work around a hardware bug.
>
> During normal operation, the prescaler is already set to 1, so nothing
> needs to be done. However, in "initial mode" (which is used for sub-MHz
> clock speeds, like the core sets while enumerating cards), it's set to
> 128 and so we need to reset it during data reads. We currently fail to
> do this for long reads.
>
> This has no functional affect on the driver's operation currently
> written, as the MMC core always sets a clock above 1MHz before
> attempting any long reads. However, the core could conceivably set any
> clock speed at any time and the driver should still work, so I think
> this fix is worthwhile.
>
> I personally encountered this issue while performing data recovery on an
> external chip. My connections had poor signal integrity, so I modified
> the core code to reduce the clock speed. Without this change, I saw the
> card enumerate but was unable to actually read any data.
>
> Writes don't seem to work in the situation described above even with
> this change (and even if the workaround is extended to encompass data
> write commands). I was not able to find a way to get them working.
>
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 36 ++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 4ca937415734..58cfaffa3c2d 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -542,9 +542,22 @@ static int sd_write_long_data(struct realtek_pci_sdmmc *host,
>         return 0;
>  }
>
> +static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
> +{
> +       rtsx_pci_write_register(host->pcr, SD_CFG1,
> +                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
> +}
> +
> +static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
> +{
> +       rtsx_pci_write_register(host->pcr, SD_CFG1,
> +                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
> +}
> +
>  static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
>  {
>         struct mmc_data *data = mrq->data;
> +       int err;
>
>         if (host->sg_count < 0) {
>                 data->error = host->sg_count;
> @@ -553,22 +566,19 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
>                 return data->error;
>         }
>
> -       if (data->flags & MMC_DATA_READ)
> -               return sd_read_long_data(host, mrq);
> +       if (data->flags & MMC_DATA_READ) {
> +               if (host->initial_mode)
> +                       sd_disable_initial_mode(host);
>
> -       return sd_write_long_data(host, mrq);
> -}
> +               err = sd_read_long_data(host, mrq);
>
> -static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
> -{
> -       rtsx_pci_write_register(host->pcr, SD_CFG1,
> -                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
> -}
> +               if (host->initial_mode)
> +                       sd_enable_initial_mode(host);
>
> -static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
> -{
> -       rtsx_pci_write_register(host->pcr, SD_CFG1,
> -                       SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
> +               return err;
> +       }
> +
> +       return sd_write_long_data(host, mrq);
>  }
>
>  static void sd_normal_rw(struct realtek_pci_sdmmc *host,
> --
> 2.32.0
>
