Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C1FC4167B
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Apr 2022 11:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351734AbiDSLn2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352323AbiDSLnL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2022 07:43:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130731EEDC
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 04:40:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so32273392ejd.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hcwhzmzfL26TAKtQRPD1wNariBwcxaFreylxMdtXb80=;
        b=MwJ/XiGAyyPrcSbgJo3k5Qt6BHxqWTh4LApUB/2udnABbiFsrTItmlOpmxNseH09Cl
         XEIoaRZ3y49NNb+TWkoxlJ7GuV+20JT+pL+P3yU/c0i/cnROK+4P4zhm7n1cg8negyHp
         Ecc7487RWUynXX95NupT0Plw9izrrFIhFv0YES89lwEyaabL8OFlMMDCvgySp5pQNJx6
         7MryYQIFMfSIo+XJ8rz/qDB8GNb+E1a0SISdkKqPte9xKldZyy9XMDN05AIq14B+OuCN
         s+obkZssE2zV+x7mrnmnEnEgzJDz9O/KfDs1/3RYl4YrlPd3tt7I0W8C3QIN3aDAyDby
         GCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hcwhzmzfL26TAKtQRPD1wNariBwcxaFreylxMdtXb80=;
        b=M0CNuW1qbb6qiPhK/9npf1h1wERJgaG+EWGliA3Ibv8XIn5NPLOSWGf+MrcAhdnagR
         dNIiixjgVkwxLZlWUv6UyWdl4upZjaZLYkPzmj2D2VctHST5eiEMWjbWbXiZ/Fs3gEn8
         NSIzSptIOoYwfJ/k4usGjM0wMwJMTIs7pVPMELjFOoWxMRkdrVYz5vXCT/BWgguqY07J
         +4T083Ak2MzvrOPIrkrVsCdgksWuymuSdIwLW6lSTi5WCSFPS9oFo9ScFL5qvfiDfrt0
         nL0yqu4KjFrg7qprAqa1aIHa4EQDygzswrAXT+fVH8xX5ibRIhLisL+y6P6JwL5bCGCb
         LCIQ==
X-Gm-Message-State: AOAM532YpwGrnhYmwmbi1wpoQC4jB/B47TAJrL1qHNmvY+t7UCo4vkFN
        O1ZMRKAC84/N1c10W24NiEsHfw==
X-Google-Smtp-Source: ABdhPJz1P9B0z3QsIUrpZk+2ju/oxQxuz+zzvYNFL0xJnzmXCwLmLp18B+zu9L//zCVqfBZ1agRh0g==
X-Received: by 2002:a17:907:a425:b0:6ef:8e2f:4215 with SMTP id sg37-20020a170907a42500b006ef8e2f4215mr10377380ejc.283.1650368422694;
        Tue, 19 Apr 2022 04:40:22 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b20-20020a1709063f9400b006e12836e07fsm5600637ejj.154.2022.04.19.04.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 04:40:22 -0700 (PDT)
Message-ID: <efb859ec-4ca4-ca2e-bc6c-c3e50e779dc6@linaro.org>
Date:   Tue, 19 Apr 2022 13:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 06/13] arm64: dts: freescale: Add i.MX8DXL evk board
 support
Content-Language: en-US
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
References: <20220419113516.1827863-1-abel.vesa@nxp.com>
 <20220419113516.1827863-7-abel.vesa@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220419113516.1827863-7-abel.vesa@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/04/2022 13:35, Abel Vesa wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> Add i.MX8DXL EVK board support.
> 

Thank you for your patch. There is something to discuss/improve.
(...)

> +		/* global autoconfigured region for contiguous allocations */
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0 0x14000000>;
> +			alloc-ranges = <0 0x98000000 0 0x14000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
> +	reg_usdhc2_vmmc: usdhc2-vmmc {

usdhc2-vmmc-regulator or regulator-0

(...)

> +&thermal_zones {
> +	pmic-thermal0 {

Are you sure this passes the dtbs_check?

> +		polling-delay-passive = <250>;
> +		polling-delay = <2000>;
> +		thermal-sensors = <&tsens IMX_SC_R_PMIC_0>;
> +

(...)

> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			IMX8DXL_EMMC0_CLK_CONN_EMMC0_CLK	0x06000041
> +			IMX8DXL_EMMC0_CMD_CONN_EMMC0_CMD	0x00000021
> +			IMX8DXL_EMMC0_DATA0_CONN_EMMC0_DATA0	0x00000021
> +			IMX8DXL_EMMC0_DATA1_CONN_EMMC0_DATA1	0x00000021
> +			IMX8DXL_EMMC0_DATA2_CONN_EMMC0_DATA2	0x00000021
> +			IMX8DXL_EMMC0_DATA3_CONN_EMMC0_DATA3	0x00000021
> +			IMX8DXL_EMMC0_DATA4_CONN_EMMC0_DATA4	0x00000021
> +			IMX8DXL_EMMC0_DATA5_CONN_EMMC0_DATA5	0x00000021
> +			IMX8DXL_EMMC0_DATA6_CONN_EMMC0_DATA6	0x00000021
> +			IMX8DXL_EMMC0_DATA7_CONN_EMMC0_DATA7	0x00000021
> +			IMX8DXL_EMMC0_STROBE_CONN_EMMC0_STROBE	0x00000041
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {

and this as well... I don't remember if we have schema for this but even
without it, it breaks the convention. See other files.


Best regards,
Krzysztof
