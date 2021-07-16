Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD9C636CA
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jul 2021 23:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D70F613ED
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jul 2021 23:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhGPX5y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhGPX5v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jul 2021 19:57:51 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89DC06175F
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jul 2021 16:54:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id a132so2090098oib.6
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jul 2021 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJGdspG2J1Lj8nevb/Lj+7rawdMA9S4WQ8v9/yvZMvo=;
        b=OkAzUjq+SaObhfByR+nUx5mgIQ3Mj2gMLVbecs/XMcl0FGNc538qnz06xKozYcDCH+
         T2G34oXtNn6K04Y3tJ/tzc7PAdF9ohrL/VszWgflvy/59nrcZM586yOU9z2qwdFfSxoz
         4rk+f/B2DvrfjOHw/2DRWu8foTSqwez0nexmMgwvUX65nMDUUOljQtPVEw1W9PqI6ixE
         uznwYPTE3PqGoglVJ3dT1PRSWyK40h86fx7eCXlJDVoUh4MiYQtlU7+rJSkLsB6WuQIX
         nb89ZRwBzc8ZP5sHAnolgZ4W7sX2x8Gm6XH2a9mu82raDwbjxpywlhcj7DuniAbxeSgJ
         oaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJGdspG2J1Lj8nevb/Lj+7rawdMA9S4WQ8v9/yvZMvo=;
        b=HYVDZ4DOf+0c2btUJM//r05iY8drmjFVXbJcGDFuoek8uNQIwqsJSVumSBQ5rroeiy
         BAoHZY4ZMajlD62lPG5fpgOTTn7gAHAgnl1i0wwy3Bmll2Kdz80ivQyfLntpH2tnjCoZ
         uf4fmLZ4oafsMEXodmLJuvxpjtYk/grTDD8E1gl5rHIFkiOKg39yNn0RA8SduikhSFne
         ZpKq3c+c6pf5eJKSrHlS8MBvgFjgtVdRbdQKN5tBwgSey8pCrcAjFqekCUka71mbe7ED
         8s1iJJ6JARP9xLDIvZ6qLSQ6k3ZRjriQIRtXRCKt3mIMpuWC+46LpjKd990Pe8fSymK7
         1ukw==
X-Gm-Message-State: AOAM532kZ3xplDgGcsMxswR2oOAaBpdDCHwFXxSfV2Hlrg9b7gcrb7jn
        5ibOfGpVGQ5BCVAmxZKYiYgyig==
X-Google-Smtp-Source: ABdhPJzPb0xrQfYz/QsYG3LsjhsCqhhunDjTyM/p4U47JfwRJ5DQarU6cR+d2fPgJkfLT6b+EUMmLQ==
X-Received: by 2002:aca:dc44:: with SMTP id t65mr9803129oig.76.1626479694464;
        Fri, 16 Jul 2021 16:54:54 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b10sm2434834oiy.4.2021.07.16.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 16:54:54 -0700 (PDT)
Date:   Fri, 16 Jul 2021 18:54:51 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V1 2/2] mmc: sdhci-msm: Use maximum possible data timeout
 value
Message-ID: <YPIcSx90JqhVn3A1@yoga>
References: <1626444182-2187-1-git-send-email-sartgarg@codeaurora.org>
 <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri 16 Jul 09:03 CDT 2021, Sarthak Garg wrote:

> The Qcom SD controller defines the usage of 0xF in data
> timeout counter register (0x2E) which is actually a reserved
> bit as per specification. This would result in maximum of 21.26 secs
> timeout value.
> 
> Some SDcard taking more time than 2.67secs (timeout value corresponding
> to 0xE) and with that observed data timeout errors.
> So increasing the timeout value to max possible timeout.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

The From: of the email says you wrote the patch, but the first person to
certify its origin is Sahitya. Did you perhaps write this together? If
so you should have a:

Co-developed-by: Sahitya

If Sahitya wrote the patch, certifies its origin and then you picks it
up and certify that you got it from Sahitya, then you should write it as
you did - but you should have retained Sahitya as author...

Regards,
Bjorn

> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e44b7a6..19e4673 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2696,6 +2696,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
> +	/* Set the timeout value to max possible */
> +	host->max_timeout_count = 0xF;
> +
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> -- 
> 2.7.4
> 
