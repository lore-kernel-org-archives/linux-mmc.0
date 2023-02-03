Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28FAC61DA4
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Feb 2023 09:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCJCj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Feb 2023 04:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjBCJCh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2023 04:02:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD269928E4
        for <linux-mmc@vger.kernel.org>; Fri,  3 Feb 2023 01:02:36 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so5519161wmb.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2023 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2aiCKLplfBwX38ykcuLOaza164bQFv98FeeJ7x8FKo=;
        b=IHQ5dxA3E39PcS7l2mnGFejvdya63XtTLOxXnNaryTsGL35LJ3P+W/+O17cVjN8CBQ
         Vl6p8iCa92W+Bu1vt/TtpQWNT+PWjT9bh1y6rw+cex5hKQXLX43+uKpdpAmdfre6v2mR
         WrrjjAi4C83DWeIGYezsmNofS4KltrsaCgdkqNQCchLxcCbxxslmo1v+8YMSSj5H8wXD
         9lqIogxZrRFuLtDW2Nn/LfXX9oS6pgul6Hhon+6Ok4ZQ+GJsPJ8Y0ZzcCtJkw0O8TWy0
         P2ycUmuIIT4PKBItag7PSuzMiIAiHFtefp0lCHOuQNXyjj7KAg461XnqtG+4ChxQ1vJD
         bXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2aiCKLplfBwX38ykcuLOaza164bQFv98FeeJ7x8FKo=;
        b=lNfgK/aXvD2RghqcG5cBu6YPZtGX5zV8231vjbiBBscvqFkOi38111f3DKfURZ35Mg
         5HThuJB+NNOrkHwlg7ThtMrLdKgEV6YdRHJsZECKNxafSg5FSMQQqDfRopj7ExsNpXvF
         ArpiQfu7qG7/rYrguCwQq1AAedILU9nbzbark0K9XYHOmNa10mzIKaZcgSch205+P3Wl
         KyTpj7unBt1NIiI6FWs70ZB0U9qbeCrSCy0HIWwqw2qpPcuYqXBxGuY5Y6NZAkDJl1tW
         Jfph8mvfqfn9VG2HAyKN9JBmE7Bolbg7Y+iuYTdEdcQ8WWuMt0ZOVPKMU5y8+tIwX3yz
         GEKw==
X-Gm-Message-State: AO0yUKWcjDzcUVTWbcDwZH3sJAtZ4qDHyXCR5hHY1Y+/2a9xiHNMzkBb
        20Sm4bZZVzGAfJjKXGMTctRuWA==
X-Google-Smtp-Source: AK7set8fAEK8Uz2xDND8RKaAbMEMsT8CBVBEB/JVTCIULoPRT91JYLEobcoPWf0bjmDyTEvfWixQTQ==
X-Received: by 2002:a05:600c:4f06:b0:3da:b40f:7a55 with SMTP id l6-20020a05600c4f0600b003dab40f7a55mr3958239wmq.6.1675414955338;
        Fri, 03 Feb 2023 01:02:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c450600b003dc433bb5e1sm2331776wmo.9.2023.02.03.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:02:35 -0800 (PST)
Message-ID: <3c5bda9f-08b9-f2ba-6951-9fc614d4debc@linaro.org>
Date:   Fri, 3 Feb 2023 10:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-4-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230203081913.81968-4-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 03/02/2023 09:19, William Qiu wrote:
> This adds the mmc node for the StarFive JH7110 SoC.

Do not use "This xxx". Use imperative mode.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> Set mmco node to emmc and set mmc1 node to sd.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>


> +
>  &gmac0_rmii_refin {
>  	clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 64d260ea1f29..ae1a664e7af5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sysreg: syscon@13030000 {
> +			compatible = "starfive,sysreg", "syscon";

No:
1. Undocumented.
2. A bit too generic. You should have here SoC specific compatible as
well (either as second or third compatible, if all your SoCs share
register layout).

> +			reg = <0x0 0x13030000 0x0 0x1000>;
> +		};
> +

Best regards,
Krzysztof

