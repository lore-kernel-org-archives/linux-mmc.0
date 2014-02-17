From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCHv2 2/3] mmc: dw_mmc: Add support for SOCFPGA's platform
 specific implementation
Date: Mon, 17 Feb 2014 21:20:18 +0100
Message-ID: <20140217202018.GC8839@pengutronix.de>
References: <1392666911-15985-1-git-send-email-dinguyen@altera.com>
 <1392666911-15985-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40585 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbaBQUUY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 15:20:24 -0500
Content-Disposition: inline
In-Reply-To: <1392666911-15985-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, dinh.linux@gmail.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

Hi Dinh!

On Mon, Feb 17, 2014 at 01:55:10PM -0600, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Like the rockchip, Altera's SOCFPGA platform specific implementation of the
> dw_mmc driver requires using the HOLD register for SD commands.
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
> v2: Use dw_mci_socfpga_prepare_command instead of
>     dw_mci_rockchip_prepare_command
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 5c49656..5b87cc2 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -30,10 +30,19 @@ static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
>  	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
>  }
>  
> +static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
> +{
> +	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +}
> +
>  static const struct dw_mci_drv_data rockchip_drv_data = {
>  	.prepare_command	= dw_mci_rockchip_prepare_command,
>  };
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +	.prepare_command	= dw_mci_socfpga_prepare_command,
> +};
> +

Why didn't you just rename the rockchip function, instead of
adding the same thing with a different name?
This seems rather "useless" or I'm missing something.

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
