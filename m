Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD84C43219
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Nov 2022 19:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKDTLn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKDTL3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2022 15:11:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A869DD3
        for <linux-mmc@vger.kernel.org>; Fri,  4 Nov 2022 12:11:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w4so3642325qts.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2022 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arMRCILA/fIuamA+i5ucpM6bm3qs5bxen8Q+JsaLECQ=;
        b=HAWF5B1mgqAHFNBENQJzhZlROomhbvU4tcjNQEpNh3x05uC4GIgjtmAv+7SV473nC+
         eSWz9nfktwRwrShoZPdi7qmuQODgWb9xb+HIXiJF1siaQuw6P8mzPU6SoVh9/O25K/M/
         KcjqjFXsHNB+Oi9Y2Y1SlStUxja86eZ0PDx4kDwTZBK+gLwI8VrEuKEeOcHoCaiMcA/Q
         S4G7sktS9By1/YDQXB00/Nv+GpmLTV1kHaKwzTxT7Icbyndp71UVCQPYHnbwkXZe5ixX
         0bk2GmPvOGYFxgWId4EdyiE7xUGOVITxlsWZKHIdPTVQfRk1aX1rrg6Ae8Ja/l0MSD0l
         HqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arMRCILA/fIuamA+i5ucpM6bm3qs5bxen8Q+JsaLECQ=;
        b=iJ6iMK3CIbwZdpiLfJ4KjqQXmGA3i7ta+Bubog3XvH4m80TeM1T3h+OkyPRupOiqXc
         +7vxuS6SNFQonlIaBsROxLpbTrwvpOvrmMQdqrjPyJj6iggrppUMvPA2SkyUnqWzCDd2
         Wni0NlvXChEWITVZy/BFAWzrB+NOo9my13er8hU5Ef6IkipsyO7t7UrJJyJLVJO9oFvZ
         wcGP5NYWK3FwTZteqWZxARDZN4tcaF4MNJJWjI1czSkztEdRD9rtIkG7oWSf/JkzlcRn
         aYjInhi1JT1vXjab5rMS5xNxGHHr1rBRaCqk901WlS/gkpaI7F4SDwSr+o9gvAUYPo4L
         kmgQ==
X-Gm-Message-State: ACrzQf30VbAPWIpdDWZwx7M5bWZxGLd8wmmTCoiml14Pk6TtWTEthgIO
        KHgbDhS+lEiUrPINyQNlsQs5KQ==
X-Google-Smtp-Source: AMsMyM7e+8kdsKkMsUNNtmBQLn4cmi/4NDnvE0DsL6/EpJktIGjc79JqMFqE6+odDdpBixA+iA57eQ==
X-Received: by 2002:a05:622a:1110:b0:39c:d568:8b26 with SMTP id e16-20020a05622a111000b0039cd5688b26mr29320361qty.280.1667589087326;
        Fri, 04 Nov 2022 12:11:27 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id cm5-20020a05622a250500b003a4f22c6507sm66130qtb.48.2022.11.04.12.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 12:11:26 -0700 (PDT)
Message-ID: <488b7796-e596-e15e-fe5f-18211516c0de@linaro.org>
Date:   Fri, 4 Nov 2022 15:11:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 9/9] arm64: dts: qcom: Add support for SONY Xperia X/X
 Compact
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-10-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-10-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This adds support for the Sony Xperia Loire/SmartLoire platform

Thank you for your patch. There is something to discuss/improve.

> +
> +&rpm_requests {
> +	pm8950_regulators: regulators {
> +		compatible = "qcom,rpm-pm8950-regulators";
> +
> +		vdd_s1-supply = <&vph_pwr>;
> +		vdd_s2-supply = <&vph_pwr>;
> +		vdd_s3-supply = <&vph_pwr>;
> +		vdd_s4-supply = <&vph_pwr>;
> +		vdd_s6-supply = <&vph_pwr>;
> +		vdd_l1_l19-supply = <&pm8950_s3>;
> +		vdd_l2_l23-supply = <&pm8950_s3>;
> +		vdd_l3-supply = <&pm8950_s3>;
> +		vdd_l5_l6_l7_l16-supply = <&pm8950_s4>;
> +		vdd_l8_l11_l12_l17_l22-supply = <&vph_pwr>;
> +
> +		pm8950_s1: s1 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1162500>;
> +		};
> +
> +		pm8950_s3: s3 {
> +			regulator-min-microvolt = <1325000>;
> +			regulator-max-microvolt = <1325000>;
> +			regulator-always-on;
> +		};
> +
> +		pm8950_s4: s4 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +
> +		pm8950_l1: l1 {
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1100000>;
> +		};
> +
> +		pm8950_l2: l2 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pm8950_l3: l3 {
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +
> +		pm8950_l5: l5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l6: l6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l7: l7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l8: l8 {
> +			regulator-min-microvolt = <2900000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8950_l9: l9 {
> +			regulator-min-microvolt = <2000000>;
> +			regulator-max-microvolt = <2400000>;
> +		};
> +
> +		pm8950_l10: l10 {
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8950_l11: l11 {
> +			regulator-min-microvolt = <2950000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8950_l12: l12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +		};
> +
> +		pm8950_l13: l13 {
> +			regulator-min-microvolt = <3075000>;
> +			regulator-max-microvolt = <3075000>;
> +		};
> +
> +		pm8950_l14: l14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8950_l15: l15 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		pm8950_l16: l16 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		pm8950_l17: l17 {
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2900000>;
> +		};
> +
> +		pm8950_l22: l22 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +		};
> +
> +		pm8950_l23: l23 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +		};
> +	};
> +};
> +
> +&sdhc_1 {
> +	status = "okay";

Status as last (everywhere)

https://lore.kernel.org/all/5158fe83-88b1-1081-df7f-4118ce6f5ec0@somainline.org/

Rest LGTM.

Best regards,
Krzysztof

