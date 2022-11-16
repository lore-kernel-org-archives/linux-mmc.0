Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C45C43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 08:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiKPIcL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 03:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238936AbiKPIbp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 03:31:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA132A707
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:29:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g12so28414509lfh.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hOjQ8ZqJCJ4XjyB8rqTKWkM81Yey0vtzEtDeEu0P90I=;
        b=ddQzH/c2j2Si8AIuiK1A0Rq1ixXSilknotZ052ApAz7qYx9AV+DoM07IK4rHpZFrUy
         sy/B8x0Y38ioefWRDHtuYSuioS2LzeZqfFeob32keLihp0F/Xy3RzMo7BIuq2Wx2pBhk
         XkjbdberdCUJXyB5BgWf1HuPpVnRI0mpNcmCll6Uvjk2X4xO1QY/IpvH3r++aa7pev12
         Juh57ArZguG+lA8VDe/w4FPfAGN+p8oILuuU5n950cCaVi1muIXyZ1QCmr3b/vwsHR0J
         SnL/Zmme82PHBh2IHfi9g5a7ZgmDwvkx08SxceQEIDe/xMa9JubBjjt5QIaOSW7nfXT3
         sTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOjQ8ZqJCJ4XjyB8rqTKWkM81Yey0vtzEtDeEu0P90I=;
        b=OaHMjWDidEx65+DLluaKF0X+OYhf+F6vDADyWdr/5lKD6soctR52+Id6OrCvYjX4Tx
         G17WHQCPiat+Sn0MmDEfK20nD4Dg5TK0SwGwSAfktab1rUN+kCrhf8uT7KLp8wzxxz2T
         DIysmzE6A90NcuVNuGfuLZ4YHJvmeuQ/RG4qwE3ljPFnvK9zohrD0ShTNw/xkrCWtjCZ
         2H4WsNzow93Q9n4+Rodg0hchP8otC9+zzg46uTHp5X+9XOHtATtw0dkIMCaHQPfdhAE9
         /SkRMhat8KMKYpz2BTbYLz3ShngbjEw6aoD9XNGuNT/Q9fhU637YBHW4bK8WJ32IFpA4
         aL5g==
X-Gm-Message-State: ANoB5plYjLScCD1Nu9Jac9vnK2ONv3b4V3ffuRIDymxjkSZlUIS3uRPb
        qhh5gOkj75+ryw9l/gyC75eDLQ==
X-Google-Smtp-Source: AA0mqf7rULVHcsf3HCvYdqj87GhYFRO63xMUx9uE9UbMvF2N35rMtDdJ3PniuUJlyYcTUYRDVJUddw==
X-Received: by 2002:a19:5051:0:b0:499:8e29:2763 with SMTP id z17-20020a195051000000b004998e292763mr7780310lfj.137.1668587344089;
        Wed, 16 Nov 2022 00:29:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w26-20020ac254ba000000b0049c29389b98sm2490272lfk.151.2022.11.16.00.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:29:03 -0800 (PST)
Message-ID: <7083614f-578c-7ed9-5f6b-c64718747dea@linaro.org>
Date:   Wed, 16 Nov 2022 09:29:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
 <20221115172828.14372-4-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115172828.14372-4-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/11/2022 18:28, Konrad Dybcio wrote:
> Adjust regulators, add required pin setup and finally enable SDHCI2
> to get the SD Card slot going on Sagami Xperias.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index a428ce31ab4e..fdf95b763cf4 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -312,7 +312,8 @@ pm8350c_l8: ldo8 {
>  		pm8350c_l9: ldo9 {
>  			regulator-name = "pm8350c_l9";
>  			regulator-min-microvolt = <2960000>;
> -			regulator-max-microvolt = <3008000>;
> +			/* Originally max = 3008000 but SDHCI expects 2960000 */
> +			regulator-max-microvolt = <2960000>;
>  			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>  		};
>  
> @@ -558,6 +559,19 @@ &qupv3_id_2 {
>  	status = "okay";
>  };
>  
> +&sdhc_2 {
> +	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_active>;
> +	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_sleep>;
> +	vmmc-supply = <&pm8350c_l9>;
> +	vqmmc-supply = <&pm8350c_l6>;
> +	no-sdio;
> +	no-mmc;
> +	status = "okay";
> +};
> +
> +

Only one blank line.

Best regards,
Krzysztof

