From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] MMC: pxamci: call pdata->setpower even when regulator
 is used
Date: Wed, 2 Dec 2009 01:52:17 +0100
Message-ID: <20091202005217.GT14091@buzzloop.caiaq.de>
References: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:43853 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbZLBAwO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 19:52:14 -0500
Content-Disposition: inline
In-Reply-To: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Pierre Ossman <pierre@ossman.eu>, Eric Miao <eric.y.miao@gmail.com>, linux-mmc@vger.kernel.org

ping.

On Thu, Nov 26, 2009 at 12:10:13PM +0100, Daniel Mack wrote:
> On platforms where the vmmc regulator is used, it might still be
> necessary to call the platform data's setpower() callback in order to
> drive GPIOs to power up hardware.
> 
> I can't see any pxamci user with power regulators enabled, hence this
> shouldn't break anything.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/pxamci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index b00d673..c35df2b 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -84,7 +84,7 @@ static inline void pxamci_init_ocr(struct pxamci_host *host)
>  		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
>  		if (host->pdata && host->pdata->ocr_mask)
>  			dev_warn(mmc_dev(host->mmc),
> -				"ocr_mask/setpower will not be used\n");
> +				"given ocr_mask will not be used\n");
>  	}
>  #endif
>  	if (host->vcc == NULL) {
> @@ -109,7 +109,7 @@ static inline void pxamci_set_power(struct pxamci_host *host, unsigned int vdd)
>  		gpio_set_value(host->pdata->gpio_power,
>  			       !!on ^ host->pdata->gpio_power_invert);
>  	}
> -	if (!host->vcc && host->pdata && host->pdata->setpower)
> +	if (host->pdata && host->pdata->setpower)
>  		host->pdata->setpower(mmc_dev(host->mmc), vdd);
>  }
>  
> -- 
> 1.6.5.2
> 
