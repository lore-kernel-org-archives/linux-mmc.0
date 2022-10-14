Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C61CC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Oct 2022 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJNOIJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Oct 2022 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJNOIH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2022 10:08:07 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BE1B94F7
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 07:08:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h13so5008527pfr.7
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2022 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2EQvstEBpVzulukiDjicIgwirC72gNP9LNt4rNxmPE=;
        b=Z7PboRkvydycfIogQPEG8ZBTlVuiZvQ4kq4ZMG/IKssN4lxkgEIrg4v3b3LkSveIk8
         cLm1mrOrh22a3L4OzxbIXCIlnfAUZy2vntcX6QitAW8LvoQGBjKearphhpZu7L48450x
         K5WIm36LQfhiPbhTZHNJP235ari3DwcCzO0oO/7wqlQ0b2iysEL2a2tfYVxF4F/yu9yZ
         Y+NJgV9RbWq6KGMEYpojZYLibkvZed4M9aUiDAQGLAjeDLQEcvY3DO7M3ATyYNDBguw7
         fCBrWb1RIaBvp08RYpIU96mWwmqHtaj9SAfcVligDQoPDP09eMhMSF26irKQsKGK7+bO
         mXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2EQvstEBpVzulukiDjicIgwirC72gNP9LNt4rNxmPE=;
        b=xllSwb52IRov8p34Q94ObrQZSHBwiq8yxB376rQ5S3UuX+R5zS9MiR6yA6EmSlryKQ
         Qbb65P/JJE1+b/8w6de8QzSHOy5rI4K11OkBMSIy2fy2IG29vCHl4oBkmt7vuQXjvZuU
         02oYKVm17ENeinMBdbQSmepD/KMor0PBQNyz9y3ZC4f2qymq31Q7DzDhsFxiiNjNoPhG
         D7mZ/4kFnRog8ns2BtgIYVpT4wnw8QQjoI1HJbTs+tDwg+xKOG4ZKFzG5CeiK0Ej3t+y
         P5KImrE5Un3FBlLDfYbYPGbdNFapPq1w9XgGLurHSpusVyWp3Nzy9fb1aFBXNkziVyl5
         XTcg==
X-Gm-Message-State: ACrzQf1J6JZXrbM/GdaNdB9BGO3GG9mIQo0RuvcYF9Zibj21iQjZzYaj
        ATsJpuZu6YSVGctRjzUsY1bn1ZRT4HOMuMBeIW/xJX5QnAo=
X-Google-Smtp-Source: AMsMyM77MpaOG0LccCm9++0Kgg5jg+t2ffbK79s3rBfjvCgaLZLhK21Ui5/eOwWYoDRI1XWxW5zoXlzJhrFnFTyGpqU=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr4843237pgl.434.1665756479079; Fri, 14
 Oct 2022 07:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221013093248.2220802-1-s.hauer@pengutronix.de>
In-Reply-To: <20221013093248.2220802-1-s.hauer@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Oct 2022 16:07:22 +0200
Message-ID: <CAPDyKFo=aLtaqnYpnU2kMpVNDU6Hct36R_fgbYD_fGEsZDkVSA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on
 8bit bus
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2022 at 11:32, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> The core issues the warning "drop HS400 support since no 8-bit bus" when
> one of the ESDHC_FLAG_HS400* flags is set on a non 8bit capable host. To
> avoid this warning set these flags only on hosts that actually can do
> 8bit, i.e. have bus-width = <8> set in the device tree.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I added a fixes tag, see below.
Fixes: 029e2476f9e6 ("mmc: sdhci-esdhc-imx: add HS400_ES support for i.MX8QXP")

I haven't tried if the patch applies on stable kernels beyond that
commit, but if not, it should be a trivial conflict to resolve.

So, I applied this for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 3f4eb49afa025..003534b78493b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1663,6 +1663,10 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                 host->mmc_host_ops.execute_tuning = usdhc_execute_tuning;
>         }
>
> +       err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> +       if (err)
> +               goto disable_ahb_clk;
> +
>         if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
>                 sdhci_esdhc_ops.platform_execute_tuning =
>                                         esdhc_executing_tuning;
> @@ -1670,13 +1674,15 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>
> -       if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
> +       if (host->caps & MMC_CAP_8_BIT_DATA &&
> +           imx_data->socdata->flags & ESDHC_FLAG_HS400)
>                 host->mmc->caps2 |= MMC_CAP2_HS400;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
>                 host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
>
> -       if (imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
> +       if (host->caps & MMC_CAP_8_BIT_DATA &&
> +           imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
>                 host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>                 host->mmc_host_ops.hs400_enhanced_strobe =
>                                         esdhc_hs400_enhanced_strobe;
> @@ -1698,10 +1704,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>                         goto disable_ahb_clk;
>         }
>
> -       err = sdhci_esdhc_imx_probe_dt(pdev, host, imx_data);
> -       if (err)
> -               goto disable_ahb_clk;
> -
>         sdhci_esdhc_imx_hwinit(host);
>
>         err = sdhci_add_host(host);
> --
> 2.30.2
>
