From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCHv3 2/3] mmc: dw_mmc: Add support for SOCFPGA's platform
 specific implementation
Date: Tue, 18 Feb 2014 23:02:21 +0900
Message-ID: <000001cf2cb2$0b787c00$22697400$%jun@samsung.com>
References: <1392690662-19106-1-git-send-email-dinguyen@altera.com>
 <1392690662-19106-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47036 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbaBROCY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2014 09:02:24 -0500
In-reply-to: <1392690662-19106-2-git-send-email-dinguyen@altera.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, linux-mmc@vger.kernel.org
Cc: dinh.linux@gmail.com, devicetree@vger.kernel.org, 'Rob Herring' <robh+dt@kernel.org>, 'Pawel Moll' <pawel.moll@arm.com>, 'Mark Rutland' <mark.rutland@arm.com>, 'Ian Campbell' <ijc+devicetree@hellion.org.uk>, 'Kumar Gala' <galak@codeaurora.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <chris@printf.net>

On Tue, February 18, 2014, Dinh Nguyen wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Like the rockchip, Altera's SOCFPGA platform specific implementation of the
> dw_mmc driver requires using the HOLD register for SD commands. This patch
> renames dw_mci_rockchip_prepare_command to dw_mci_pltfm_prepare_command so
> that SOCFPGA and Rockchip can use it.
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

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <chris@printf.net>
> ---
> v3: Renamed dw_mci_rockchip_prepare_command to
>     dw_mci_pltfm_prepare_command
> v2: Use dw_mci_socfpga_prepare_command instead of
>     dw_mci_rockchip_prepare_command
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 5c49656..3263327 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -25,13 +25,17 @@
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> 
> -static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32 *cmdr)
> +static void dw_mci_pltfm_prepare_command(struct dw_mci *host, u32 *cmdr)
>  {
>  	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
>  }
> 
>  static const struct dw_mci_drv_data rockchip_drv_data = {
> -	.prepare_command	= dw_mci_rockchip_prepare_command,
> +	.prepare_command	= dw_mci_pltfm_prepare_command,
> +};
> +
> +static const struct dw_mci_drv_data socfpga_drv_data = {
> +	.prepare_command	= dw_mci_pltfm_prepare_command,
>  };
> 
>  int dw_mci_pltfm_register(struct platform_device *pdev,
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
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

