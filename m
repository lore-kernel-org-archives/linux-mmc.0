From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Auto CMD12 support
Date: Sun, 6 Feb 2011 04:07:15 +0000
Message-ID: <20110206040714.GA16352@void.printf.net>
References: <20101030035856.GA13041@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52653 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab1BFEHT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 5 Feb 2011 23:07:19 -0500
Content-Disposition: inline
In-Reply-To: <20101030035856.GA13041@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com, Ben Dooks <ben-linux@fluff.org>

Hi Kyungmin,

On Sat, Oct 30, 2010 at 12:58:56PM +0900, Kyungmin Park wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Samsung SDHCI host controller supports the Auto CMD12.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index aacb862..e2d79e7 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -414,6 +414,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	 * SDHCI block, or a missing configuration that needs to be set. */
>  	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
>  
> +	/* This host supports the Auto CMD12 */
> +	host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
> +
>  	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
>  	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>  		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

I've merged this to mmc-next now -- I'm sorry that it took so long. 

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
