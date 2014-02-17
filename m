From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCHv2 3/3] dts: socfpga: Add support for SD/MMC on the
 SOCFPGA platform
Date: Mon, 17 Feb 2014 21:22:07 +0100
Message-ID: <20140217202207.GD8839@pengutronix.de>
References: <1392666911-15985-1-git-send-email-dinguyen@altera.com>
 <1392666911-15985-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40603 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbaBQUWL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 15:22:11 -0500
Content-Disposition: inline
In-Reply-To: <1392666911-15985-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, dinh.linux@gmail.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

Hi!

On Mon, Feb 17, 2014 at 01:55:11PM -0600, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Introduce "altr,socfpga-dw-mshc" to enable Altera's SOCFPGA platform specific
> implementation of the dwc_mmc driver.
> 
> Also add the "syscon" binding to the "altr,sys-mgr" node. The clock
> driver can use the syscon driver to toggle the register for the SD/MMC
> clock phase shift settings.
> 
> Finally, fix an indentation error for the sysmgr node.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Tested-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <chris@printf.net>
> ---
> v2: Fix indentation for the sysmgr node
> ---
>  .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   23 ++++++++++++++++++++
>  arch/arm/boot/dts/socfpga.dtsi                     |   15 +++++++++++--
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++++++++++
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++++++++++
>  arch/arm/boot/dts/socfpga_vt.dts                   |   11 ++++++++++
>  5 files changed, 69 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> @@ -528,8 +539,8 @@
>  		};
>  
>  		sysmgr@ffd08000 {
> -				compatible = "altr,sys-mgr";
> -				reg = <0xffd08000 0x4000>;
> +			compatible = "altr,sys-mgr", "syscon";
> +			reg = <0xffd08000 0x4000>;
>  			};
>  	};
>  };

Thanks for fixing this, but please don't forget the curly and
the semicolon.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
