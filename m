Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD07C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Sep 2022 07:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiI3H1a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Sep 2022 03:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiI3H13 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2022 03:27:29 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3716EA93
        for <linux-mmc@vger.kernel.org>; Fri, 30 Sep 2022 00:27:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q17so3883569lji.11
        for <linux-mmc@vger.kernel.org>; Fri, 30 Sep 2022 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6mFuH/JPGOfHHDhdCHqZNj3Q+WzeOj2pe14dcjJDf4U=;
        b=qoBAK7wrMokK38cgSTuYXW8yvcKMxbBct84e6rAxU97//uBUBeYCUS8+ZSeeau76oh
         oFOFtiB2lbqObvTbSFMx1Uub1n4zK/kwt2M3tPFERA7U9iMz/PY7MpMLdse8WLih4nMe
         e99Jll5NH9rdHjgv3E4e5OMT4b4/bRF6ah0vUBgTkTsE61CPaCc5BkRLIf2oKNS27ORZ
         yFC/uWKek1lUlFypeMdPkC1qVh/0N+5FRZcNMAiHJb8PiXI/dx2wkiGlVdKpuPei1EAB
         vhi9DBlb/xZ8W4w40nPUwCQcz58oRHPm+zydREjOpCdeE9jbWLRSccUB8zm9Ims5vMLK
         23zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6mFuH/JPGOfHHDhdCHqZNj3Q+WzeOj2pe14dcjJDf4U=;
        b=z79Dir1D4elXNbdRbRd8jxdWKC6RbKv3Z7HCwo4LlxGqXHeL6IcoRK0Gl0FAXVChvk
         ws2C4Q7qW6cYoTP2wh6HbNTesLm2m4f21iRfolTy5pB97M7x3kwGdPynMid5fSllrawY
         5WIOHWnWmVofzXvtmt8PYaX8bYeqNLBTLDJ/cdGdqfBkWz5IOCwLEpmZTiuzFd3zO1E8
         ow8sbSW4f7OVpeX18qO0SEP33NfXcVYbzdUzw9YHqCNddixpoISI4jyXEdzmC0GI3feO
         /HDHDy4ktZ16JWC5WzwNCJYVR1SB0krL9q9dRhK8hTK2qjTIgzXbfFeTv7Xn47u0tls/
         XDNw==
X-Gm-Message-State: ACrzQf3i7VA6V9B30F0wdNSl+5OHadyDcczCIaHv/LEp3MdTzxNhANeq
        AQbgQWCik7FKkwBfY9Qo3ZIDrg==
X-Google-Smtp-Source: AMsMyM6lgt6/tqKT4Yo3RVH2qmdIKK5UB/8GUN3+5ArNuSYFtJiExmGVtv7Jh5py3hxA0r3GKgTDuQ==
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id h16-20020a05651c159000b0026c43119b84mr478334ljq.152.1664522845051;
        Fri, 30 Sep 2022 00:27:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00494a1e875a9sm204531lfu.191.2022.09.30.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 00:27:24 -0700 (PDT)
Message-ID: <6f9f031b-4d75-de1c-e9de-5aea8d4b8ba1@linaro.org>
Date:   Fri, 30 Sep 2022 09:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v6 10/17] arm64: dts: Add AMD Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-11-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820195750.70861-11-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/08/2022 21:57, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Add AMD Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

(...)

> +
> +&ahb_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&emmc_clk {
> +	clock-frequency = <200000000>;
> +};
> +
> +&flash_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&ref_clk {
> +	clock-frequency = <156250000>;
> +};
> +
> +&qspi {
> +	status = "okay";

Blank line between properties and device nodes.

> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <2>;
> +		m25p,fast-read;
> +		cdns,read-delay = <0>;
> +		cdns,tshsl-ns = <0>;
> +		cdns,tsd2d-ns = <0>;
> +		cdns,tchsh-ns = <0>;
> +		cdns,tslch-ns = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-hw-reset;
> +	reset-names = "hw";
> +	resets = <&rstc 0>;
> +	status = "okay";
> +};
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";

Blank line between properties and device nodes.

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

Blank line between properties and device nodes.

> +	sysc: system-controller@0 {
> +		compatible = "amd,pensando-elbasr";

Best regards,
Krzysztof

