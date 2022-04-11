Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC1C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 07:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbiDKHfL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbiDKHfK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 03:35:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D63D4B1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:32:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so2164203pjb.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Apr 2022 00:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Bcipwo2t195QVJFmmzu71Z0FtdQvx0x9uvTartKReE=;
        b=xz0kRGucxrAsw2ENDOBT3/CQ9WGjLIBdTL9q2ce5qSASw2pV2bZWB6F+yDGWkvLf1D
         YxnUb9YnUe3wn7BgQ0ZOs6vfP+ItQdzWbEoFt2nTmyjOi2f5EZx9rJGN94j/ZDnW7zVd
         9pnif/5B0u6JiEal2wcP7UwObcgwinWIvVCjS9xDCU0TV3lbs4LLNddQQPgUsQ4DzFfP
         pXpo0E+nIsC1ZyDewoFR8lVwiGCmGW2zOLmOlaoBMv9TUMGGNHOSBr05gOSU3EeECvDB
         MhJhcKTUGBmoQ0gCOWPkr7M4ZJsmq22zEZ+6KKcDnYoASH4qjp2Te1RbUmyPjBq4PcF5
         Rx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Bcipwo2t195QVJFmmzu71Z0FtdQvx0x9uvTartKReE=;
        b=DTgtjQcC8rH2zBJKq6WvfmbhtrPI9VRaPbLmwNJZJXZAWZgChF83Ajndf3zJ7oKb4n
         0pHgSjRkFzDdxF9sqA09nfUBewgB+P/hky6rt6y3c3AFJMvnMpSnccRt2tiZHgDzI7Fd
         bcM/Xm17wip+wpH3fwyoOa+e4AVFrE/3xxEwcFwIwv7Rg2B0+Qe0bmmSOiwCf8iE79DI
         0pAlBNwa7Xw/9sFhdp7fVynSPWtoz6Voht619655Jxgp20tVDSp1fnJ3KeKLRWUQ3Y40
         2M9V7jMeo35VZn+sGBPYAg3ztz290+n+vB0zcfJ3AU1IclGZ3hbrqzEwCPlmIWgjaH6Q
         LxBQ==
X-Gm-Message-State: AOAM531rf9lU5yYI4xRQaiwwRzFxka+5RGq+9m68kOM5Q++3uBfCT+2e
        EnfMN01g33ob9hmYo6W9Nzlb
X-Google-Smtp-Source: ABdhPJymDSL0wYm7Gy/Y8s9Ov9nZtnJdrl315iiyAsoeZ3s3YHNZuGUWiSY5ZkcV20aurQGIxbOq8A==
X-Received: by 2002:a17:90b:4b0e:b0:1c6:f499:1cc9 with SMTP id lx14-20020a17090b4b0e00b001c6f4991cc9mr35475405pjb.133.1649662376064;
        Mon, 11 Apr 2022 00:32:56 -0700 (PDT)
Received: from thinkpad ([117.217.182.106])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b005058a09f3aesm10186371pfu.147.2022.04.11.00.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 00:32:55 -0700 (PDT)
Date:   Mon, 11 Apr 2022 13:02:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, ulf.hansson@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 5/7] ARM: dts: qcom: sdx65: Enable ARM SMMU
Message-ID: <20220411073246.GD24975@thinkpad>
References: <1649660143-22400-1-git-send-email-quic_rohiagar@quicinc.com>
 <1649660143-22400-6-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649660143-22400-6-git-send-email-quic_rohiagar@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 12:25:41PM +0530, Rohit Agarwal wrote:
> Add a node for the ARM SMMU found in the SDX65.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 40 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 632ac78..2481769 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -181,6 +181,46 @@
>  			status = "disabled";
>  		};
>  
> +		apps_smmu: iommu@15000000 {

Please sort the nodes in ascending order.

Thanks,
Mani

> +			compatible = "qcom,sdx65-smmu-500", "arm,mmu-500";
> +			reg = <0x15000000 0x40000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <1>;
> +			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		pdc: interrupt-controller@b210000 {
>  			compatible = "qcom,sdx65-pdc", "qcom,pdc";
>  			reg = <0xb210000 0x10000>;
> -- 
> 2.7.4
> 
