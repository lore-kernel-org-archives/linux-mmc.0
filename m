Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27EAC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347094AbiDGTI0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiDGTIZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 15:08:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98811B9328
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 12:06:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so7539108edw.6
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=O9N5piyZ8ghdKuId5L9aiMvkNuf62owbuCE+bZDTC6+xdnskK2aUwjkRUGOHdchCvA
         /J+QuQpbFJM/EfFm8RsWGeBGnPnBdya6DSH3nBGlfOGxOQfphaxLgDC+zzgMMt+VmjXu
         OSMZhW68bPY1HCTsk1/kZgPdo6KTzbrFSetJ89hvIb1T7A9C/NsRlGJk36F6rGcSxWLF
         js+BATsURtMBOD9XP5WBgZ8B9ahlWlXnGEpQSISIIdLvqgDDKE4wkVtb80Yln+Nyneo5
         sOOhyqrnY0o9IB8O7pFrrQJI/FsA2bBNe7fN2rsX34K5jkhc7gGS5VTCFiWFKPd1F1JU
         lubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=vBoxePkYS5vX0GLZ8Lg7vBywSM3PLk+RB8lTLfv8zHVI1Ix10vcxE+UKrL0MB5wYZA
         MTi0ZXHo2nnJ0Q7HtC2y71d1w3X6kkj8r4lLgnzBDLOfr32uOjc6hi9KXYMiK/BqUHV0
         ClDyW8E4ili9SJz4Qq25kg01ZDOwZ6NJ/aI2la+97Fz+wW+XUw7DGQd72kL5ifvoXYgK
         hD6m9K0/XaGy2LSvEEYc3r4EPaOlUu1MvCIFOoACeh1qC1DZE+9TLVsp5oZB0aptLVTo
         0ab1uAldz0LZe+L4Az9eXvXTTNubdHY8CNzmKJxNajWEsI9nAXM5gWVXRldTkTMDGvwY
         1UpA==
X-Gm-Message-State: AOAM533uzd96EjLdp4TDG1oZl2yj00+pcyp5lnIOX+pQWY4+ZuiMFPpJ
        o6vN4cihW8eZAQv8RwQaW4rjNQ==
X-Google-Smtp-Source: ABdhPJyhh/Yt+dDqYCjKan4H/N0nxJOJereGCAdjBh0lD6wnLfFa+OHp2IVxiD8+UeuiyRjWGDtvFA==
X-Received: by 2002:a50:e79b:0:b0:41c:dd2c:3e19 with SMTP id b27-20020a50e79b000000b0041cdd2c3e19mr15774315edn.291.1649358382461;
        Thu, 07 Apr 2022 12:06:22 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id q15-20020a1709060e4f00b006cdf4535cf2sm7890988eji.67.2022.04.07.12.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 12:06:21 -0700 (PDT)
Message-ID: <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
Date:   Thu, 7 Apr 2022 21:06:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        dac2@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220406233648.21644-12-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/04/2022 01:36, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Changed to dual copyright (GPL-2.0+ OR MIT)
> - Minor changes from review input

Thank you for your patch. There is something to discuss/improve.

(...)

> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +	rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	num-cs = <4>;
> +	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> +		   <&porta 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +	spi0_cs0@0 {

Generic node name needed matching the class of a devicxe.

> +		compatible = "semtech,sx1301";	/* Enable spidev */

This comment is a bit odd... did you just use random compatible from
spidev instead of defining proper compatible?


> +		#address-cells = <1>;
> +		#size-cells = <1>;

Why address/size cells?

> +		spi-max-frequency = <12000000>;
> +		reg = <0>;

Please put reg just after compatible. It's the most common pattern.

> +	};
> +
> +	spi0_cs1@1 {
> +		compatible = "semtech,sx1301";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <1>;
> +	};
> +

(...)

> +
> +		emmc: mmc@30440000 {
> +			compatible = "pensando,elba-sd4hc", "cdns,sd4hc";
> +			clocks = <&emmc_clk>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x30440000 0x0 0x10000>,
> +			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
> +			cdns,phy-input-delay-sd-highspeed = <0x4>;
> +			cdns,phy-input-delay-legacy = <0x4>;
> +			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> +			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> +			mmc-ddr-1_8v;
> +			status = "disabled";
> +		};
> +
> +		mssoc: mssoc@307c0000 {

Generic node name.

> +			compatible = "syscon", "simple-mfd";

This does not look correct. Syscon is okay, but why do you need
simple-mfd (there are no children here)?

> +			reg = <0x0 0x307c0000 0x0 0x3000>;
> +		};
> +	};
> +};


Best regards,
Krzysztof
