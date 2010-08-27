From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/7] mmc: at91_mci: fix pointer errors
Date: Fri, 27 Aug 2010 20:33:03 +0100
Message-ID: <20100827193303.GB23079@void.printf.net>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49133 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab0H0TdJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Aug 2010 15:33:09 -0400
Content-Disposition: inline
In-Reply-To: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wolfgang.mues@auerswald.de, avictor.za@gmail.com

Hi Andrew, Nicolas,

On Fri, Feb 26, 2010 at 07:39:29PM +0100, Nicolas Ferre wrote:
> From: Wolfgang Muees <wolfgang.mues@auerswald.de>
> 
> Fixes two pointer errors, one which leads to memory overwrites if used with
> large chunks of data.
> 
> Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
> index 63924e0..6835104 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -227,11 +227,13 @@ static inline void at91_mci_sg_to_dma(struct at91mci_host *host, struct mmc_data
>  			for (index = 0; index < (amount / 4); index++)
>  				*dmabuf++ = swab32(sgbuffer[index]);
>  		} else {
> -			memcpy(dmabuf, sgbuffer, amount);
> -			dmabuf += amount;
> +			char *tmpv = (char *)dmabuf;
> +			memcpy(tmpv, sgbuffer, amount);
> +			tmpv += amount;
> +			dmabuf = (unsigned *)tmpv;
>  		}
>  
> -		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
>  
>  		if (size == 0)
>  			break;
> -- 
> 1.5.6.5

Looks like only the first half of this patch was applied?  The
kunmap_atomic() line is still present as before in Linus' tree. 

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
