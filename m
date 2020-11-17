Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2190C64E7C
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CF5238E6
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddv2LYC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgKQLuw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgKQLuv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:51 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5F6C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:50 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id x11so10851935vsx.12
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rT4v1DVikUpfEXtE7oPEUWFVvDoE3ZWoDR+gAa6bjgI=;
        b=ddv2LYC2CUQ1W34byoZMPmdiQPbzEP6XccuQwMQL0H1Bv8MYrqPUtBqspfPrSLmvEU
         1Gqd6IvGGKtMNxIyTsCL6qqYrQzOv30neUM7HiPb8G+EXbCggyf/0lWgVLCI5/W+4bq5
         /N495VFQv4mLafx+8M8s5xB8Br7Gi55dJZz2SI3kHD723dQc47wj8uR0u93+ZiQyYfc6
         61CnMnZLoL3/IDGgy+bFbdqL/wShDZbuCfaXDmyOcr6xnjZiCdaKa1laNPw5ajTBJyfo
         yyD/uO/akbVo2yoUwm0G1lpkqbjJC6nzWbOiRmfkTJDBQsut2v3rlPrPvlVmB8Ip9J8v
         L8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rT4v1DVikUpfEXtE7oPEUWFVvDoE3ZWoDR+gAa6bjgI=;
        b=CtgPn155ZMCk1VOWrPg+TmBkUXtMsPSjsA99CbCaP5WEvICXmz1KU2rAHFgZIFpwSj
         Qo1NFyLAFFh3NvAE1SVf+YqUc+zj05IGhXYw6/D7ikPMXZEHLNIiC1Lb6GnKAVIl3S8c
         vgJkdrMP2CGEC+trpc17I1Rt6ViWhIG0saBECY0MiW8SYVGBojMqVlUm3wnbK4t/Mo0T
         QQ/9ZYQrZa2gonciw5/y0MhpE2bLqtElfXo/hLE2TnCjvarco2RsIyKgsjQeQQFC109s
         cswXw87NyZLc7eMNC9eUme5rAhXaO3zp86JwbMKKUKqtZFQdGibIpgPVbN1bOaZipB7R
         ADwA==
X-Gm-Message-State: AOAM533OS0RedWguU4EZhpeekMSbWlNfv1eiIrpacmYUeg7skCjqXQZ2
        h7hDLXyJP0OKP+Mp2e8I2nbO9HGCntpgHgHnK9IZew==
X-Google-Smtp-Source: ABdhPJyo9RaTCIgqbWCf41+YcbrGBJnW3mhsg+ZsyHKINFY21x8p8zL06l5fhC9X14zOvhUVwObqg4lvInLzFajms+4=
X-Received: by 2002:a67:310d:: with SMTP id x13mr11441505vsx.19.1605613849848;
 Tue, 17 Nov 2020 03:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20201112173636.360186-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20201112173636.360186-1-dmitry.baryshkov@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:13 +0100
Message-ID: <CAPDyKFqHdDetWXUoSRGBHqmjzsFjfqNrXE=Z594+CHuOPhqgtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: detect if tassadar_dll is used by
 using core version
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Nov 2020 at 18:36, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Detect if tassadar_dll is required by using core version rather than
> just specifying it in the sdhci_msm_variant_info.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 3451eb325513..9c7927b03253 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -248,7 +248,6 @@ struct sdhci_msm_variant_ops {
>  struct sdhci_msm_variant_info {
>         bool mci_removed;
>         bool restore_dll_config;
> -       bool uses_tassadar_dll;
>         const struct sdhci_msm_variant_ops *var_ops;
>         const struct sdhci_msm_offset *offset;
>  };
> @@ -2154,18 +2153,10 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
>         .offset = &sdhci_msm_v5_offset,
>  };
>
> -static const struct sdhci_msm_variant_info sm8250_sdhci_var = {
> -       .mci_removed = true,
> -       .uses_tassadar_dll = true,
> -       .var_ops = &v5_var_ops,
> -       .offset = &sdhci_msm_v5_offset,
> -};
> -
>  static const struct of_device_id sdhci_msm_dt_match[] = {
>         {.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>         {.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
>         {.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
> -       {.compatible = "qcom,sm8250-sdhci", .data = &sm8250_sdhci_var},
>         {.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
>         {},
>  };
> @@ -2249,7 +2240,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         msm_host->restore_dll_config = var_info->restore_dll_config;
>         msm_host->var_ops = var_info->var_ops;
>         msm_host->offset = var_info->offset;
> -       msm_host->uses_tassadar_dll = var_info->uses_tassadar_dll;
>
>         msm_offset = msm_host->offset;
>
> @@ -2396,6 +2386,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (core_major == 1 && core_minor >= 0x49)
>                 msm_host->updated_ddr_cfg = true;
>
> +       if (core_major == 1 && core_minor >= 0x71)
> +               msm_host->uses_tassadar_dll = true;
> +
>         ret = sdhci_msm_register_vreg(msm_host);
>         if (ret)
>                 goto clk_disable;
> --
> 2.28.0
>
