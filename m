From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: block: add block number limitation flag for
 lultiple block read
Date: Fri, 30 May 2014 20:00:17 +0900
Message-ID: <538864C1.2040203@samsung.com>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
 <87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi, Kuninori.

Subject has the typo. lultiple -> multiple?
I didn't know why you need this patch. Would you use the MMC_CAP2_NO_MULTI_READ?
And I think...it's not good that used the card's capability flags to fix your H/W bug.

Best Regards,
Jaehoon Chung

On 05/30/2014 07:40 PM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> In some controllers, when performing a multiple block read of
> one or two blocks, depending on the timing with which the
> response register is read, the response value may not
> be read properly.
> Use single block read for this HW bug
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/card/block.c |   19 +++++++++++++++++--
>  include/linux/mmc/host.h |    3 +++
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 452782b..f3cbe37 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1400,8 +1400,23 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  
>  		/* Some controllers can't do multiblock reads due to hw bugs */
>  		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
> -		    rq_data_dir(req) == READ)
> -			brq->data.blocks = 1;
> +		    rq_data_dir(req) == READ) {
> +
> +			if (card->host->caps2 & MMC_CAP2_2BLKS_LIMIT) {
> +				/*
> +				 * In some controllers, when performing a
> +				 * multiple block read of one or two blocks,
> +				 * depending on the timing with which the
> +				 * response register is read, the response
> +				 * value may not be read properly.
> +				 * Use single block read for this HW bug
> +				 */
> +				if (brq->data.blocks == 2)
> +					brq->data.blocks = 1;
> +			} else {
> +				brq->data.blocks = 1;
> +			}
> +		}
>  	}
>  
>  	if (brq->data.blocks > 1 || do_rel_wr) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index cb61ea4..5429cd7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -266,6 +266,9 @@ struct mmc_host {
>  #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
>  #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
>  #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
> +#define MMC_CAP2_2BLKS_LIMIT	(1 << 4)	/* 2 blocks limit for multi read */
> +#define MMC_CAP2_NO_2BLKS_READ	(MMC_CAP2_NO_MULTI_READ | \
> +				 MMC_CAP2_2BLKS_LIMIT)
>  #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
>  #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
>  #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
> 

