From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH V3] mmc:core: Avoid useless detecting task when card is
 busy
Date: Tue, 24 Sep 2013 11:42:31 +0800
Message-ID: <52410A27.5020100@freescale.com>
References: <1379988511-1111-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:27468
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752216Ab3IXDm3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 23 Sep 2013 23:42:29 -0400
In-Reply-To: <1379988511-1111-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org

Hi, Ulf

I had update the patch according to your suggestion.
I test on my platform during last night.
About 200G random continuous data was written to 32G SDHC Card.
No call trace was encountered.
I think it can meet with your demand and solve the problem.


=D3=DA 2013/9/24 10:08, Haijun Zhang =D0=B4=B5=C0:
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
> ---
> changes for V3:
> 	- Remove mmc_try_claim_host.
> changes for V2:
> 	- Add card detecting once the last request is done.
>
>  drivers/mmc/card/block.c | 29 +++++++++++++++++++++++++++--
>  drivers/mmc/core/mmc.c   |  5 +++++
>  drivers/mmc/core/sd.c    |  5 +++++
>  drivers/mmc/core/sdio.c  |  5 +++++
>  4 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1a3163f..d1f1730 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1960,9 +1960,21 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
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
> +			cancel_delayed_work(&host->detect);
> +		}
> +
>  		/* claim host only for the first request */
>  		mmc_get_card(card);
> +	}
> =20
>  	ret =3D mmc_blk_part_switch(card, md);
>  	if (ret) {
> @@ -1999,7 +2011,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
> =20
>  out:
>  	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
> -	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
> +			(req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
>  		/*
>  		 * Release host when there are no more requests
>  		 * and after special request(discard, flush) is done.
> @@ -2007,6 +2019,19 @@ out:
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
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6d02012..4bdf68c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1443,6 +1443,7 @@ static int mmc_alive(struct mmc_host *host)
>  static void mmc_detect(struct mmc_host *host)
>  {
>  	int err;
> +	unsigned long flags;
> =20
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
> @@ -1457,6 +1458,10 @@ static void mmc_detect(struct mmc_host *host)
>  	mmc_put_card(host->card);
> =20
>  	if (err) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		host->rescan_disable =3D 0;
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
>  		mmc_remove(host);
> =20
>  		mmc_claim_host(host);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 5e8823d..c87203c 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1041,6 +1041,7 @@ static int mmc_sd_alive(struct mmc_host *host)
>  static void mmc_sd_detect(struct mmc_host *host)
>  {
>  	int err;
> +	unsigned long flags;
> =20
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
> @@ -1055,6 +1056,10 @@ static void mmc_sd_detect(struct mmc_host *hos=
t)
>  	mmc_put_card(host->card);
> =20
>  	if (err) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		host->rescan_disable =3D 0;
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
>  		mmc_sd_remove(host);
> =20
>  		mmc_claim_host(host);
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 80d89cff..a59e34b 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -862,6 +862,7 @@ static int mmc_sdio_alive(struct mmc_host *host)
>  static void mmc_sdio_detect(struct mmc_host *host)
>  {
>  	int err;
> +	unsigned long flags;
> =20
>  	BUG_ON(!host);
>  	BUG_ON(!host->card);
> @@ -900,6 +901,10 @@ static void mmc_sdio_detect(struct mmc_host *hos=
t)
> =20
>  out:
>  	if (err) {
> +		spin_lock_irqsave(&host->lock, flags);
> +		host->rescan_disable =3D 0;
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
>  		mmc_sdio_remove(host);
> =20
>  		mmc_claim_host(host);

--=20
Thanks & Regards
Haijun.


