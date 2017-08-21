From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH] mmc: cavium-octeon: Convert to use module_platform_driver
Date: Mon, 21 Aug 2017 12:36:51 +0200
Message-ID: <20170821103651.GA12259@hc>
References: <20170819130611.3335-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:18720
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751894AbdHUKhG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 21 Aug 2017 06:37:06 -0400
Content-Disposition: inline
In-Reply-To: <20170819130611.3335-1-axel.lin@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org

On Sat, Aug 19, 2017 at 09:06:11PM +0800, Axel Lin wrote:
> Get rid of boilerplate code by using module_platform_driver macro.

Looks good. If you want to add:
Acked-by: Jan Glauber <jglauber@cavium.com>

thanks, Jan

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/mmc/host/cavium-octeon.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 951d2cd..22aded1 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -342,18 +342,7 @@ static struct platform_driver octeon_mmc_driver = {
>  	},
>  };
>  
> -static int __init octeon_mmc_init(void)
> -{
> -	return platform_driver_register(&octeon_mmc_driver);
> -}
> -
> -static void __exit octeon_mmc_cleanup(void)
> -{
> -	platform_driver_unregister(&octeon_mmc_driver);
> -}
> -
> -module_init(octeon_mmc_init);
> -module_exit(octeon_mmc_cleanup);
> +module_platform_driver(octeon_mmc_driver);
>  
>  MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
>  MODULE_DESCRIPTION("Low-level driver for Cavium OCTEON MMC/SSD card");
> -- 
> 2.9.3
