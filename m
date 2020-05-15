Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D57C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 501EE2075F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwZCCMCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEOHJ4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 03:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726653AbgEOHJz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 03:09:55 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AACC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:55 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id w188so333708vkf.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMrcey/VFjUSqrjmSceZhxBusEA8rOudHxgtgSRpgfU=;
        b=SwZCCMCJbOBupMcaeooj/s7BAmGaJ/3z/skTTeDsZpnlf1qg7kUgvUIv3IkwGvJ/Wr
         6KwHNDn1QH/j30ziOgwaorN+O8qAPNXgOPR2spd7gTdrFKRdTN9qa9bav1qNW6eeoJAH
         GX8WaR2pnxXgRthv+Z31yFvaAJNS5jTQlofDczO5IyzrmIkmNP4V28cSShjDaRORX0J2
         vBfvwoVNb673WSLC4owlYDDQTxHhz5gtzzDq0G/ITqJhhrdV2o1uG1ElZZxmpclJyf0k
         HJvqWvY0yjhPcM28P24HxsgcXA7AZ+4eR4eAjX3lAS6+53qe+liFrcR75aqKGmee1bU5
         b1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMrcey/VFjUSqrjmSceZhxBusEA8rOudHxgtgSRpgfU=;
        b=KCz01QcVoPUwb/o8iYSe2oTmZxNsvWADo1khLcXaj5Uoc0LzL1Ljz1u6DKzleOR6WE
         ylK1hoMbR0cMjNxkxYisl4BqVJoWLBXCeL52dIRZhJ1QCuZUMEtTG7z1y0NPxM77gUh3
         FD6XdhBaZy2IF3AbNgD7WEAAdcqNxP+nuW+PI7CpNCtbXZXNAWFufXt8I65qAWzEcBqK
         UvAdWuDMj537LCUSOEl6n4KRWuHgO13nvYUCPOgWejid6sn5w16BCxvviNrpKmfh3dKi
         NEzudVcMvirMZwYs5zPDb09QArhd7gXqzszOa7UstmenPDmmZf2+fNQbSn+i1K+RisrX
         mOQQ==
X-Gm-Message-State: AOAM533pVi7H4K6airkt26Rk0ClQI42DCVEQLyYJhldKFswpf4KxJQPf
        vBMIAOKFb22Db/UndOR+0EQ/s6rzchNcN7FtG+GildeC
X-Google-Smtp-Source: ABdhPJyVP1iYk14ai3Il/5aiDDhXOrIwFuiSmo7BZ5JEF7Q90kBiwKNuigTJo948jZVQpR4ilQM0T8TYUktDKtiia6I=
X-Received: by 2002:a1f:fc06:: with SMTP id a6mr1674172vki.101.1589526594549;
 Fri, 15 May 2020 00:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200511062828.1791484-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200511062828.1791484-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:09:18 +0200
Message-ID: <CAPDyKFqVHMdBwZHDvTC-XkTbBiobEdBFjnjpcgoPoU5rirWWMQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use FIELD_GET/PREP for current capabilities
 bit masks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 May 2020 at 08:29, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Use FIELD_GET and FIELD_PREP to get access to the register fields. Delete
