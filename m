Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650FC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jun 2022 22:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiFNWo0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jun 2022 18:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiFNWoZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2022 18:44:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3C50E10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2022 15:44:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id y196so9826017pfb.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jun 2022 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tEKPEohOKii6C8FoFw3OQBM5b+J4Se99Td+zgDjIemk=;
        b=ZTuKG2Fcgea7PbObrnWQU9iarLLlAl0A3+317ktLgMDaPR83JypuyFNwk5IEhWeF5z
         aUbwZKdEEhBtB/+uY9xN1DmpESlWOKMXVSi6GXFb0QE24SH+uGoGCTLELNITuEURJ+Je
         GYUglFfOuvGTeVuO12m05G195vaE9hRJdxedwMVzmySSryorit3Re0wFMKzdyV08DHGC
         n+LfhDjZatZjN10J7znq6vtnMUsrTyfRYPFZnXAKN+5FZ397/PAPu5MPSCaJ4zmtfpXg
         WLEDiEpiSAKgZJxjDOig8wqWmgw3QL4wbxJ17NWXeuNKDT/GDMD9FLXYlx0rz/MnAOO9
         PU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tEKPEohOKii6C8FoFw3OQBM5b+J4Se99Td+zgDjIemk=;
        b=Q65AuRLhvipMA7beS8kg3Vp6heR3n6F+YApk4UR/PQMQp68CSSnnKR/DG0UTJi9m6G
         qigEQBXoSheDgnkuMynq/eYLrLML9GVnGGZbBzifOPndPOu0n/UdcZ9H0k/Xgzifdoda
         J7vZeuHTM02jp2rcava9Yl1N8xN+bE0h9uli6xreQDx9On7IbUz6q9YysOzLC79bwdki
         9cCaf7nbANgFFO2HXr+w5A/aU5OL2aD4GMzQITPyTFRG53D1YUEtDg/iLPBWXaYMgNLp
         QijUkHrnXM6XrGxOa6VMDXG7mASUKWCFcSXATegdHiFfKe/Vl/fqzM4BuBlw1d0D1bOM
         sikQ==
X-Gm-Message-State: AOAM532yvjSzR8TCQdOFvab/xHBoKHcfnJmSYFew+D8/SzwzvHJ9QpTt
        jgEhy78+XWvwbNU8Wjy1MF0Dng==
X-Google-Smtp-Source: ABdhPJxXRVyhCovuWMWCtUI4jcVJQFhXzB9PpxsEI2Vao7fIUhQ51iYgdX/g9ne2SL7h97qTH3E1Jw==
X-Received: by 2002:a63:90c8:0:b0:3fd:157f:3f6f with SMTP id a191-20020a6390c8000000b003fd157f3f6fmr6365006pge.316.1655246663184;
        Tue, 14 Jun 2022 15:44:23 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id bg11-20020a1709028e8b00b0016782c55790sm7734784plb.232.2022.06.14.15.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:44:22 -0700 (PDT)
Message-ID: <c9d90fdf-41fa-a363-fdc0-097c3d0dd547@linaro.org>
Date:   Tue, 14 Jun 2022 15:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 10/15] arm64: dts: Add AMD Pensando Elba SoC support
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
References: <20220613195658.5607-1-brad@pensando.io>
 <20220613195658.5607-11-brad@pensando.io>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613195658.5607-11-brad@pensando.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13/06/2022 12:56, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> Add AMD Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <blarson@amd.com>

Thank you for your patch. There is something to discuss/improve.

> ---
>  arch/arm64/boot/dts/amd/Makefile              |   1 +
>  arch/arm64/boot/dts/amd/elba-16core.dtsi      | 189 +++++++++++++++++
>  arch/arm64/boot/dts/amd/elba-asic-common.dtsi | 103 ++++++++++
>  arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
>  arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 106 ++++++++++
>  arch/arm64/boot/dts/amd/elba.dtsi             | 191 ++++++++++++++++++
>  6 files changed, 618 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
> 
> diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
> index 68103a8b0ef5..9bba020fa880 100644
> --- a/arch/arm64/boot/dts/amd/Makefile
> +++ b/arch/arm64/boot/dts/amd/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
> +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb

Put it in alphabetical order, so not at the end of file.

(...)

> +
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
> +	spi@0 {

Rob's  comment about bindings applies here as well, so please fix both.
This has to be sorted out - either it is SPI controller or MFD.

Rest looks okay for me.

> +		compatible = "amd,pensando-elbasr", "simple-mfd";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		spi-max-frequency = <12000000>;
> +


Best regards,
Krzysztof
