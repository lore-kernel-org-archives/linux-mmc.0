Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C5C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKIMev (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKIMet (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:34:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A6D17E3F
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:34:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so1754476pjl.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=54ZyT6fc56mcawLFXuHDQpGJgTiE24QOQne6rNPY7lA=;
        b=mEhzF9GvZfDYIp4nIk7aLX1AccVsUGSH00US22OvPPZ1bJh77mk1gcrlTnfI7+nZfW
         A9PbPEY5/UM8Bh7Gx1wurMdHnNfYsV12imdcEzcXLe24prrtIEGGR3z4slqrcB7QHbgl
         /QM7ocXdKi/u9o8rRfTKDd8wA7P3D9NT02LWK1fGTQs0IUNczuYiwNZ9fhHH1FgstRXA
         nPhW0D9wWaeCKqDFl9r2DigPRbsM6zhTGzRcR5kSdo1UcMLF/+esiRHKbpQ7E/TrPdS5
         1IfYF2R3ZZgoqOaRvcm1aTYT1fs0/3etvYKSXV207Z6RnoECQi0mW8DXpQGZh+rFry+X
         5sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54ZyT6fc56mcawLFXuHDQpGJgTiE24QOQne6rNPY7lA=;
        b=lVlNCOW3VkY+qcRnDfLs3+WnjoQwsPNADlkdrzRzkPy1dR04WC8ZlUddflv0/SYCdT
         OPKnUhEPSL4TCoKYMqoLWlYzQ3dkVeDbI3VbLCPTZeErJMuZ561B447VG7AOZeE7YweM
         mhIz281CEY2fRLLhBYJK8bvwWqyKY+P5rI1AYR0W6rsxcsw8g39i3m3SCQCkVp2zEXcs
         vZth1wW/FwXm6HEFt5IfSGw0s3JXNgtkn6Us3H9qdjHAtekw3a8w/0/842l3DeEppBkd
         O0yuaf/kSQpcEY+uiTqA8vbcwxdvusbrh+HACPSbQW4S1JazQcuqdpIeTrVQJwsnPSw0
         atpg==
X-Gm-Message-State: ACrzQf1cVo3dtTjGPxwVBx0kMS5tnd7U0iQsCl+7Hv9NGi9v8epWc1cl
        JtMP6YT1nv9NovVfyD+Q2SpjoWHf+weXFoaFP5CDUw==
X-Google-Smtp-Source: AMsMyM7cR85cjCD286dwa+O7SgLYBEsLqTdFVs60mbDlpD2TLOplgOCpHPxyr+PqlxpKYDt5sXgSVTxjTW/b0fIdwLk=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr80726174pjb.164.1667997288842; Wed, 09
 Nov 2022 04:34:48 -0800 (PST)
MIME-Version: 1.0
References: <1667893503-20583-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1667893503-20583-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:12 +0100
Message-ID: <CAPDyKFrmGb272TEyyAUaW7gy+YDa8L2958eF+Fy+5VVfzh04hw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: use the correct host caps for MMC_CAP_8_BIT_DATA
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, stable@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 09:06, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> MMC_CAP_8_BIT_DATA belongs to struct mmc_host, not struct sdhci_host.
> So correct it here.
>
> Fixes: 1ed5c3b22fc7 ("mmc: sdhci-esdhc-imx: Propagate ESDHC_FLAG_HS400* only on 8bit bus")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a54f1806dd57..004c6352d954 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1679,14 +1679,14 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
>                 host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>
> -       if (host->caps & MMC_CAP_8_BIT_DATA &&
> +       if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
>             imx_data->socdata->flags & ESDHC_FLAG_HS400)
>                 host->mmc->caps2 |= MMC_CAP2_HS400;
>
>         if (imx_data->socdata->flags & ESDHC_FLAG_BROKEN_AUTO_CMD23)
>                 host->quirks2 |= SDHCI_QUIRK2_ACMD23_BROKEN;
>
> -       if (host->caps & MMC_CAP_8_BIT_DATA &&
> +       if (host->mmc->caps & MMC_CAP_8_BIT_DATA &&
>             imx_data->socdata->flags & ESDHC_FLAG_HS400_ES) {
>                 host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>                 host->mmc_host_ops.hs400_enhanced_strobe =
> --
> 2.34.1
>
