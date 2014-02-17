From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH 3/3] dts: socfpga: Add support for SD/MMC on the SOCFPGA
 platform
Date: Mon, 17 Feb 2014 09:18:29 +0100
Message-ID: <20140217081829.GC6972@pengutronix.de>
References: <1392622244-18015-1-git-send-email-dinguyen@altera.com>
 <1392622244-18015-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaBQISa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 03:18:30 -0500
Content-Disposition: inline
In-Reply-To: <1392622244-18015-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, dinh.linux@gmail.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

On Mon, Feb 17, 2014 at 01:30:44AM -0600, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Introduce "altr,socfpga-dw-mshc" to enable Altera's SOCFPGA platform specific
> implementation of the dwc_mmc driver.
> 
> Also add the "syscon" binding to the "altr,sys-mgr" node. The clock
> driver can use the syscon driver to toggle the register for the SD/MMC
> clock phase shift settings.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <chris@printf.net>
> ---
>  .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   23 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   13 ++++++++++-
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++++++++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++++++++++
>  5 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> new file mode 100644
> index 0000000..4897bea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> @@ -0,0 +1,23 @@
> +* Altera SOCFPGA specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsys-dw-mshc.txt and the properties used by the Altera SOCFPGA specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "altr,socfpga-dw-mshc": for Altera's SOCFPGA platform
> +
> +Example:
> +
> +	mmc: dwmmc0@ff704000 {
> +		compatible = "altr,socfpga-dw-mshc";
> +		reg = <0xff704000 0x1000>;
> +		interrupts = <0 129 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 3d62f47..967e27f 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -474,6 +474,17 @@
>  			arm,data-latency = <2 1 1>;
>  		};
>  
> +		mmc: dwmmc0@ff704000 {
> +			compatible = "altr,socfpga-dw-mshc";
> +			reg = <0xff704000 0x1000>;
> +			interrupts = <0 139 4>;
> +			fifo-depth = <0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
> +			clock-names = "biu", "ciu";
> +		};
> +
>  		/* Local timer */
>  		timer@fffec600 {
>  			compatible = "arm,cortex-a9-twd-timer";
> @@ -528,7 +539,7 @@
>  		};
>  
>  		sysmgr@ffd08000 {
> -				compatible = "altr,sys-mgr";
> +				compatible = "altr,sys-mgr", "syscon";
>  				reg = <0xffd08000 0x4000>;
>  			};
>  	};

Could you also fix the indentation here, while your touching the node?
This one seems to be the only one left, that uses weird indentation.

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
