From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmci: drop superfluous regulator #ifdef
Date: Fri, 10 Dec 2010 03:39:08 +0000
Message-ID: <20101210033908.GA4455@void.printf.net>
References: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54909 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389Ab0LJDjK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Dec 2010 22:39:10 -0500
Content-Disposition: inline
In-Reply-To: <1291297018-3074-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Linus,

On Thu, Dec 02, 2010 at 02:36:58PM +0100, Linus Walleij wrote:
> The regulator and MMC frameworks provide the proper stub functions
> for the regulator functions anyway, get rid of this.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/mmc/host/mmci.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3709ab3..7567872 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -844,7 +844,6 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  		mmc->f_max = min(host->mclk, fmax);
>  	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
>  
> -#ifdef CONFIG_REGULATOR
>  	/* If we're using the regulator framework, try to fetch a regulator */
>  	host->vcc = regulator_get(&dev->dev, "vmmc");
>  	if (IS_ERR(host->vcc))
> @@ -863,7 +862,7 @@ static int __devinit mmci_probe(struct amba_device *dev, struct amba_id *id)
>  				 "(using regulator instead)\n");
>  		}
>  	}
> -#endif
> +
>  	/* Fall back to platform data if no regulator is found */
>  	if (host->vcc == NULL)
>  		mmc->ocr_avail = plat->ocr_mask;

Thanks, pushed to mmc-next for .38.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
