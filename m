Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E66C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  1 Oct 2022 09:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJAJZz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 1 Oct 2022 05:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJAJZy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Oct 2022 05:25:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDEB40BE3
        for <linux-mmc@vger.kernel.org>; Sat,  1 Oct 2022 02:25:52 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bs18so5511788ljb.1
        for <linux-mmc@vger.kernel.org>; Sat, 01 Oct 2022 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zDKG4xvaTROTTwvu1n5jojrvui3PrTe86kZ7nDAgig0=;
        b=Hc5YObQXfvDHWU48NuQC+7/kgVe5mXh4LNq+HcBKh7ANpEGdWwljCCfga5Yb9COYag
         JYq8OJUKaRJZyjsh0v45jrgcr7acCT0jk8nx9LZvAoxUi1wxUuulAd5viSS0INTyv9G0
         xE4iBhIFiT1bqck597wQjvUxi/bNwSrgJPHpK7q+gvQepGl0YoeWZCGO6LnjOabFnbD+
         iULEiMw+oI0vJuHjCCvZkFMOIlHseOjdAIIBAI5MxLK1/tugIlXNxhSSmeEOh5nRAK6V
         mTpnqnRDi2lIi9DEjdVDhK9b7XI9pFWtPQ/MefVfDqOoHKdrWbNj+Z7YQ6egLsH/Tsnr
         ytxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zDKG4xvaTROTTwvu1n5jojrvui3PrTe86kZ7nDAgig0=;
        b=oTDDrHBM53bMtJq5WTEtFJLUA6uVb3Sjw+R+LeF58/rIbD0ces0Fd2K8BggnFyD/c3
         1/Dkmm1/3HvhkxuLqRh2NEUovbhAycG+Pt2P/golIUtpDJWtCBIrAFls7l4KY+lW59BW
         WthBos/A6PeCwy5sagrA/EbATMdYgIwaq/Kn3Q0vhwrF2EC18E4E/fWOmGbm/qsKJeyb
         5r+gMEyJ8w6dvK4Ma0Hx7orGvZPcrayiffmYwmD8Vse2vHuS7OhS4KQjPEBciIcSOBMo
         TkIVa19DZxpenSD5Wl+M2TdH4FYGwbb+cECJckmba2a6yqw8C7KGB3CiJHrGmsCvX0d6
         z1sA==
X-Gm-Message-State: ACrzQf0BvZxvfKixjf8ODdeVIVXg8WyNqaVDtFljKVBsPAxOr0XNW2wk
        wYuk6mABIRNzf3nI8cvC/6XEpy/deQBQzA==
X-Google-Smtp-Source: AMsMyM6L0UreN90dNJ8WzYrRKQf6N9NmkMMy/Q1cI2aGdCdQT6mXeu+XgtWmscSuRQJZKmh0Pp+sjw==
X-Received: by 2002:a2e:bd0e:0:b0:268:c03b:cf56 with SMTP id n14-20020a2ebd0e000000b00268c03bcf56mr4015713ljq.393.1664616350834;
        Sat, 01 Oct 2022 02:25:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i8-20020a056512318800b004a05402c5c3sm705576lfe.93.2022.10.01.02.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:25:50 -0700 (PDT)
Message-ID: <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
Date:   Sat, 1 Oct 2022 11:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030641.29354-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/10/2022 05:06, Melody Olvera wrote:
> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index c5b76c9f7ad0..b47a5dda3c3e 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -51,6 +51,8 @@ properties:
>            - qcom,scm-sm8250
>            - qcom,scm-sm8350
>            - qcom,scm-sm8450
> +          - qcom,scm-qdu1000
> +          - qcom,scm-qru1000

Items should be ordered alphabetically.

>            - qcom,scm-qcs404
>        - const: qcom,scm

Patch is incomplete. Missing changes for allOf.

>  

Best regards,
Krzysztof

