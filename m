Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2825DC433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66FF22BF3
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9qyQMxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHEGe0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHEGeZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:34:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30060C061756
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:34:25 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id i129so4750588vsi.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcTGsN1GqTyRHP38uv1UBRO0YktqDis4qr9JLmzXGE4=;
        b=g9qyQMxSwQane38j3tFti90AEY4pLp4rdj2wjafma7cT5qdH0YguAEup51HBqzBbPG
         EKMSM2urua6cL6o0SSKNQO21uoystBjYqoRxfE+spof62xhei1ewyxYsPpzmTzm+r8Dl
         QN2ofuWDHmYM57ZI1kQvsN8JY8zRsoH2ILBsGnplFdWotGTYUTFSLZMX0oABbjvckRvf
         dYKDZBjNzyGGFPB7ZwAa96WRcIcI/Q5FUNssKwob57KD8QOx++hfhMmGg0N015+E7fl5
         P7x0VgpLww7yLVtuqLwGN4k+DK7DTNcOjzONRtkpijoYJ/hFOB1iOVMQ5jQs1G2UZckA
         o31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcTGsN1GqTyRHP38uv1UBRO0YktqDis4qr9JLmzXGE4=;
        b=iV+hkas6TQhnbJHRcfXYSQGd3RGU4q61JlAN0FOr3nyBO6yGS6ha/fL+/2MjXuhwKG
         MIr2URdgZohEZlAZanLGCMqTgSj/xSDRQX3BRGyIRoEKVjwOk3YCYuq0ISXhe1yUHxHq
         IxXBn0Gbo/BMNdDVxFq5Dw2nKrnjV7SnO4NSaMyDgAADdT1oZ0xbOaWEQ7toX73paNCK
         viMWTNSfTGxqB1mn2vYWpKIEIYRrEM/j5O4Jn/IaseF1kVaRIU8R9KU6g7wx0AhwOHEF
         ecZJv+hz56c1kDtJLkl85soEfMwIU7YmTAwPjPWODQCDjmq09I/b2DnZhm0gFRJl2/fy
         F5eQ==
X-Gm-Message-State: AOAM533A9kIp+8ygj+0cEe4QRLDn3h1IWVGfB1UUl6sEXfIIdyfu3axm
        TaABWaS4F3hSYNdOngYYqr0NkUZod/p3CooAjS6zHw==
X-Google-Smtp-Source: ABdhPJxEfmB6Ik98Axw1HSFqmFL53uuvv7M9ANgpzA0vE3dhGcrt5FT310i0KtKEoloRkWx/cpKTDDPxP5h9+yrhtIM=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr879494vso.165.1596609264407;
 Tue, 04 Aug 2020 23:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200720061141.172944-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200720061141.172944-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:33:47 +0200
