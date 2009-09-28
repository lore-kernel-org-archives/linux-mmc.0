From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] sdio: add MMC_CAP_VDD_165_195 host capability
Date: Mon, 28 Sep 2009 19:10:48 +0100
Message-ID: <20090928181046.GA4791@console-pimps.org>
References: <1254160714.31101.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:47748 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbZI1SLb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 14:11:31 -0400
Content-Disposition: inline
In-Reply-To: <1254160714.31101.3.camel@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@bencohen.org>
Cc: akpm@linux-foundation.org, philipl@overt.org, ian@mnementh.co.uk, pierre@ossman.eu, roberto.foglietta@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org

On Mon, Sep 28, 2009 at 07:58:34PM +0200, Ohad Ben-Cohen wrote:
> [I should really ditch my mailer, I know. hope it's the last attempt. Sorry x 2]
> ---
> From: Ohad Ben-Cohen <ohad@wizery.com>
> 
> To allow the usage of MMC_VDD_165_195, host capability
> MMC_CAP_VDD_165_195 is introduced. This is necessary
> because MMC_VDD_165_195 is currently reserved/undefined.
> 

Have you got patches that add this capability to the TI 127x and ZOOM2
board setup files?

> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/mmc/core/sdio.c  |    7 +++++++
>  include/linux/mmc/host.h |    1 +
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index cdb845b..a9f3ed6 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -494,6 +494,13 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
>  		ocr &= ~0x7F;
>  	}
>  
> +	if ((ocr & MMC_VDD_165_195) && !(host->caps & MMC_CAP_VDD_165_195)) {
> +		printk(KERN_WARNING "%s: SDIO card claims to support the "
> +			"incompletely defined 'low voltage range'. This "
> +			"will be ignored.\n", mmc_hostname(host));
> +		ocr &= ~MMC_VDD_165_195;
> +	}
> +
>  	host->ocr = mmc_select_voltage(host, ocr);
>  
>  	/*


I know you copied this warning from the old code but does anyone think
it's worth making this warning a bit clearer? e.g,

> +		printk(KERN_WARNING "%s: SDIO card claims to support the "
> +			"incompletely defined 'low voltage range', but the "
> +			"host controller does not. This voltage range"
> +			"will be ignored.\n", mmc_hostname(host));
