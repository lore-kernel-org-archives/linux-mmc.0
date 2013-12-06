From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc driver structure
Date: Sat, 7 Dec 2013 00:14:53 +0100
Message-ID: <201312070014.53895.heiko@sntech.de>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com> <1386346223-18464-3-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:41504 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161851Ab3LFXPF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Dec 2013 18:15:05 -0500
In-Reply-To: <1386346223-18464-3-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

Am Freitag, 6. Dezember 2013, 17:10:23 schrieb dinguyen@altera.com:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Rockchip's implementation of the dw_mmc controller only requires the
> setting of the SDMMC_CMD_USE_HOLD_REG on every command. With the patch to
> set the SDMMC_CMD_USE_HOLD_REG by checking the slot's speed mode, this
> Rockchip custom driver structure is no longer necessary.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

hmm, testing will need a bit more time, as it seems one of the changes merged 
during the 3.13 merge window broke the dw-mmc on the rockchip.

So I'll need to bisect this first.


Heiko

> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
> b/drivers/mmc/host/dw_mmc-pltfm.c index 5c49656..8f15d05 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -25,15 +25,6 @@
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> 
> -static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u32
> *cmdr) -{
> -	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
> -}
> -
> -static const struct dw_mci_drv_data rockchip_drv_data = {
> -	.prepare_command	= dw_mci_rockchip_prepare_command,
> -};
> -
>  int dw_mci_pltfm_register(struct platform_device *pdev,
>  			  const struct dw_mci_drv_data *drv_data)
>  {
> @@ -90,8 +81,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> 
>  static const struct of_device_id dw_mci_pltfm_match[] = {
>  	{ .compatible = "snps,dw-mshc", },
> -	{ .compatible = "rockchip,rk2928-dw-mshc",
> -		.data = &rockchip_drv_data },
> +	{ .compatible = "rockchip,rk2928-dw-mshc", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);

