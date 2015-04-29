From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [RFC/PATCH] mmc: block: use block layer pm helpers for pm of
 card device
Date: Wed, 29 Apr 2015 11:45:20 +0300
Message-ID: <55409A20.6070600@codeaurora.org>
References: <1429626045-12847-1-git-send-email-kdorfman@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429626045-12847-1-git-send-email-kdorfman@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Ulf, Chris,

Now as rc1 is out and the patch format fixed, please look into it again.

Thanks,
Kostya

On 04/21/2015 05:20 PM, Konstantin Dorfman wrote:
> Use of block layer runtime PM helpers, implementing the block layer's
> request-based mechanism, simplifies data path of mmc core layer. It
> enables to remove synchronous call pm_runtime_get_sync() from mmc core
> data path.
>
> The idea and API is designed by Alan Stern and described here:
>      http://marc.info/?l=linux-scsi&m=133727953625963&w=2
>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1fa4c80..de5f85d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2017,7 +2017,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>
>   	if (req && !mq->mqrq_prev->req)
>   		/* claim host only for the first request */
> -		mmc_get_card(card);
> +		mmc_claim_host(card->host);
>
>   	ret = mmc_blk_part_switch(card, md);
>   	if (ret) {
> @@ -2060,7 +2060,7 @@ out:
>   		 * In case sepecial request, there is no reentry to
>   		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>   		 */
> -		mmc_put_card(card);
> +		mmc_release_host(card->host);
>   	return ret;
>   }
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index feea926..e12c828 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -213,6 +213,11 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>   	if (mmc_can_erase(card))
>   		mmc_queue_setup_discard(mq->queue, card);
>
> +	if (!subname) {
> +		blk_pm_runtime_init(mq->queue, &card->dev);
> +		card->q = mq->queue;
> +	}
> +
>   #ifdef CONFIG_MMC_BLOCK_BOUNCE
>   	if (host->max_segs == 1) {
>   		unsigned int bouncesz;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a301a78..bf3f919 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -14,6 +14,7 @@
>   #include <linux/slab.h>
>   #include <linux/stat.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/blkdev.h>
>
>   #include <linux/mmc/host.h>
>   #include <linux/mmc/card.h>
> @@ -1814,11 +1815,17 @@ static int mmc_runtime_suspend(struct mmc_host *host)
>   	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
>   		return 0;
>
> +	err = blk_pre_runtime_suspend(host->card->q);
> +	if (err)
> +		return err;
> +
>   	err = _mmc_suspend(host, true);
>   	if (err)
>   		pr_err("%s: error %d doing aggessive suspend\n",
>   			mmc_hostname(host), err);
>
> +	blk_post_runtime_suspend(host->card->q, err);
> +
>   	return err;
>   }
>
> @@ -1832,12 +1839,16 @@ static int mmc_runtime_resume(struct mmc_host *host)
>   	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
>   		return 0;
>
> +	blk_pre_runtime_resume(host->card->q);
> +
>   	err = _mmc_resume(host);
>   	if (err)
>   		pr_err("%s: error %d doing aggessive resume\n",
>   			mmc_hostname(host), err);
>
> -	return 0;
> +	blk_post_runtime_resume(host->card->q, err);
> +
> +	return err;
>   }
>
>   static int mmc_power_restore(struct mmc_host *host)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b0692d2..1f4810b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -244,6 +244,7 @@ struct mmc_part {
>   struct mmc_card {
>   	struct mmc_host		*host;		/* the host this device belongs to */
>   	struct device		dev;		/* the device */
> +	struct request_queue    *q;
>   	u32			ocr;		/* the current OCR setting */
>   	unsigned int		rca;		/* relative card address of device */
>   	unsigned int		type;		/* card type */
>


-- 
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
