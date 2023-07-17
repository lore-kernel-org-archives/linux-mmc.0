Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5141C001DC
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Jul 2023 20:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQUE6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjGQUE5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jul 2023 16:04:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BDCC
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 13:04:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so6641730a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689624294; x=1692216294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I76Sas49+3M9ekKP/7ht8hPC9v5gon7krQLvrpuLnTI=;
        b=kD7qJO0Wnw3ipxc7bweaS63c++QVlzCsrQekZjmx28RC5UFVbFKnY0c/RROj2sVvNR
         53/FmNf7Cb7kMcnEYupN6pZ/Q4qFx/k6BXG4BOG/y4viI6ZgAwRbR2ityeeUl4RyhSAE
         pUv+hITUmkk91bXJV37Szmpd5Z6HY7mUvZ1Uk7zTKY6IpHWR5e9Jx9kexgcwKPSooywv
         osyFo5qIMeZ1QC5mbqrw8aEoCMV0X3Aus2fx++qGBs/RYmCNKfZ4AKsGt35Hcqm7gwLz
         xGnswyhZJ0vxtz5P6yGwt6y4KHxgtsNipgpZMrfFeTRkifM5Itr0oPxMZAKMx9VOBVGo
         DJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624294; x=1692216294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I76Sas49+3M9ekKP/7ht8hPC9v5gon7krQLvrpuLnTI=;
        b=SUJkqUJ5nK99w301g9vR3DkWYezDBD/ZyBE0EoQNunXxNJ4w3zNvwK+RErX36BfiCH
         HeREzsMAG19dsYgjHNHs7mFc+hu2R5/Ecgo37tfuBSMC23OMpyGl48mf9viYdhvJh5vM
         aDMOwbc6OHXTHSUMfL9lM8VaQrhoVHfW39+xt8+1Dyh1LPIVPWlGkMrvnYBWSaqhFNQn
         bNKjWDPQcWJCZMchRgBBKSN9hpkkBrZ6b5SCf4696HMGZj1g8QUj/Le03fztEcOXnl96
         VbX7kkO2/IDZbquWVrUNNZeKmHr22+WOzDasT8Mj4ArpiK0CiyGkRMA+dJdBV6SDa6hy
         QM5g==
X-Gm-Message-State: ABy/qLZJrr6Q5WYwllPIDN+hA/t4K6VfBJ+Lkxd78DNogmRQIGLj6Aeh
        L1CPfEFypIPKCyc/xybsBPdcDg==
X-Google-Smtp-Source: APBJJlHuA9Bvh2MuZ0h6VH93okT5lM95OFaGlwZCdxHMq0phGKHw+Qu4iLZsc4btdeov/x3+8WXB0w==
X-Received: by 2002:a05:6402:541:b0:516:81d3:2627 with SMTP id i1-20020a056402054100b0051681d32627mr15167008edx.0.1689624294498;
        Mon, 17 Jul 2023 13:04:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i19-20020aa7dd13000000b0051de3c6c5e5sm63518edv.94.2023.07.17.13.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:04:53 -0700 (PDT)
Message-ID: <b236b46f-d6de-21f1-d535-680518a0b945@linaro.org>
Date:   Mon, 17 Jul 2023 22:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/6] mmc: sdhci-cadence: SD6 controller support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230717125146.16791-1-pmalgujar@marvell.com>
 <20230717125146.16791-4-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717125146.16791-4-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/07/2023 14:51, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> Add support for SD6 controller for Marvell CN10k SoCs and related ops
> along with support for HS400 and HS400ES emmc modes.
> Updated HS200 tuning values and support to read tune configuration
> from FDT and support to configure and read host side drive strength,
> slew from device tree.
> 

...

>  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
> @@ -518,8 +1752,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_cdns_priv *priv;
>  	struct clk *clk;
> +	bool sd6_ctrl;
>  	int ret;
>  	struct device *dev = &pdev->dev;
> +	sd6_ctrl = of_device_is_compatible(dev->of_node, "marvell,cdns-sd6hc");

Don't sprinkle compatibles in probe. You have match data for quirks and
flags.

> +
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>  

Best regards,
Krzysztof

