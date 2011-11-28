From: "Sujit Reddy Thumma" <sthumma@codeaurora.org>
Subject: Re: [PATCH V3] mmc: allow upper layers to determine immediately if
     a card has been removed
Date: Mon, 28 Nov 2011 05:37:23 -0800 (PST)
Message-ID: <9a3d4e0770dc0d7421d6abf0e1a57166.squirrel@www.codeaurora.org>
References: <1322485335-17922-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1322485335-17922-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Chris Ball <cjb@laptop.org>, per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org


> Add a function mmc_detect_card_removed() which upper layers
> can use to determine immediately if a card has been removed.
> This function should be called after an I/O request fails so
> that all queued I/O requests can be errored out immediately
> instead of waiting for the card device to be removed.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c  |   51
> +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/core/core.h  |    3 ++
>  drivers/mmc/core/mmc.c   |   12 ++++++++++-
>  drivers/mmc/core/sd.c    |   12 ++++++++++-
>  drivers/mmc/core/sdio.c  |   11 +++++++++-
>  include/linux/mmc/card.h |    3 ++
>  include/linux/mmc/core.h |    2 +
>  include/linux/mmc/host.h |    1 +
>  8 files changed, 89 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 271efea..3dacc98 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -140,7 +140,7 @@ void mmc_request_done(struct mmc_host *host, struct
> mmc_request *mrq)
>  			cmd->retries = 0;
>  	}
>
> -	if (err && cmd->retries) {
> +	if (err && cmd->retries && !mmc_card_removed(host->card)) {
>  		/*
>  		 * Request starter must handle retries - see
>  		 * mmc_wait_for_req_done().
> @@ -247,6 +247,11 @@ static void __mmc_start_req(struct mmc_host *host,
> struct mmc_request *mrq)
>  {
>  	init_completion(&mrq->completion);
>  	mrq->done = mmc_wait_done;
> +	if (mmc_card_removed(host->card)) {
> +		mrq->cmd->error = -ENOMEDIUM;
> +		complete(&mrq->completion);
> +		return;
> +	}
>  	mmc_start_request(host, mrq);
>  }
>
> @@ -259,7 +264,8 @@ static void mmc_wait_for_req_done(struct mmc_host
> *host,
>  		wait_for_completion(&mrq->completion);
>
>  		cmd = mrq->cmd;
> -		if (!cmd->error || !cmd->retries)
> +		if (!cmd->error || !cmd->retries ||
> +		    mmc_card_removed(host->card))
>  			break;
>
>  		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
> @@ -1456,7 +1462,7 @@ void mmc_detect_change(struct mmc_host *host,
> unsigned long delay)
>  	WARN_ON(host->removed);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  #endif
> -
> +	host->detect_change = 1;
>  	mmc_schedule_delayed_work(&host->detect, delay);
>  }
>
> @@ -2049,6 +2055,43 @@ static int mmc_rescan_try_freq(struct mmc_host
> *host, unsigned freq)
>  	return -EIO;
>  }
>
> +int _mmc_detect_card_removed(struct mmc_host *host)
> +{
> +	int ret;
> +
> +	if (!(host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
> +		return 0;
> +
> +	if (!host->card || mmc_card_removed(host->card))
> +		return 1;
> +
> +	ret = host->bus_ops->alive(host);
> +	if (ret) {
> +		mmc_card_set_removed(host->card);
> +		pr_info("%s: card removed\n", mmc_hostname(host));

We are printing the same information when mmc_remove_card() is called. Can
we move this to pr_debug() here?
