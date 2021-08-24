Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB9C432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5970610D1
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 12:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbhHXMYg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:24:36 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36842 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbhHXMYg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 08:24:36 -0400
Received: by mail-ot1-f45.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso24517372otv.3;
        Tue, 24 Aug 2021 05:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZSW/BLziM3Q7jIwrUK8AKWwZKpBaFAY0kb/eAwqd/U=;
        b=JZhlxUGPWDzPPAX9C235gD05wJNTtr+V77373BypZgzoKFkFQ54cCaPRQFnHfZofP6
         AtjRSVYVcS2xHJWJBVoLoO+RrimDCccUKEY63M4blmdxeG9K5iLZnWp3Wx6+yH0MOUDF
         kAbw+5tN3fS3AlgSgGY6hs+NWQTNJ7nmlwOtqMC0zW53YHrcOFPpP0mti1D02QaqFBeB
         sqh2ylZLLu4PR2GTT3k9bsH6CWVMvvJUG3Gb+UqynYi8FUFcTY877H52XFZdF/mjspx1
         sIHo+tMJ4ghkuT2rshw6f7VsnQQFG6PjMbgh2rh6+6fXnWGOYlNcuMaI+BWx5HMM45Y4
         RPRg==
X-Gm-Message-State: AOAM530kkL2k4D3EmKUixxzFSYVyoqMplMoJ5+vJYEssPgH1E9BllEMg
        Kw6F2grMNSEfJmzOGIwpYg==
X-Google-Smtp-Source: ABdhPJw7949dHrXxcRZpb3Hi5lQslUdliu8+BH2hvHdXh7RS/ViIbotdMway2tu5VInAclD5gYi/pw==
X-Received: by 2002:a9d:1408:: with SMTP id h8mr30431672oth.151.1629807831822;
        Tue, 24 Aug 2021 05:23:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p2sm4381433oip.35.2021.08.24.05.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:23:51 -0700 (PDT)
Received: (nullmailer pid 51050 invoked by uid 1000);
        Tue, 24 Aug 2021 12:23:50 -0000
Date:   Tue, 24 Aug 2021 07:23:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     ulf.hansson@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: at91: sama5d27_wlsom1: add wifi device
Message-ID: <YSTk1pUTAUJLBJQl@robh.at.kernel.org>
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
 <20210820092803.78523-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820092803.78523-5-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 20, 2021 at 12:28:03PM +0300, Claudiu Beznea wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> SAMA5D27 WLSOM1 boards has a WILC3000 device soldered. Add proper
> device tree nodes for this.
> 
> [eugen.hristev: original author of this code]
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> [nicolas.ferre: original author of this code]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 71 +++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> index 025a78310e3a..c7bcfd3ce91d 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> @@ -30,6 +30,15 @@ main_xtal {
>  			clock-frequency = <24000000>;
>  		};
>  	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-wilc1000";
> +		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
> +		powerdown-gpios = <&pioA PIN_PA29 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&pinctrl_wilc_pwrseq>;
> +		pinctrl-names = "default";
> +		status = "okay";

'okay' is the default, so you can drop this.

> +	};
>  };
>  
>  &flx1 {
> @@ -310,5 +319,67 @@ pinctrl_qspi1_default: qspi1_default {
>  			 <PIN_PB10__QSPI1_IO3>;
>  		bias-pull-up;
>  	};
> +
> +	pinctrl_sdmmc1_default: sdmmc1_default {
> +		cmd-data {
> +			pinmux = <PIN_PA28__SDMMC1_CMD>,
> +				 <PIN_PA18__SDMMC1_DAT0>,
> +				 <PIN_PA19__SDMMC1_DAT1>,
> +				 <PIN_PA20__SDMMC1_DAT2>,
> +				 <PIN_PA21__SDMMC1_DAT3>;
> +			bias-disable;
> +		};
> +
> +		conf-ck {
> +			pinmux = <PIN_PA22__SDMMC1_CK>;
> +			bias-disable;
> +		};
> +	};
> +
> +	pinctrl_wilc_default: wilc_default {
> +		conf-irq {
> +			pinmux = <PIN_PB25__GPIO>;
> +			bias-disable;
> +		};
> +	};
> +
> +	pinctrl_wilc_pwrseq: wilc_pwrseq {
> +		conf-ce-nrst {
> +			pinmux = <PIN_PA27__GPIO>,
> +				 <PIN_PA29__GPIO>;
> +			bias-disable;
> +		};
> +
> +		conf-rtcclk {
> +			pinmux = <PIN_PB13__PCK1>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +&sdmmc1 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	bus-width = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sdmmc1_default>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	no-1-8-v;
> +	non-removable;
> +	status = "okay";
> +
> +	wilc: wilc@0 {

wifi@0

> +		reg = <0>;
> +		bus-width = <4>;
> +		compatible = "microchip,wilc3000", "microchip,wilc1000";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wilc_default>;
> +		irq-gpios = <&pioA PIN_PB25 GPIO_ACTIVE_LOW>;
> +		clocks = <&pmc PMC_TYPE_SYSTEM 9>;
> +		clock-names = "rtc";
> +		assigned-clocks = <&pmc PMC_TYPE_SYSTEM 9>;
> +		assigned-clock-rates = <32768>;
> +		status = "okay";

Again, that's the default so drop.

Did you run validation (make dtbs_check) on your changes because I see 
multiple problems.

Rob
