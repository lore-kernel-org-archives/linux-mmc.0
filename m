Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C0C64E7B
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Nov 2020 22:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C88122470
	for <linux-mmc@archiver.kernel.org>; Sat, 28 Nov 2020 22:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSMvJBUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgK1Vun (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgK1TCf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Nov 2020 14:02:35 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD4C094273
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2020 23:33:40 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s63so6033599pgc.8
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2020 23:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ihnYKrMMjwZQ5ASx933HV2MFt/S1a3530wjA+saFMm0=;
        b=OSMvJBUy3HqGbGUcMWKHNiGOHQCRFhjr9OZqhIL9Q+v1V34yiTWKsqln8Pasel3c/d
         Q9sTQaRWEmzF6YrupGPB4OG1K5jrJRppLT6Qqtk+O4reM2QBiO6BZL7aCsJy9D5zUfHc
         2FTA67D0bnp6TOzBuMzfy0XdYn3bdl/wpMuw/9Me/Hlg7iSZd/uVXt8hK/sjZucF5NXg
         FVwQlgghzrSRKe+np5c46nW7xdWDz1pWpV5PA0V+isL7Sq7iOlBLL0fzkJxRnSv6dqT/
         nd/r3rcmoHaWoz2PTu75OcW7xcxXeMgyogFasR0G3PdBVU3AoHJzINAMCYpGxBLyA2vU
         +stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ihnYKrMMjwZQ5ASx933HV2MFt/S1a3530wjA+saFMm0=;
        b=hGNN9yyg8mwtxT6qjJLCrNS20fVG5T3tsphfq3EsDERdot5m+nTVgGOKIqv2pxTzfl
         xlvXw+4ntPyif2+lTUMETZdxXPfnQtI1EkgknNyUcTGYt+ysUdx0hs+gK73m4ecMJROy
         lMjnVYlQLARN6Zvy7Tvi2Yu7RrC/Km62FLoMlRJmtnaxc+FcCb5eRNaoKkCFOyBmCjmY
         RA2T6uT+3kSCreQuwWVYYUtzMnXssEAo5TEwsTEnJxcvrwnFUJa0s/1NkTY9HWHJO0ZN
         uyJMaKtMipX028eI9jCe2jhXFDNzWDQI1P5OcOSF7VpzRFZNXGjYkWbwLCbaEgqjHRPp
         Nn6A==
X-Gm-Message-State: AOAM530TVEev5ZhawW18m9qPAonACi9ySX36HH7Yr68LV2sVbvyWFAOv
        WeITJ0/qv25dgWXlWf++ARvZ
X-Google-Smtp-Source: ABdhPJwbCDP8/+7G0x1dmJbEc8cAeBrMhbVdDjg8CH1Fq8Dda8QmWvqbYV1Epr/Z0CyuZA4fKt5ChA==
X-Received: by 2002:a17:90a:ec08:: with SMTP id l8mr14275331pjy.115.1606548820114;
        Fri, 27 Nov 2020 23:33:40 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id f5sm9194473pgg.74.2020.11.27.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:33:39 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:03:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 09/18] arm: dts: owl-s500: Add MMC support
Message-ID: <20201128073331.GX3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0556399f1ce8b1255d1f7961f04fcb95c96ab928.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:03AM +0200, Cristian Ciocaltea wrote:
> Add MMC controller nodes for Actions Semi S500 SoC, in order to
> facilitate access to SD/EMMC/SDIO cards.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> index b16172615db0..7af7c9e1119d 100644
> --- a/arch/arm/boot/dts/owl-s500.dtsi
> +++ b/arch/arm/boot/dts/owl-s500.dtsi
> @@ -241,5 +241,38 @@ dma: dma-controller@b0260000 {
>  			clocks = <&cmu CLK_DMAC>;
>  			power-domains = <&sps S500_PD_DMA>;
>  		};
> +
> +		mmc0: mmc@b0230000 {
> +			compatible = "actions,s500-mmc", "actions,owl-mmc";
> +			reg = <0xb0230000 0x38>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD0>;
> +			resets = <&cmu RESET_SD0>;
> +			dmas = <&dma 2>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@b0234000 {
> +			compatible = "actions,s500-mmc", "actions,owl-mmc";
> +			reg = <0xb0234000 0x38>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD1>;
> +			resets = <&cmu RESET_SD1>;
> +			dmas = <&dma 3>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@b0238000 {
> +			compatible = "actions,s500-mmc", "actions,owl-mmc";
> +			reg = <0xb0238000 0x38>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cmu CLK_SD2>;
> +			resets = <&cmu RESET_SD2>;
> +			dmas = <&dma 4>;
> +			dma-names = "mmc";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.29.2
> 