> the shift macros and use GENMASK() for the touched macros.
>
> Note that, this has the side-effect of changing the constants to 64-bit on
> 64-bit platforms.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-esdhc-imx.c |  6 +++---
>  drivers/mmc/host/sdhci.c           | 27 ++++++++++++---------------
>  drivers/mmc/host/sdhci.h           | 11 ++++-------
>  3 files changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 38cd83118082..9896e03fce71 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -419,9 +419,9 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>
>         if (unlikely(reg == SDHCI_MAX_CURRENT) && esdhc_is_usdhc(imx_data)) {
>                 val = 0;
> -               val |= 0xFF << SDHCI_MAX_CURRENT_330_SHIFT;
> -               val |= 0xFF << SDHCI_MAX_CURRENT_300_SHIFT;
> -               val |= 0xFF << SDHCI_MAX_CURRENT_180_SHIFT;
> +               val |= FIELD_PREP(SDHCI_MAX_CURRENT_330_MASK, 0xFF);
> +               val |= FIELD_PREP(SDHCI_MAX_CURRENT_300_MASK, 0xFF);
> +               val |= FIELD_PREP(SDHCI_MAX_CURRENT_180_MASK, 0xFF);
>         }
>
>         if (unlikely(reg == SDHCI_INT_STATUS)) {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 344a7e0e33fe..7818e650f974 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4355,35 +4355,32 @@ int sdhci_setup_host(struct sdhci_host *host)
>
>                         curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
>                         max_current_caps =
> -                               (curr << SDHCI_MAX_CURRENT_330_SHIFT) |
> -                               (curr << SDHCI_MAX_CURRENT_300_SHIFT) |
> -                               (curr << SDHCI_MAX_CURRENT_180_SHIFT);
> +                               FIELD_PREP(SDHCI_MAX_CURRENT_330_MASK, curr) |
> +                               FIELD_PREP(SDHCI_MAX_CURRENT_300_MASK, curr) |
> +                               FIELD_PREP(SDHCI_MAX_CURRENT_180_MASK, curr);
>                 }
>         }
>
>         if (host->caps & SDHCI_CAN_VDD_330) {
>                 ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
>
> -               mmc->max_current_330 = ((max_current_caps &
> -                                  SDHCI_MAX_CURRENT_330_MASK) >>
> -                                  SDHCI_MAX_CURRENT_330_SHIFT) *
> -                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> +               mmc->max_current_330 = FIELD_GET(SDHCI_MAX_CURRENT_330_MASK,
> +                                                max_current_caps) *
> +                                               SDHCI_MAX_CURRENT_MULTIPLIER;
>         }
>         if (host->caps & SDHCI_CAN_VDD_300) {
>                 ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
>
> -               mmc->max_current_300 = ((max_current_caps &
> -                                  SDHCI_MAX_CURRENT_300_MASK) >>
> -                                  SDHCI_MAX_CURRENT_300_SHIFT) *
> -                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> +               mmc->max_current_300 = FIELD_GET(SDHCI_MAX_CURRENT_300_MASK,
> +                                                max_current_caps) *
> +                                               SDHCI_MAX_CURRENT_MULTIPLIER;
>         }
>         if (host->caps & SDHCI_CAN_VDD_180) {
>                 ocr_avail |= MMC_VDD_165_195;
>
> -               mmc->max_current_180 = ((max_current_caps &
> -                                  SDHCI_MAX_CURRENT_180_MASK) >>
> -                                  SDHCI_MAX_CURRENT_180_SHIFT) *
> -                                  SDHCI_MAX_CURRENT_MULTIPLIER;
> +               mmc->max_current_180 = FIELD_GET(SDHCI_MAX_CURRENT_180_MASK,
> +                                                max_current_caps) *
> +                                               SDHCI_MAX_CURRENT_MULTIPLIER;
>         }
>
>         /* If OCR set by host, use it instead. */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d7f1441b0fc3..2ff98891bf25 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -233,13 +233,10 @@
>  #define  SDHCI_SUPPORT_HS400   0x80000000 /* Non-standard */
>
>  #define SDHCI_MAX_CURRENT              0x48
> -#define  SDHCI_MAX_CURRENT_LIMIT       0xFF
> -#define  SDHCI_MAX_CURRENT_330_MASK    0x0000FF
> -#define  SDHCI_MAX_CURRENT_330_SHIFT   0
> -#define  SDHCI_MAX_CURRENT_300_MASK    0x00FF00
> -#define  SDHCI_MAX_CURRENT_300_SHIFT   8
> -#define  SDHCI_MAX_CURRENT_180_MASK    0xFF0000
> -#define  SDHCI_MAX_CURRENT_180_SHIFT   16
> +#define  SDHCI_MAX_CURRENT_LIMIT       GENMASK(7, 0)
> +#define  SDHCI_MAX_CURRENT_330_MASK    GENMASK(7, 0)
> +#define  SDHCI_MAX_CURRENT_300_MASK    GENMASK(15, 8)
> +#define  SDHCI_MAX_CURRENT_180_MASK    GENMASK(23, 16)
>  #define   SDHCI_MAX_CURRENT_MULTIPLIER 4
>
>  /* 4C-4F reserved for more max current */
> --
> 2.25.1
>
