Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32BC27C76
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Jan 2023 11:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAYLO4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Jan 2023 06:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAYLO2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2023 06:14:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64F582B9
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 03:14:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1016490wms.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2023 03:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5wejdOLs59m4/7efD+ZoqO+DCHMNBKyyQYGkCW8Bk9c=;
        b=zZV+TNnKIq14J/EJBQB8+nZwpanYv/Djpn9z23TFFmaWBR/HCRNwZaigXdq5nLeLM8
         mUHu/26N/jFqVw7q6mZ5JHtYplCHu+q+YkKzaZD4/FIlKsUjo3JV4RsyfTedNBXrhaEn
         2RvCFMm/JXTsHUb85DyhA95jt7ML/s0adraztfmRePkTPjbo7z5q/iB3KyZsKmIbH+dj
         FNCcYQp3j8LWdluRDOO5HOV/l9mG/hCMWTkf40mCvHzAJg1+g+qSdZIMAlH2orna09Si
         oFLjgu/sVFMWnc6m8QAuS8pvpJdtzR0BWRnUoa162+oSIt8GZK4GlL1Qe/QkfeQucatd
         ErZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wejdOLs59m4/7efD+ZoqO+DCHMNBKyyQYGkCW8Bk9c=;
        b=JKEci1RMfs6KgE0wkXW2ulPU3lXcNRvuAs6I0BgwHAJMjsRXKr7KebwvkqQide/SKb
         BiZFtGuqGdmNihloxPaF3wgLFt4UELgKRVAlgUyaQQZZ/WP58KOmjSTZzKz7eAAoG0Er
         OjU5IrCO0WGDd1yaD80DZaAJYMiI1gK9IT9UzlEbreK6nPrj32Z+dWYJb0BRgTopsZTw
         sYtorolyuD0GScTARyOh/3hjXkXpUlJlJ1Tc9/1iurMjBw8oWfE/7kuyRHtKtoJEVlS0
         B3OU9pZ82s1R/Op++vwg9lXKnZFCBswh7WDu9EG8q5XsCRFkwiooBM+JpA1pENcwbIv/
         0xSg==
X-Gm-Message-State: AFqh2koXOFzLmu9V6RuUVmPWlQTs+Uhpm0kMxUMDgyfqUa4r8XQpOPhS
        YxbrUzLLk81vt+ekH6P8rb/MvA==
X-Google-Smtp-Source: AMrXdXseqbUMqqOQ++27ChVRe93u86F2Gctz414bk0UDKGbgY3mZn3GdXOlDWRS/DFh0tjsKNtsmpA==
X-Received: by 2002:a05:600c:468f:b0:3dc:c5c:b94f with SMTP id p15-20020a05600c468f00b003dc0c5cb94fmr6842124wmo.39.1674645260611;
        Wed, 25 Jan 2023 03:14:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c130f00b003db0659c454sm1774127wmf.32.2023.01.25.03.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 03:14:20 -0800 (PST)
Message-ID: <4dc231f5-fad4-6093-851d-afcc0f68e045@linaro.org>
Date:   Wed, 25 Jan 2023 12:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 05/10] clk: qcom: add Global Clock controller (GCC) driver
 for IPQ5332 SoC
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-6-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230125104520.89684-6-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Add support for the global clock controller found on IPQ5332 SoC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig       |    7 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/gcc-ipq5332.c | 3954 ++++++++++++++++++++++++++++++++
>  3 files changed, 3962 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq5332.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 70d43f0a8919..1d300c89ecfc 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -141,6 +141,13 @@ config IPQ_GCC_4019
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
>  	  i2c, USB, SD/eMMC, etc.
>  
> +config IPQ_GCC_5332
> +	tristate "IPQ5332 Global Clock Controller"

depends on ARM64 || COMPILE_TEST



Best regards,
Krzysztof

