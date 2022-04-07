Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4CDC433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  7 Apr 2022 20:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiDGVA0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDGVA0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2022 17:00:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBF515E8B7
        for <linux-mmc@vger.kernel.org>; Thu,  7 Apr 2022 13:58:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so7816733edu.10
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2022 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=LtV+LimrEebMzUK1IOhvEXGb2ymNgMZl7qh+Db0K2zNRN9P2+inYAeLmBHYB2w6OkO
         mn/kik52wDH8tc8FUpvnPbCEntUH62DwQiMG6ydiIqlYKJmkEYvdOUC8WI9fYcl0ysB1
         H6FwSKAovj274rvZkqlyUAzRkERYk49kh8aZUoMkYXZSgZxVakbuGIBuJ5MwSay6PeWy
         mzuQZ7aln0oPp2FhclYJyvKN5snzc2HBQQSTWgLAs7rRk1QNqx4VpUvRU2ENIa5w2Yxt
         4cczopCH7g7pzQE8kYQ/fYdIrqeKWaHCjByr9giggQf34469Y2UAfBvapmZcmSD+hqiH
         /fjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gOv/51dHbvSvAxLzxG0YE6pJrgjLizkZFj88kA5U1Ts=;
        b=PMgBvTSU6/5KK6LFSskS/7USSUkK4lTkNzSjdGO0v77BgcksJ86m4BNb5NGgYqj3J5
         eDAY3RZdKP5zf/0w7USS0u7cs4p1Ke3BHfeUBhboDM/ZUIRn+uBMKNq98+ale/7sq7R5
         MRpR5E8j1LSGE+TmdQBgU8FYLpPLIC7kwkvLcudMHvK6cBROy+q8Zbip7yLweoZkXL0f
         uv7FMzgoWeu7YiEwqQpE6NiJbquYM/ABMy9e43EqjCkrcpONqRFRoBg+rZgve+H9Qq5J
         7ATLgAOyge98do9qoOESzTTJBPxQjLAuNkuDivoBo91lMJHi+mE7rkM/qJJT5d4jZhYx
         yEqw==
X-Gm-Message-State: AOAM531LXSjwhI3UXLOhBc1ekP5cEM8U5lOzqgJWMfntgCm9nkvCYrnf
        qLZd/OYpyd5E0FxsiER13hbuuA==
X-Google-Smtp-Source: ABdhPJzKZKgo7bJk0AYUXlwb2y8mbmmQYcn7Gd1R46cDu+04zIt7arhMKkYnlMab8y4eU6cP1/Q3hg==
X-Received: by 2002:a05:6402:3604:b0:41c:c4e6:2988 with SMTP id el4-20020a056402360400b0041cc4e62988mr16115607edb.157.1649365097189;
        Thu, 07 Apr 2022 13:58:17 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b006e83fb1e6b1sm738450ejb.100.2022.04.07.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:58:16 -0700 (PDT)
Message-ID: <827e5f9c-13ef-08fb-d167-80c6c4ea5631@linaro.org>
Date:   Thu, 7 Apr 2022 22:58:15 +0200
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
