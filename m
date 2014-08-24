From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v14 1/6] mmc: omap_hsmmc: Enable SDIO interrupt
Date: Sun, 24 Aug 2014 11:41:02 -0700
Message-ID: <20140824184102.GF17254@atomide.com>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com>
 <1401352085-22781-2-git-send-email-afenkart@gmail.com>
 <53F9A1B5.2080409@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25843 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbaHXSlQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Aug 2014 14:41:16 -0400
Content-Disposition: inline
In-Reply-To: <53F9A1B5.2080409@epfl.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Andreas Fenkart <afenkart@gmail.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140824 01:29]:
> --- a/arch/arm/boot/dts/omap3-overo-base.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
> @@ -119,7 +119,7 @@
>  			OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_clk.sdmmc2_clk */
>  			OMAP3_CORE1_IOPAD(0x215a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_cmd.sdmmc2_cmd */
>  			OMAP3_CORE1_IOPAD(0x215c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat0.sdmmc2_dat0 */
> -			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
> +			OMAP3_CORE1_IOPAD(0x215e, PIN_INPUT_PULLUP | PIN_OFF_WAKEUPENABLE | MUX_MODE0)		/* sdmmc2_dat1.sdmmc2_dat1 */
>  			OMAP3_CORE1_IOPAD(0x2160, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat2.sdmmc2_dat2 */
>  			OMAP3_CORE1_IOPAD(0x2162, PIN_INPUT_PULLUP | MUX_MODE0)		/* sdmmc2_dat3.sdmmc2_dat3 */
>  		>;

No need to have PIN_OFF_WAKEUPENABLE any longer here, it gets
enabled automatically after you do request_irq on it.

> @@ -195,6 +195,9 @@
>  	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>  	bus-width = <4>;
>  	cap-sdio-irq;
> +	
> +	interrupts-extended = <&intc 86>,
> +			      <&gpio5 5 GPIO_ACTIVE_HIGH>; /* gpio_133 (mmc2.dat1) */
>  	non-removable;
>  };

The second interrupt here just needs to be &omap3_pmx_core
(or &omap3_pmx_core2 depending where it's located) with the
offset to the dat1 pin from it's padconf area. For example,
on mmc3 it should be:

interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;

So you need to look it up from the TRM to figure out the right
offset for mmc2.
  
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index b2891a9..1347bc9 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -417,7 +417,6 @@
>  		mmc2: mmc@480b4000 {
>  			compatible = "ti,omap3-hsmmc";
>  			reg = <0x480b4000 0x200>;
> -			interrupts = <86>;
>  			ti,hwmods = "mmc2";
>  			dmas = <&sdma 47>, <&sdma 48>;
>  			dma-names = "tx", "rx";

I think there's a patch now in mainline tree that by default tries
to use interrupts-extended first, so this may not need to be
changed.

Regards,

Tony
