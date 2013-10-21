From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH V5] mmc:core: Avoid useless detecting task when card is
 busy
Date: Mon, 21 Oct 2013 17:16:44 +0800
Message-ID: <5264F0FC.7030604@freescale.com>
References: <1380164213-25130-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.185] ([216.32.180.185]:45786 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753134Ab3JUJRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 05:17:36 -0400
In-Reply-To: <1380164213-25130-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org

Hi, chris

The patch is acked by Ulf.

Could you give some advice?

Thanks.

=D3=DA 2013/9/26 10:56, Haijun Zhang =D0=B4=B5=C0:
> When card is in cpu polling mode to detect card present. Card detecti=
ng
> task will be scheduled about once every second. When card is busy in =
large
> file transfer, detecting task will be hang and call trace will be pro=
mpt.
> When handling the request, CMD13 is always followed by every command =
when
> it was complete. So assume that card is present to avoid this duplica=
te
> detecting. Only polling card when card is free to reduce conflict wit=
h
> data transfer.
>
> <7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
> INFO: task kworker/u:1:12 blocked for more than 120 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> kworker/u:1     D 00000000     0    12      2 0x00000000
> Call Trace:
> [ee06dd50] [44042028] 0x44042028
> (unreliable)
> [ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
> [ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4
>
> [ee06dea0] [c04dd898] schedule+0x30/0xbc
>
> [ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c
>
> [ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0
>
> [ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
> [ee06df40] [c00661cc] process_one_work+0x140/0x3e0
>
> [ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
> [ee06dfb0] [c006bf10] kthread+0x7c/0x80
>
> [ee06dff0] [c000de58] kernel_thread+0x4c/0x68
> <7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
>
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/card/block.c | 28 ++++++++++++++++++++++++++--
>  drivers/mmc/core/core.c  |  5 +++++
>  2 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1a3163f..988f16b 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1960,9 +1960,20 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
mq, struct request *req)
>  	struct mmc_host *host =3D card->host;
>  	unsigned long flags;
> =20
> -	if (req && !mq->mqrq_prev->req)
> +	if (req && !mq->mqrq_prev->req) {
> +		/*
> +		 * When we are here, card polling task will be blocked.
> +		 * So disable it to avoid this useless schedule.
> +		 */
> +		if (host->caps & MMC_CAP_NEEDS_POLL) {
> +			spin_lock_irqsave(&host->lock, flags);
> +			host->rescan_disable =3D 1;
> +			spin_unlock_irqrestore(&host->lock, flags);
> +		}
> +
>  		/* claim host only for the first request */
>  		mmc_get_card(card);
> +	}
> =20
>  	ret =3D mmc_blk_part_switch(card, md);
>  	if (ret) {
> @@ -1999,7 +2010,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
> =20
>  out:
>  	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
> -	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
> +			(req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
>  		/*
>  		 * Release host when there are no more requests
>  		 * and after special request(discard, flush) is done.
> @@ -2007,6 +2018,19 @@ out:
>  		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>  		 */
>  		mmc_put_card(card);
> +
> +		/*
> +		 * Detecting card status immediately in case card being
> +		 * removed just after the request is complete.
> +		 */
> +		if (host->caps & MMC_CAP_NEEDS_POLL) {
> +			spin_lock_irqsave(&host->lock, flags);
> +			host->rescan_disable =3D 0;
> +			spin_unlock_irqrestore(&host->lock, flags);
> +			mmc_detect_change(host, 0);
> +		}
> +	}
> +
>  	return ret;
>  }
> =20
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bf18b6b..9ab7020 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2400,6 +2400,7 @@ int mmc_detect_card_removed(struct mmc_host *ho=
st)
>  {
>  	struct mmc_card *card =3D host->card;
>  	int ret;
> +	unsigned long flags;
> =20
>  	WARN_ON(!host->claimed);
> =20
> @@ -2422,6 +2423,10 @@ int mmc_detect_card_removed(struct mmc_host *h=
ost)
>  			 * Schedule a detect work as soon as possible to let a
>  			 * rescan handle the card removal.
>  			 */
> +			spin_lock_irqsave(&host->lock, flags);
> +			host->rescan_disable =3D 0;
> +			spin_unlock_irqrestore(&host->lock, flags);
> +
>  			cancel_delayed_work(&host->detect);
>  			mmc_detect_change(host, 0);
>  		}

--=20
Thanks & Regards
Haijun.


