Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E29C38A2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Oct 2022 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiJZL03 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Oct 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiJZL0Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2022 07:26:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A68E78C
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g129so12837303pgc.7
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2022 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X39jUhEZgZifFR/vv5lEeG2QMFhvU0R8f6aekPYqBWA=;
        b=gphVIrg81EtYYywi+G+nK+6YaojesNFW6oqgahTGwqEuGbctiEERecPF5gFFjuzMs6
         xl0N8xLb4hnhQ4vNsg4oHU/mMf02ZtDTpWCBgohnLrTTU0aZOJS+XnCUJsudzUIE1kBw
         8RHT/92RSoaTo0pBddudhEr6A3JCIzOjDZcSevpXtf6AlBtLqjitMsIXFpmOn0xMPCDY
         Lhh4hhJdy0PDHz/bMC5tc9zK1uc9b5Euo4mjMzNjCBgwW15wt7taHFRTk3rLBgmETlYn
         w5nV8XrlGo7kiZpQPMDBbsB/Vlmu2QrR2DfX7/PtQE9maajq7iKD9Pm3p8CrjLfsZ49/
         Aitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X39jUhEZgZifFR/vv5lEeG2QMFhvU0R8f6aekPYqBWA=;
        b=VP6WsnV95X6AcNE/J6e0mrv2Ha9e7QiOOXCMDBHOe5Iw05X+gzAYeD93jqtGnoE8jC
         0JGlmMmCbesdaB7K6oxjZoBhft849afznUf0u0pvQgJhsU34VD8gbjOHUcTn85LR0jPR
         +Bzc6EZ/JQyMcCKcHjQuatKyh5RCrcjnkYdnUZWgE1GKuIi8ezYhF9e5tGfEMch6XO3Q
         v7eqcpzJb9YeC6b9w+TC+z9Hbv5brXTbKHbKYrGyzBUJCDRfF2RM4bW2Wa4mf5xobutw
         TPZKddkL5ZE2zzu/FpzbXZTDrxcyaS0llXSv01pRR8pk4ChyIlKGLsLbe15pUBsK+Fgd
         BEYA==
X-Gm-Message-State: ACrzQf1A9Q5rbc+bn7J2Y6+IIrqxyp7ZsvcwFEW9ZOq5Ez8lDvkB9u4k
        pvMkBVS8GlUn0nHENA0UjkC2GnDkqQw+8BWRPIZxGA==
X-Google-Smtp-Source: AMsMyM7Us9Ko9zWWL6OVuIx8zluZVYRms/TaSTeS6EVp4Yq4bg20aLKgbGMHCFYG5k/CKabd4tBR5SyLLngc0fyhMgs=
X-Received: by 2002:a05:6a00:170a:b0:563:a40a:b5e1 with SMTP id
 h10-20020a056a00170a00b00563a40ab5e1mr43327754pfc.40.1666783581306; Wed, 26
 Oct 2022 04:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com> <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221017235602.86250-3-giulio.benetti@benettiengineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:44 +0200
Message-ID: <CAPDyKFrkAi4-BUz=qKB4S9v1gKijUt8btu=0BVbF5HDEuH6YYQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: sdhci-esdhc-imx: improve imxrt1050 data
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 18 Oct 2022 at 01:56, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> i.MXRT1050 usdhc is not affected by ESDHC_FLAG_ERR004536 so let's remove
> it. It supports ESDHC_FLAG_STD_TUNING and ESDHC_FLAG_HAVE_CAP1 so let's add
> them.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 55981b0f0b10..4bc0a2914a95 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -306,7 +306,8 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>  static struct esdhc_soc_data usdhc_imxrt1050_data = {
> -       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_HS200 | ESDHC_FLAG_ERR004536,
> +       .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +                       | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
>  };
>
>  static struct esdhc_soc_data usdhc_imx8qxp_data = {
> --
> 2.34.1
>
