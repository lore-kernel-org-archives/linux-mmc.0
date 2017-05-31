From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/5] mmc: tmio: improve checkpatch cleanness
Date: Wed, 31 May 2017 22:02:35 +0200
Message-ID: <20170531200235.GG22266@verge.net.au>
References: <1496148654-20386-1-git-send-email-horms+renesas@verge.net.au>
 <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496148654-20386-5-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, May 30, 2017 at 02:50:53PM +0200, Simon Horman wrote:
> Trivial updates to improve checkpatch cleanness.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

...

> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 70516abd50a1..07905c05f356 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -127,16 +127,17 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
>  
>  #define STATUS_TO_TEXT(a, status, i) \
>  	do { \
> -		if (status & TMIO_STAT_##a) { \
> -			if (i++) \
> -				printk(" | "); \
> -			printk(#a); \
> +		if ((status) & TMIO_STAT_##a) { \
> +			if ((i)++) \
> +				printk(KERN_DEBUG, " | "); \
> +			printk(KERN_DEBUG, #a); \

Ooops, 0-day tells me that there should not be a comma after KERN_DEBUG.
I'll fix that in v2.

...
