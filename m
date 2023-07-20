Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C613AC001E0
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Jul 2023 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGTLdQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Jul 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGTLdP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jul 2023 07:33:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3C5136
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jul 2023 04:33:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso5319525e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jul 2023 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689852790; x=1690457590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rJCba/mmTho9umzDbT239Fiu3jvHE4pY8on7mbmL+io=;
        b=gOAoNxhfX2kYxNlNRaNZTxC0M/gWR4kmF43LJb1my6uLNnz0T6yN4T7qTovpJ7y7QK
         brleXaPN5xTMr+5ePcHGcCp3L6OFExUzptNYN2WT8qQsECuUH3+ZOLS0cYwHziYFYdQJ
         +0IXJZEjz8kdXelO34mcuiw2Fndl7fhbpFM40YvKyCjJuuBgUy4FjVjLV1Ew8Dvz613G
         1y465Vx7t7R5YAZ++l5Cn4NSvCDBt1jq+oGbcIJsF1hnfB/SPTjfC8jDoRCzG9KGZjkF
         /LObAB6OOZuF0Nhw8pFHqF1kjIFWaNumSrzKae8csgDO3+FF6fI5ywD+MOm6R9mxyl5V
         WjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689852790; x=1690457590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJCba/mmTho9umzDbT239Fiu3jvHE4pY8on7mbmL+io=;
        b=bDRAme+TZEx9yNFbWnB2cbpbcwE1w35GfRHuighTjV9wCHriWPM9uJUlPnRKI5UGGL
         2Y+Iw5xcTeX7ZlPeHHYx/6TgzVqSTxcumuGg383fUPu9NgbDuHF7NaZ6y9lw7J8r6+S9
         3j+t2vYpFEu9aPtMO9qdw/jgi3Q0B80K35z7SWE/7vu2B+/j90OtFFkXyR4ZJ5ufLnuS
         jFvxdAR+M0YFGHgr0UrLiIsezYlQE3kS6LxuafPPZRrRARrjEErnFeCzRFePVGySLKTz
         rWVJk42TPJhsZcAf/vUo2qQnGfozag+9IsNZHbkmPNTFAqJNmEv7fqVrpiGwa9CzXOm3
         2Z9g==
X-Gm-Message-State: ABy/qLZgqIRU/THxrd55d5Xezgv3GGCrhWR6UZ/DHfY8KYCzxmgF2Bwu
        XefDezDYdf/4rMYqggx1phlXOw==
X-Google-Smtp-Source: APBJJlFa9JHDqvo+V4hP6LGgTBGeu3mRUWETwG+/y+nC7BQ//IZ4vUBwkQgjujUC0RzHXAixD+Jf3w==
X-Received: by 2002:a05:600c:219a:b0:3f7:e3dd:8a47 with SMTP id e26-20020a05600c219a00b003f7e3dd8a47mr3884194wme.11.1689852789922;
        Thu, 20 Jul 2023 04:33:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d438d000000b003159d2dabbasm1070284wrq.94.2023.07.20.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 04:33:09 -0700 (PDT)
Message-ID: <159e36d6-7806-0424-4e9c-2e07584450fc@linaro.org>
Date:   Thu, 20 Jul 2023 13:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v11 5/6] arm64: dts: Add ipq5018 SoC and rdp432-c2 board support
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com,
        andy.shevchenko@gmail.com
References: <20230616101749.2083974-1-quic_srichara@quicinc.com>
 <20230616101749.2083974-6-quic_srichara@quicinc.com>
 <53721566-2a85-76cb-a4cf-2819f08dfc85@linaro.org>
 <8e209cd1-aa52-b947-bffd-15931af58391@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8e209cd1-aa52-b947-bffd-15931af58391@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/07/2023 12:51, Sricharan Ramabadhran wrote:
>>>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>>   .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  72 +++++
>>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 250 ++++++++++++++++++
>>>   3 files changed, 323 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>>>
>>
>> NAK, please do not merge.
>>
>> It turns out there are some problems here (pointed out by Hariharan K).
> 
>    The changes from Hariharan K to rename the dts compatibles is not
>    correct. So the compatibles/names in this series should be used.
>    Hariharan can fix his series and re-post.

Thanks. Conflicting patches touching similar boards is however confusing
me a bit...

Best regards,
Krzysztof

