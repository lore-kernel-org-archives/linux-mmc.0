From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in idle mode.
Date: Fri, 08 Feb 2013 13:05:20 +0000
Message-ID: <20130208130520.4B1203E2B73@localhost>
References: <20121220220444.GA350@blumentopf> <1356041532-919-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:43283 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946449Ab3BHNFY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Feb 2013 08:05:24 -0500
Received: by mail-wg0-f51.google.com with SMTP id 8so2866461wgl.18
        for <linux-mmc@vger.kernel.org>; Fri, 08 Feb 2013 05:05:23 -0800 (PST)
In-Reply-To: <1356041532-919-1-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, santosh.shilimkar@ti.com, cjb@laptop.org

On Thu, 20 Dec 2012 23:12:12 +0100, Andreas Fenkart <andreas.fenkart@streamunlimited.com> wrote:
> Without functional clock the omap_hsmmc module can't forward
> SDIO IRQs to the system. This patch reconfigures dat1 line
> as a gpio while the fclk is off. And uses SDIO IRQ detection of
> the module, while fclk is present.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   42 ++++
>  arch/arm/plat-omap/include/plat/mmc.h              |    4 +
>  drivers/mmc/host/omap_hsmmc.c                      |  219 ++++++++++++++++++--
>  3 files changed, 247 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index d1b8932..4d57637 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -24,6 +24,29 @@ One tx and one rx pair is required.
>  dma-names: DMA request names. These strings correspond 1:1 with
>  the ordered pairs in dmas. The RX request must be "rx" and the
>  TX request must be "tx".
> +ti,cirq-gpio: When omap_hsmmc module is suspended, its functional
> +clock is turned off. Without fclk it can't forward SDIO IRQs to the
> +system. For that to happen, it needs to tell the PRCM to restore
> +its fclk, which is done through the swakeup line.
> +
> +                   ------
> +                  | PRCM |
> +                   ------
> +                    | ^
> +               fclk | | swakeup
> +                    v |
> +                  -------               ------
> +      <-- IRQ -- | hsmmc | <-- CIRQ -- | card |
> +                  -------               ------
> +
> +The problem is, that on the AM335x family the swakeup line is
> +missing, it has not been routed from the module to the PRCM.
> +The way to work around this, is to reconfigure the dat1 line as a
> +GPIO upon suspend. Beyond this option you also need to set named
> +states "default" and "idle "in the .dts file for the pins, using
> +pinctrl-single.c. The MMC driver will then then toggle between
> +default and idle during the runtime.
> +
>  
>  Examples:
>  
> @@ -53,3 +76,22 @@ Examples:
>  			&edma 25>;
>  		dma-names = "tx", "rx";
>  	};
> +
> +[am335x with with gpio for sdio irq]
> +
> +	mmc1_cirq_pin: pinmux_cirq_pin {
> +		pinctrl-single,pins = <
> +			0x0f8 0x3f	/* MMC0_DAT1 as GPIO2_28 */
> +		>;
> +	};
> +
> +	mmc1: mmc@48060000 {
> +		pinctrl-names = "default", "idle";
> +		pinctrl-0 = <&mmc1_pins>;
> +		pinctrl-1 = <&mmc1_cirq_pin>;
> +		ti,cirq-gpio = <&gpio3 28 0>;
> +		ti,non-removable;
> +		bus-width = <4>;
> +		vmmc-supply = <&ldo2_reg>;
> +		vmmc_aux-supply = <&vmmc>;
> +	};

Binding looks reasonable.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

