Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB52C6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCLRQ6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCLRQ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:16:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EE439CCC
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:16:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd5so5941309edb.7
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678641414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRxsxskay5llPXS415DN4IN8IQbI6q5971f6Ju8jg9c=;
        b=RxNIigu1wAI14vwzdPNbYuv+DyXqLNLYc5++sQJbPy9DDm5a+UKF+QNGPGjr8w0oU2
         y5a7QsXzK24l0lHE3iq4jVr1rRDDb1p1zeO6x1dgBdynQE7/pzqkuEnX3zCzJfMqnphU
         nZiL/IATeUfnQS7+rWSHwfifxGGR2DkuLWS+KGL6yjSc/JYhXK/uNf6I1hMDHr0HkZmf
         kPbgGJYQlcUzF9kbUAkkSlQMCSoYGi0xN6hdqYz2gMQgmnaR8DBa46GjIyzHrl6K1BvQ
         qfoIcmmJ/ls6v4/j/m7EJZilVs6iOKriOXTv5i/9SQkINe7N6KlAQ6daur79HBMDD+25
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRxsxskay5llPXS415DN4IN8IQbI6q5971f6Ju8jg9c=;
        b=qWs73aF14dTStuyazdm5SfFkHQduzhe2oiZ2UBlUYta/GZe6u82AIChXWVrZNaNf57
         f5wLflygUcycwKmIGUBvKVJ5+ZplDrUgpsx9P20OJtOft3f5xBSCmaWASfZW00EVXdPa
         SvMt4rweFV0///f699of8Kwl0hSVQz5zYvllQqUi+iaa+KcxOpdGek5ksbuBTrK+txP3
         MeQcfNzMjlE2N8Yvlby2xuHE8yOdQxp/o3tB8B3FcF6U+SLKU2BA9FrA850sX6HTU1jU
         An7qB89oKjaUoFmsKIsngpc97IK5bt/WTIsQdOUBGH/TOzGikBlsenHEia5H7A4El1yH
         P1Yg==
X-Gm-Message-State: AO0yUKV1thp6sDWYnzZT1Qm8o1eRyZjfhcwFJGY40pjND81q7U/aohxj
        Y2QjSo5mmPX6HModMIUjjP0e7g==
X-Google-Smtp-Source: AK7set9sJEh3UDFs1Qb6/Jed4xXgK5Dtj6exgCdKPsLn04BF5Qp3phHtONrxm/N9VUj7UlYXWBh9Tg==
X-Received: by 2002:a17:906:590:b0:886:ec6e:4c1 with SMTP id 16-20020a170906059000b00886ec6e04c1mr37473079ejn.59.1678641413921;
        Sun, 12 Mar 2023 10:16:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g15-20020a50d0cf000000b004fa268da13esm2103151edf.56.2023.03.12.10.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 10:16:53 -0700 (PDT)
Message-ID: <0d46a128-bd65-90cf-6c35-00f5364b7ae0@linaro.org>
Date:   Sun, 12 Mar 2023 18:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/3] mmc: dw_mmc: add an option to force 32-bit access
 to 64-bit FIFO
Content-Language: en-US
To:     Sergey Lisov <sleirsgoevy@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1678640497.9030156-3-sleirsgoevy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678640497.9030156-3-sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/03/2023 17:59, Sergey Lisov wrote:
> Some Samsung Exynos boards using the arm64 architecture have DW MMC
> controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
> systems the 64-bit FIFO registers must be accessed in two 32-bit halves.
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |  41 ++++++++++-
>  drivers/mmc/host/dw_mmc.c        | 122 ++++++++++++++++++++++++++++++-
>  drivers/mmc/host/dw_mmc.h        |   2 +
>  3 files changed, 162 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 9f20ac524..768774f22 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -28,6 +28,8 @@ enum dw_mci_exynos_type {
>  	DW_MCI_TYPE_EXYNOS5420_SMU,
>  	DW_MCI_TYPE_EXYNOS7,
>  	DW_MCI_TYPE_EXYNOS7_SMU,
> +	DW_MCI_TYPE_EXYNOS78XX,
> +	DW_MCI_TYPE_EXYNOS78XX_SMU,
>  	DW_MCI_TYPE_ARTPEC8,
>  };
>  
> @@ -70,6 +72,12 @@ static struct dw_mci_exynos_compatible {
>  	}, {
>  		.compatible	= "samsung,exynos7-dw-mshc-smu",
>  		.ctrl_type	= DW_MCI_TYPE_EXYNOS7_SMU,
> +	}, {
> +		.compatible	= "samsung,exynos78xx-dw-mshc",
> +		.ctrl_type	= DW_MCI_TYPE_EXYNOS78XX,
> +	}, {
> +		.compatible	= "samsung,exynos78xx-dw-mshc-smu",
> +		.ctrl_type	= DW_MCI_TYPE_EXYNOS78XX_SMU,
>  	}, {
>  		.compatible	= "axis,artpec8-dw-mshc",
>  		.ctrl_type	= DW_MCI_TYPE_ARTPEC8,
> @@ -86,6 +94,8 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
>  		return EXYNOS4210_FIXED_CIU_CLK_DIV;
>  	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
>  			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
> +			priv->ctrl_type == DW_MCI_TYPE_EXYNOS78XX ||
> +			priv->ctrl_type == DW_MCI_TYPE_EXYNOS78XX_SMU ||
>  			priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)

This is getting look like a spaghetti code. I think this needs
quirks/flags, except of types. Or this ifs all over should be made a bit
smarter as all of these are pretty close to compatible.


Best regards,
Krzysztof

