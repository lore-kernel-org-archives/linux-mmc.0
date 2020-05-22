Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9BAC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD643206B6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGloSf/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEVM2g (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgEVM2f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:28:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F6CC061A0E;
        Fri, 22 May 2020 05:28:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so10239897ljn.2;
        Fri, 22 May 2020 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yaJggxw2oIQGUD00rImm8KRBGAMLEQqQBPoYb1Fa4Ck=;
        b=EGloSf/UXkcsDMqaZec3Xpo3n4+fWfy9h5AHdSyfXZGqdXD7TSQxqSxWhr4BEDq1tx
         v47DvPaelw68pGvGgRPH/QMhFs27pW4jfbDthNLAo2nzjiAwzR/g5H8IvEAQV8v7x0/F
         gJgLcq8K7aVqEuMPf4jdmD1DjcLk1s9ctWmIi/PHjobQXFUwQojNcE6544NRkzO1h9vD
         McI51YamolIvZCXbbA/L/jugPJQC5B8k5z74LeJUn3VgYDn187kiA+bSzgmrgv/qyKoI
         Hj2vix0I+ZXYhr5OSG5pmi5yJqoexDkZVqCVUT2eWegoR6vzGi+KHmBp2H/9XR4IiEJg
         PwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yaJggxw2oIQGUD00rImm8KRBGAMLEQqQBPoYb1Fa4Ck=;
        b=g5U8E41JhxQmxZQzZQB7q7I3zuts8+bQvYNY0RxXtX1GhVztFhjzCO6P+lYE2fPauS
         ohwPE/yL1njRXiOQ4lNr5kQBx6ibP9/9uL9NDV0Bf2oSfyMfYZFyNTmrcKA4HcyqFwy6
         qgnZyzJRwEzrOrvrUzfnYwrfk4K2fgHCbAzw4tCMvAiI/+MVaoVzCV4L1ecbYgrlw8Y5
         JkzTVkg6ZmG7pSOb64GlWOS39NTypXVac6fej7kB84UHg5SpxKcLaAXEYbkiyTBRUhMm
         l6Z7sa+pxxtzEIfXEdEBsGmfBD65zuqrh4/YafFZuZ7ngfuh07WLQFddakJqZ5jDdwxV
         CwLg==
X-Gm-Message-State: AOAM5337jZpnSSTzp+n5v/JUuSW8ps1gy0vplrBoJ7we2AbGsY5OC4Vo
        ZI/Hf+LMTr44jzOI9ANxrIwlDdUk
X-Google-Smtp-Source: ABdhPJxaY4jza3ZNZHABNZueKZfGSk2n7W6UQwcam6yrwTDmNtnh24IG6raE2jyRxPm4rdZfoO8r+w==
X-Received: by 2002:a2e:88d5:: with SMTP id a21mr4507777ljk.31.1590150513669;
        Fri, 22 May 2020 05:28:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id s2sm2303961ljs.39.2020.05.22.05.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 05:28:32 -0700 (PDT)
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4ac18003-e855-43d1-91d2-b4fa7904dba4@gmail.com>
Date:   Fri, 22 May 2020 15:28:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

20.05.2020 23:08, Sowjanya Komatineni пишет:
> When auto calibration timeouts, calibration is disabled and fail-safe
> drive strength values are programmed based on the signal voltage.
> 
> Different fail-safe drive strength values based on voltage are
> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
> 
> So, this patch avoids reading these properties from the device tree
> for SoCs not using pad controls and the warning of missing properties
> will not show up on these SoC platforms.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 3e2c510..141b49b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>  		autocal->pull_down_1v8 = 0;
>  
>  	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
> +			&autocal->pull_up_sdr104);
> +	if (err)
> +		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
> +			&autocal->pull_down_sdr104);
> +	if (err)
> +		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-up-offset-hs400",
> +			&autocal->pull_up_hs400);
> +	if (err)
> +		autocal->pull_up_hs400 = autocal->pull_up_1v8;
> +
> +	err = device_property_read_u32(host->mmc->parent,
> +			"nvidia,pad-autocal-pull-down-offset-hs400",
> +			&autocal->pull_down_hs400);
> +	if (err)
> +		autocal->pull_down_hs400 = autocal->pull_down_1v8;
> +
> +	/*
> +	 * Different fail-safe drive strength values based on the signaling
> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad controls.
> +	 * So, avoid reading below device tree properies for SoCs that don't

typo s/properies/properties/                      ^^^

> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
> +	 */
...
