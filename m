From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] tmio_mmc: Improve readability of the output of
 pr_debug_status()
Date: Fri, 4 Feb 2011 20:34:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1102042028120.14717@axis700.grange>
References: <1296808387-21935-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296808387-21935-1-git-send-email-horms@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 4 Feb 2011, Simon Horman wrote:

> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/tmio_mmc.h |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 6f724de..811427d 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -237,12 +237,16 @@ static inline void tmio_mmc_kunmap_atomic(void *virt,
>  
>  #define STATUS_TO_TEXT(a) \
>  	do { \
> -		if (status & TMIO_STAT_##a) \
> +		if (status & TMIO_STAT_##a) { \
> +			if (i++) \
> +				printk("|"); \
>  			printk(#a); \
> +		} \

Personally, I find it a bad idea to use variables in macros without 
explicitly passing them in the parameter list. Yes, this macro is already 
using "status" in that way, still, I don't think, that adding more such 
variables is good. Why not make it STATUS_TO_TEXT(a, status, i) and also 
add spaces for better yet readability like printk(" | ")?

Thanks
Guennadi

>  	} while (0)
>  
>  void pr_debug_status(u32 status)
>  {
> +	int i = 0;
>  	printk(KERN_DEBUG "status: %08x = ", status);
>  	STATUS_TO_TEXT(CARD_REMOVE);
>  	STATUS_TO_TEXT(CARD_INSERT);
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
