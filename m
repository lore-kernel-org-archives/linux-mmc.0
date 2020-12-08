Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50632C1B0D9
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 23:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEF723A5A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 23:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgLHXzK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbgLHXzK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 18:55:10 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EFC0613D6
        for <linux-mmc@vger.kernel.org>; Tue,  8 Dec 2020 15:54:29 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so13700647pgg.13
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2020 15:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2rK9eXbFabJb72qqgAX1hLLY10/7BrTO5clSEsTqMCU=;
        b=Sgx6prnHlAsh2UMYUB9oN3T03kov3UHmJFXkIAaavgl/vGFAporMXy+AUASGS9Fi0T
         DamVmTSPFXcF/WpcZ8m24LQYPjWFjVK4V9lvVe0J9jSqy6YBtpTmBYeeY2SZOmrrBtpI
         53FGeoB6ppuZJmsORbDLwTFnFrHV7sbTeNhUFks6eLAg+AkCJDEKmBe6OYv2BPGpxjHE
         TDD6LLy5ySlnipXq6gEMkABw4xiAw5pBN3udLiQlDCuyHl6URq8ANRqVetC2/Sj1lUVk
         jnceRwZBvIB+QLTvgtp+PolIE0J27BBBxGRSXs9IHuqr/cCKLsFPRnW2QDyjJwYRVW61
         S5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rK9eXbFabJb72qqgAX1hLLY10/7BrTO5clSEsTqMCU=;
        b=RKsLcNsjo02BJyDaFTj7dXgPfAcWYoZWYOoeu5bc0s9vml+b+zzCvN1Yo7T1/MrT5n
         jSM4jzQ8VDS25dA4Euyu2WCr6ENRBhby1HFHbNJglvUpq/k/67LMjHSTn69EO4R30Vtq
         dLkRDJPvY9rcz31DRP7XIaU11xlerZJ8ZLv7A66UIaYetIC2z2uq52IYMUl98LwzrwWI
         wchxgLXfFlRSfsQow65/x35/mWTZcMhBxuaVeFxzd1fOZIqxPymteG+WtMU1FjTDL9gX
         Sa0JG6fCR01+1PQg9gETJ/zAj1OSdEi7SR1YJtofd5gIXI/lBjkhNoFlDv6ZixyR7jVZ
         dpxg==
X-Gm-Message-State: AOAM530TUH3GVfcCrV1O/YIvJh2oJ/9BQD8htyfqXqvRXKI5J+iqVcyu
        BgooGe1WL1+8QSlqiKDry9+E+Q==
X-Google-Smtp-Source: ABdhPJymLFoVA6st/R/6ICIUCnlgIQ2mzU0HofUTcy+4xtvDPxoNZuI2YP/rGfXQcIctAkDjwazN8A==
X-Received: by 2002:a62:f901:0:b029:160:b5d:fc40 with SMTP id o1-20020a62f9010000b02901600b5dfc40mr316964pfh.55.1607471669215;
        Tue, 08 Dec 2020 15:54:29 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id w4sm296254pjc.52.2020.12.08.15.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:54:28 -0800 (PST)
Date:   Tue, 8 Dec 2020 23:54:24 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH v2 7/9] dt-bindings: mmc: sdhci-msm: add ICE registers
 and clock
Message-ID: <X9ASMO7eby9bZumo@google.com>
References: <20201203020516.225701-1-ebiggers@kernel.org>
 <20201203020516.225701-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203020516.225701-8-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 02, 2020 at 06:05:14PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Document the bindings for the registers and clock for the MMC instance
> of the Inline Crypto Engine (ICE) on Snapdragon SoCs.  These bindings
> are needed in order for sdhci-msm to support inline encryption.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3b602fd6180bf..4f2e138439506 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -30,10 +30,12 @@ Required properties:
>  	- SD Core register map (required for controllers earlier than msm-v5)
>  	- CQE register map (Optional, CQE support is present on SDHC instance meant
>  	                    for eMMC and version v4.2 and above)
> +	- Inline Crypto Engine register map (optional)
>  - reg-names: When CQE register map is supplied, below reg-names are required
>  	- "hc" for Host controller register map
>  	- "core" for SD core register map
>  	- "cqhci" for CQE register map
> +	- "ice" for Inline Crypto Engine register map (optional)
>  - interrupts: Should contain an interrupt-specifiers for the interrupts:
>  	- Host controller interrupt (required)
>  - pinctrl-names: Should contain only one value - "default".
> @@ -46,6 +48,7 @@ Required properties:
>  	"xo"	- TCXO clock (optional)
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
> +	"ice" - clock for Inline Crypto Engine (optional)
>  
>  - qcom,ddr-config: Certain chipsets and platforms require particular settings
>  	for the DDR_CONFIG register. Use this field to specify the register
> -- 
> 2.29.2
> 
Looks good to me. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