Message-ID: <CAPDyKFrLSBshy72-4C5FJR_kRx+3_h0OZ9HyRqOGVvHkAK0+=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-cadence: do not use hardware tuning for SD mode
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020 at 08:12, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit ef6b75671b5f ("mmc: sdhci-cadence: send tune request twice to
> work around errata") stated, this IP has an errata. This commit applies
> the second workaround for the SD mode.
>
> Due to the errata, it is not possible to use the hardware tuning provided
> by SDHCI_HOST_CONTROL2.
>
> Use the software-controlled tuning like the eMMC mode.
>
> Set sdhci_host_ops::platform_execute_tuning instead of overriding
> mmc_host_ops::execute_tuning.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 123 ++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4a6c9ba82538..4d9f7681817c 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -202,57 +202,6 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>         return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
>  }
>
> -static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> -                                        unsigned int timing)
> -{
> -       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> -       u32 mode;
> -
> -       switch (timing) {
> -       case MMC_TIMING_MMC_HS:
> -               mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
> -               break;
> -       case MMC_TIMING_MMC_DDR52:
> -               mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
> -               break;
> -       case MMC_TIMING_MMC_HS200:
> -               mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
> -               break;
> -       case MMC_TIMING_MMC_HS400:
> -               if (priv->enhanced_strobe)
> -                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
> -               else
> -                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
> -               break;
> -       default:
> -               mode = SDHCI_CDNS_HRS06_MODE_SD;
> -               break;
> -       }
> -
> -       sdhci_cdns_set_emmc_mode(priv, mode);
> -
> -       /* For SD, fall back to the default handler */
> -       if (mode == SDHCI_CDNS_HRS06_MODE_SD)
> -               sdhci_set_uhs_signaling(host, timing);
> -}
> -
> -static const struct sdhci_ops sdhci_cdns_ops = {
> -       .set_clock = sdhci_set_clock,
> -       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> -       .set_bus_width = sdhci_set_bus_width,
> -       .reset = sdhci_reset,
> -       .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> -       .ops = &sdhci_cdns_ops,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> -       .ops = &sdhci_cdns_ops,
> -};
> -
>  static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
>         struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> @@ -286,23 +235,24 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>         return 0;
>  }
>
> -static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +/*
> + * In SD mode, software must not use the hardware tuning and instead perform
> + * an almost identical procedure to eMMC.
> + */
> +static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  {
> -       struct sdhci_host *host = mmc_priv(mmc);
>         int cur_streak = 0;
>         int max_streak = 0;
>         int end_of_streak = 0;
>         int i;
>
>         /*
> -        * This handler only implements the eMMC tuning that is specific to
> -        * this controller.  Fall back to the standard method for SD timing.
> +        * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
> +        * The delay is set by probe, based on the DT properties.
>          */
> -       if (host->timing != MMC_TIMING_MMC_HS200)
> -               return sdhci_execute_tuning(mmc, opcode);
> -
> -       if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
> -               return -EINVAL;
> +       if (host->timing != MMC_TIMING_MMC_HS200 &&
> +           host->timing != MMC_TIMING_UHS_SDR104)
> +               return 0;
>
>         for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
>                 if (sdhci_cdns_set_tune_val(host, i) ||
> @@ -325,6 +275,58 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
>  }
>
> +static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
> +                                        unsigned int timing)
> +{
> +       struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +       u32 mode;
> +
> +       switch (timing) {
> +       case MMC_TIMING_MMC_HS:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
> +               break;
> +       case MMC_TIMING_MMC_DDR52:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
> +               break;
> +       case MMC_TIMING_MMC_HS200:
> +               mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
> +               break;
> +       case MMC_TIMING_MMC_HS400:
> +               if (priv->enhanced_strobe)
> +                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
> +               else
> +                       mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
> +               break;
> +       default:
> +               mode = SDHCI_CDNS_HRS06_MODE_SD;
> +               break;
> +       }
> +
> +       sdhci_cdns_set_emmc_mode(priv, mode);
> +
> +       /* For SD, fall back to the default handler */
> +       if (mode == SDHCI_CDNS_HRS06_MODE_SD)
> +               sdhci_set_uhs_signaling(host, timing);
> +}
> +
> +static const struct sdhci_ops sdhci_cdns_ops = {
> +       .set_clock = sdhci_set_clock,
> +       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +       .set_bus_width = sdhci_set_bus_width,
> +       .reset = sdhci_reset,
> +       .platform_execute_tuning = sdhci_cdns_execute_tuning,
> +       .set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> +       .ops = &sdhci_cdns_ops,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
> +       .ops = &sdhci_cdns_ops,
> +};
> +
>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>                                              struct mmc_ios *ios)
>  {
> @@ -385,7 +387,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         priv->hrs_addr = host->ioaddr;
>         priv->enhanced_strobe = false;
>         host->ioaddr += SDHCI_CDNS_SRS_BASE;
> -       host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
>         sdhci_enable_v4_mode(host);
> --
> 2.25.1
>
