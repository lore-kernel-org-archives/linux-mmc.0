From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Add support for SOCFPGA's platform
 specific implementation
Date: Mon, 17 Feb 2014 09:15:32 +0100
Message-ID: <20140217081532.GB6972@pengutronix.de>
References: <1392622244-18015-1-git-send-email-dinguyen@altera.com>
 <1392622244-18015-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47042 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaBQIPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 03:15:38 -0500
Content-Disposition: inline
In-Reply-To: <1392622244-18015-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: linux-mmc@vger.kernel.org, dinh.linux@gmail.com, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>

Hi!

On Mon, Feb 17, 2014 at 01:30:43AM -0600, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Like the rockchip, Altera's SOCFPGA platform specific implementation of the
> dw_mmc driver requires using the HOLD register for SD commands.
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
>  drivers/mmc/host/dw_mmc-pltfm.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 5c49656..88047cc 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -34,6 +34,10 @@ static const struct dw_mci_drv_data rockchip_drv_data = {
>  	.prepare_command	= dw_mci_rockchip_prepare_command,
>  };
>  
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +	.prepare_command	= dw_mci_rockchip_prepare_command,
> +};
> +
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  			  const struct dw_mci_drv_data *drv_data)
>  {
> @@ -92,6 +96,8 @@ static const struct of_device_id dw_mci_pltfm_match[] = {
>  	{ .compatible = "snps,dw-mshc", },
>  	{ .compatible = "rockchip,rk2928-dw-mshc",
>  		.data = &rockchip_drv_data },
> +	{ .compatible = "altr,socfpga-dw-mshc",
> +		.data = &socfpga_drv_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> -- 

Not really a bad problem, but wouldn't it be better to rename
	dw_mci_rockchip_prepare_command -> dw_mci_hold_reg_prepare_command
then? Has nothing to do with just rockchip anymore.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
