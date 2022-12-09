Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0CC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Dec 2022 09:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLIJe2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIJe1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2022 04:34:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CBE1F9C3
        for <linux-mmc@vger.kernel.org>; Fri,  9 Dec 2022 01:34:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so4404057pjm.2
        for <linux-mmc@vger.kernel.org>; Fri, 09 Dec 2022 01:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DcS3x5UmVaSMKFt9E6LpEtAhtfgHDBTbU6XLvPXAh/M=;
        b=RMV7LNGN99Ydci6QdHnV35yYk3uHMw09LYh44w6Q5gMtVmSrwcJaXacXkVcQfujsx6
         CfvOAHDYsaS2D1kfaE3IPVDEkldu8MPpmH5+bUNYcSCI9cCuU8rNPbSPoo/uCS75DZbJ
         v3/VFWrwCSgcDmjCy6PKUeqgIFSHYRMu2Pfgq1nrHG0EOXFuwQD+AmYs9uS1Fp2o1JLK
         WqB19hRISni/U/ZDdnSuFAIRHOAg3AnMds/uT8KRrSPQMe6XP1GwT5yC03UxdXM94bbZ
         KGMt7xqxiLLxE9gpV4p20YO6RVbOPZ2KygJAv809Eq6Y8pM874j/DYtC7ORgVPXyltRP
         2/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcS3x5UmVaSMKFt9E6LpEtAhtfgHDBTbU6XLvPXAh/M=;
        b=U+8Z88Ik5woSCGzcDabftpaCMrVnPehgLBtrQ6+hNad3xTVL+rcY24CFeFiojxdlsd
         E4wLvAQDkzqoTXem08vfMLJ2tpQDk8iTaNP15aRtOvfg3rbk9qYrJNd+obtGMIn2AvJZ
         /m/t9jbvfNx4fdJUuQvzu0FhFD2jiBBKWWzJPk0zQLE7l28ouxyEBNGhCaqeMDmhbJXA
         9V5sjXK1T5NKasPyhBrVG+/LFv5+UeD8NnjZF2kNGODKIbUMB5PfP/pSYSuVzitPSnFC
         h58vIV5KRgZ9LIN4GRbhAMtb5yodJcoYbgDZOsVOEuT9EUktBA7BPrdAVVT6+dMAjbmJ
         3dMA==
X-Gm-Message-State: ANoB5pl1/inj3EYjKl1x+0VmDqow2Aoqp8ctdhfqyWQb7mAjWZUsYaHA
        leUZWGXkOgwgKdnY8Ye9w6Z3JO5h6HtUAEAEZLjUtg==
X-Google-Smtp-Source: AA0mqf7xEOD5xk6AN0Rb6Uf5Ay0jGqKE0ipuZM1ILbs3FzQGg82UmqA9bAPNDg7B9W4YFZC3PfeD6V1Ynwm8nM8iPtU=
X-Received: by 2002:a17:90b:268b:b0:219:ff4d:b64b with SMTP id
 pl11-20020a17090b268b00b00219ff4db64bmr12012847pjb.164.1670578466038; Fri, 09
 Dec 2022 01:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20221207051909.32126-1-wenchao.chen@unisoc.com>
In-Reply-To: <20221207051909.32126-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Dec 2022 10:33:49 +0100
Message-ID: <CAPDyKFr=GYHAtt6EitO=o_Z+w0+6b_TWmLWLT_55Qn=5kX7DyQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Disable CLK_AUTO when the clock is less
 than 400K
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Dec 2022 at 06:20, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> When the clock is less than 400K, some SD cards fail to initialize
> because CLK_AUTO is enabled.
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for next, and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-sprd.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bec3f9e3cd3f..525f979e2a97 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -228,13 +228,15 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>         div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
>         sdhci_enable_clk(host, div);
>
> -       /* enable auto gate sdhc_enable_auto_gate */
> -       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> -       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> -              SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> -       if (mask != (val & mask)) {
> -               val |= mask;
> -               sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> +       /* Enable CLK_AUTO when the clock is greater than 400K. */
> +       if (clk > 400000) {
> +               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
> +               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
> +                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
> +               if (mask != (val & mask)) {
> +                       val |= mask;
> +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
> +               }
>         }
>  }
>
> --
> 2.17.1
>
