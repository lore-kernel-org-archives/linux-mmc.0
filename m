Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB3C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Mar 2022 07:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiC1HWd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Mar 2022 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiC1HWd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2022 03:22:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA831706A
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2022 00:20:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nYjgH-0005fL-Dg; Mon, 28 Mar 2022 09:20:49 +0200
Message-ID: <c964bf2c-f7bf-451c-1691-02903f20c634@pengutronix.de>
Date:   Mon, 28 Mar 2022 09:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 3/5] arm64: dts: imx8mp: Enable HS400-ES
To:     Adam Ford <aford173@gmail.com>, linux-mmc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        aford@beaconembedded.com, haibo.chen@nxp.com,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220327123835.28329-1-aford173@gmail.com>
 <20220327123835.28329-3-aford173@gmail.com>
Content-Language: en-US
In-Reply-To: <20220327123835.28329-3-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Adam,

On 27.03.22 14:38, Adam Ford wrote:
> The SDHC controller in the imx8mp has the same controller
> as the imx8mm which supports HS400-ES. Change the compatible
> fallback to imx8mm to enable it.

I believe that's a shortcoming of the Linux driver, which should explicitly list
fsl,imx8mp-usdhc in its compatibles and enable HS400-ES for it.

I find dropping compatibles problematic, because like Linux matching
fsl,imx8mm-usdhc, but not fsl,imx8mp-usdhc, other software may match
fsl,imx7d-usdhc, but not fsl,imx8[mp]-usdhc.

I'd prefer that either the kernel driver gains extra compatibles or that
the DTS lists extra compatibles and we refrain from dropping existing
(correct) ones.

What do you think?

Cheers,
Ahmad

> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 794d75173cf5..d5ee1520f1fe 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -769,7 +769,7 @@ i2c6: i2c@30ae0000 {
>  			};
>  
>  			usdhc1: mmc@30b40000 {
> -				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> +				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>  				reg = <0x30b40000 0x10000>;
>  				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MP_CLK_DUMMY>,
> @@ -783,7 +783,7 @@ usdhc1: mmc@30b40000 {
>  			};
>  
>  			usdhc2: mmc@30b50000 {
> -				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> +				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>  				reg = <0x30b50000 0x10000>;
>  				interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MP_CLK_DUMMY>,
> @@ -797,7 +797,7 @@ usdhc2: mmc@30b50000 {
>  			};
>  
>  			usdhc3: mmc@30b60000 {
> -				compatible = "fsl,imx8mp-usdhc", "fsl,imx7d-usdhc";
> +				compatible = "fsl,imx8mp-usdhc", "fsl,imx8mm-usdhc";
>  				reg = <0x30b60000 0x10000>;
>  				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MP_CLK_DUMMY>,


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
