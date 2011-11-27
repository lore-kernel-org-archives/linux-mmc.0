From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 20/62] mmc: remove the second argument of k[un]map_atomic()
Date: Sun, 27 Nov 2011 22:02:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1111272159520.8317@axis700.grange>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-21-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60750 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1K0VD1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 27 Nov 2011 16:03:27 -0500
In-Reply-To: <1322371662-26166-21-git-send-email-amwang@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cong Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <cjb@laptop.org>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alex Dubov <oakad@yahoo.com>, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Cong Wang

Thanks for the patch, one small comment though:

On Sun, 27 Nov 2011, Cong Wang wrote:

> 
> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 ++++----
>  drivers/mmc/host/msm_sdcc.c |    6 +++---
>  drivers/mmc/host/sdhci.c    |    4 ++--
>  drivers/mmc/host/tifm_sd.c  |   16 ++++++++--------
>  drivers/mmc/host/tmio_mmc.c |    1 -
>  drivers/mmc/host/tmio_mmc.h |    4 ++--
>  6 files changed, 19 insertions(+), 20 deletions(-)

[snip]

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index a4ea102..4626ef2 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -20,7 +20,6 @@
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/scatterlist.h>
> -
>  #include "tmio_mmc.h"
>  
>  #ifdef CONFIG_PM

This hunk doesn't belong here, please, drop it.

Otherwise for TMIO

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 3020f98..a95e6d9 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -105,13 +105,13 @@ static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
>  					 unsigned long *flags)
>  {
>  	local_irq_save(*flags);
> -	return kmap_atomic(sg_page(sg), KM_BIO_SRC_IRQ) + sg->offset;
> +	return kmap_atomic(sg_page(sg)) + sg->offset;
>  }
>  
>  static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
>  					  unsigned long *flags, void *virt)
>  {
> -	kunmap_atomic(virt - sg->offset, KM_BIO_SRC_IRQ);
> +	kunmap_atomic(virt - sg->offset);
>  	local_irq_restore(*flags);
>  }
>  
> -- 
> 1.7.4.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
