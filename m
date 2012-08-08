From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for bf518.
Date: Wed, 08 Aug 2012 00:11:43 -0400
Message-ID: <87vcgut43k.fsf@octavius.laptop.org>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51179 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab2HHELu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Aug 2012 00:11:50 -0400
In-Reply-To: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com> (Sonic
	Zhang's message of "Tue, 7 Aug 2012 11:10:12 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi,

On Mon, Aug 06 2012, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> bf518 RSI dma doesn't work in array mode.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/mmc/host/bfin_sdh.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
> index 0366617..fd25b0c 100644
> --- a/drivers/mmc/host/bfin_sdh.c
> +++ b/drivers/mmc/host/bfin_sdh.c
> @@ -469,7 +469,11 @@ static int __devinit sdh_probe(struct platform_device *pdev)
>  	}
>  
>  	mmc->ops = &sdh_ops;
> +#if defined(CONFIG_BF54x)
>  	mmc->max_segs = 32;
> +#elif defined(CONFIG_BF51x)
> +	mmc->max_segs = 1;
> +#endif
>  	mmc->max_seg_size = 1 << 16;
>  	mmc->max_blk_size = 1 << 11;
>  	mmc->max_blk_count = 1 << 11;

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
