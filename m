Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39455C77B7D
	for <linux-mmc@archiver.kernel.org>; Wed, 10 May 2023 12:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbjEJMyt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 May 2023 08:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbjEJMys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 08:54:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AEF49EB
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 05:54:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f42c865534so18150995e9.2
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683723285; x=1686315285;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DsPeOMPF8LMsfujWKUmhb5P5Qm+Y5emVq+pEA4n3YfU=;
        b=vgGMtv0Z8dWkBLZETAjMPca0sTA0GXeNY2meKWGf6GZCT+YgiaWWVlfCaaWfGU2MfI
         uSPD6O1g2cz5QDgy/l30Hys/2tjFl+l3EmTVGfIMGTOUphTsN1iMYT+zR+2QPllsjwzo
         gaodANu4pPTAlODyHoNWwH2vR/sKW0hLS+q8q9YYCbE8O2nnuvjdUTlu/oUV/viRFoFI
         EHjWKFDECumotp9kw7ObscpJ+ISLNeHfEoTRibUjp/B5JByatMI49xLqObo2b3UDpR1H
         MUlSx4ViCKjnIaDeeqxYwVybCPFZyd08yhXEmJdBNvtu7nt0thshH3iIGUuHChlzMoBz
         khGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683723285; x=1686315285;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsPeOMPF8LMsfujWKUmhb5P5Qm+Y5emVq+pEA4n3YfU=;
        b=UY4ryDYCOBtqbgs4lotPASQkhQ6JK760NJngEwhTZ8pxVo5A1eFDjxxhZcGqO1N/Jv
         BC7mYjVvSzXiHF9py0EGtfyyLaB/WPcWJEaVr2Zc71Lo6X3/yw0Nco2a/IUzu3wnin/J
         M2grAagmJO0G3bXJ0yDBOWaEUNaJ9zs2XF3x8wGy8LvXblPCkOgg98RGdeQsKYe8+QVK
         oDoHh8w+WO/y1F22DY6fCm0GS37s1Id3NLjCh2lVGagQn/HHKadNlEfLKOhSah6aR3HA
         c4s0zwjEU8znP1R3i4b7TodAQg70uT5XFAvXSvPJFR4WG4ZxaBcuWY7cMi8BjpwBTWIQ
         hCnQ==
X-Gm-Message-State: AC+VfDyKz/8MzgpImafIvUXyeWcU1zQAhAEe2mSMtiPjbu8O/sfen9dN
        R8oOeNNCtt4oH6wP/gDWlV1qOw==
X-Google-Smtp-Source: ACHHUZ5fGwpDlDihF+FQJ3nyzntea8nQCmV/QQWHmnUMJ3kkiuW6ZAn09HPIcHOLDS5Do3lkyOg7TQ==
X-Received: by 2002:a05:600c:2313:b0:3f4:2266:8cef with SMTP id 19-20020a05600c231300b003f422668cefmr9445090wmo.31.1683723285344;
        Wed, 10 May 2023 05:54:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2ee9:7e58:bce6:9219? ([2a01:e0a:982:cbb0:2ee9:7e58:bce6:9219])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c210500b003f427cba193sm7559862wml.41.2023.05.10.05.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 05:54:44 -0700 (PDT)
Message-ID: <4633b31e-6fd3-829a-ceaf-59087edb854e@linaro.org>
Date:   Wed, 10 May 2023 14:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Avoid cast to incompatible function
 type
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, llvm@lists.linux.dev
References: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230510-mmc-sdhci-msm-function-cast-v1-1-5ae634b24fbd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/05/2023 14:39, Simon Horman wrote:
> Rather than casting mmc_free_host to an incompatible function type,
> provide a trivial wrapper with the correct signature for the use-case.
> 
> Reported by clang-16 with W=1:
> 
>   .../meson-mx-sdhc-mmc.c:791:38: error: cast from 'void (*)(struct mmc_host *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>           ret = devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
>                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/device.h:265:38: note: expanded from macro 'devm_add_action_or_reset'
>           __devm_add_action_or_reset(release, action, data, #action)
>                                              ^~~~~~
> 
> The same approach is taken in litex_mmc.c with the function
> litex_mmc_free_host_wrapper(). There may be scope for consolidation.
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/mmc/host/meson-mx-sdhc-mmc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index da85c2f2acb8..97168cdfa8e9 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -776,6 +776,11 @@ static void meson_mx_sdhc_init_hw(struct mmc_host *mmc)
>   	regmap_write(host->regmap, MESON_SDHC_ISTA, MESON_SDHC_ISTA_ALL_IRQS);
>   }
>   
> +static void meason_mx_mmc_free_host(void *data)
> +{
> +       mmc_free_host(data);
> +}
> +
>   static int meson_mx_sdhc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -788,8 +793,7 @@ static int meson_mx_sdhc_probe(struct platform_device *pdev)
>   	if (!mmc)
>   		return -ENOMEM;
>   
> -	ret = devm_add_action_or_reset(dev, (void(*)(void *))mmc_free_host,
> -				       mmc);
> +	ret = devm_add_action_or_reset(dev, meason_mx_mmc_free_host, mmc);
>   	if (ret) {
>   		dev_err(dev, "Failed to register mmc_free_host action\n");
>   		return ret;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
