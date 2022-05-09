Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD9FC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  9 May 2022 09:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiEIJxD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 May 2022 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbiEIJap (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2022 05:30:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3E36E8F7;
        Mon,  9 May 2022 02:26:51 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 010901BF207;
        Mon,  9 May 2022 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652088408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cdjhq5fJB25B8P8JUsIktHRDMTHRFBnJXY7MYLgwfNA=;
        b=Q9KAGW10Fdlstaz3h58sRvOXgIV8Gn0oa5TUa1WGO9UpY0+AfBUcyDK6A1Quijpm771JxL
        JahcqFG05SQs8gdCOU9OMU3cPO3gDV8lNzxkqcJIBYK+Xx5+uJd9vEpHMFz0ytTvY4th0D
        rCcxxs248tJEZfbTjFBf9yuqwzbGuDQiiil34xLflKKmdoa5/KNPoxzSDsRfWX18BzycGS
        jcQXMaLExHxWgJvQTfeh4t+VtG3sc2a3fRdAMXnpcxQyHsYHaQkH6qjnU+fCnSyP076jsZ
        a9c6LUDBpPYq5cKetO+UvwhmwmK9iqvwwnBrfGavnhOARObXknHs6D3Fn+miCg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        huziji@marvell.com, andrew@lunn.ch, sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Update sdhci node names to
 match schema
In-Reply-To: <20220329220544.2132135-2-chris.packham@alliedtelesis.co.nz>
References: <20220329220544.2132135-1-chris.packham@alliedtelesis.co.nz>
 <20220329220544.2132135-2-chris.packham@alliedtelesis.co.nz>
Date:   Mon, 09 May 2022 11:26:35 +0200
Message-ID: <87bkw7rr90.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> Update the node names of the sdhci@ interfaces to be mmc@ to match the
> node name enforced by the mmc-controller.yaml schema.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>
> Notes:
>     This has been sent separately [1] but on Krzysztof's advice I've
>     included it in v3 of this series.
>     
>     [1] -  https://lore.kernel.org/linux-arm-kernel/20220321212007.2961581-1-chris.packham@alliedtelesis.co.nz/
>     Changes in v5:
>     - None
>     Changes in v4:
>     - None
>     Changes in v3:
>     - New
>
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 4 ++--
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 2 +-
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 30233de58bb3..78adb803df26 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -434,7 +434,7 @@ rwtm: mailbox@b0000 {
>  				#mbox-cells = <1>;
>  			};
>  
> -			sdhci1: sdhci@d0000 {
> +			sdhci1: mmc@d0000 {
>  				compatible = "marvell,armada-3700-sdhci",
>  					     "marvell,sdhci-xenon";
>  				reg = <0xd0000 0x300>,
> @@ -445,7 +445,7 @@ sdhci1: sdhci@d0000 {
>  				status = "disabled";
>  			};
>  
> -			sdhci0: sdhci@d8000 {
> +			sdhci0: mmc@d8000 {
>  				compatible = "marvell,armada-3700-sdhci",
>  					     "marvell,sdhci-xenon";
>  				reg = <0xd8000 0x300>,
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 6614472100c2..a06a0a889c43 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -250,7 +250,7 @@ watchdog: watchdog@610000 {
>  				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
> -			ap_sdhci0: sdhci@6e0000 {
> +			ap_sdhci0: mmc@6e0000 {
>  				compatible = "marvell,armada-ap806-sdhci";
>  				reg = <0x6e0000 0x300>;
>  				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 3bd2182817fb..d6c0990a267d 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -493,7 +493,7 @@ CP11X_LABEL(trng): trng@760000 {
>  			status = "okay";
>  		};
>  
> -		CP11X_LABEL(sdhci0): sdhci@780000 {
> +		CP11X_LABEL(sdhci0): mmc@780000 {
>  			compatible = "marvell,armada-cp110-sdhci";
>  			reg = <0x780000 0x300>;
>  			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.35.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
