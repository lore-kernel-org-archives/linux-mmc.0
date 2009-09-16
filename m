From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 4/8] s3c6410: sdhci: Enable ADMA feature in 6410 sdhci controller.
Date: Wed, 16 Sep 2009 01:47:38 +0100
Message-ID: <20090916004737.GR13508@trinity.fluff.org>
References: <1252392769-31159-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:42463 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbZIPAre (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 20:47:34 -0400
Content-Disposition: inline
In-Reply-To: <1252392769-31159-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 03:52:49PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch enables ADMA feature in 6410 SDHCI controller
> driver.

Hmm, surely this wouldn't have wrapped and could have goine onto one line?

Also no signoff.

> ---
>  drivers/mmc/host/sdhci-s3c.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index db1bb93..7f5b64e 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -329,12 +329,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	host->irq = irq;
>  
>  	/* Setup quirks for the controller */
> -
> -	/* Currently with ADMA enabled we are getting some length
> -	 * interrupts that are not being dealt with, do disable
> -	 * ADMA until this is sorted out. */
> -	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> -	host->quirks |= SDHCI_QUIRK_32BIT_ADMA_SIZE;
> +	host->quirks |= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC;
>  
>  #ifndef CONFIG_MMC_SDHCI_S3C_DMA
>  
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

