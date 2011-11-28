From: "Sujit Reddy Thumma" <sthumma@codeaurora.org>
Subject: Re: [PATCH V3] mmc: allow upper layers to determine immediately if
     a card has been removed
Date: Mon, 28 Nov 2011 05:32:13 -0800 (PST)
Message-ID: <c879641273f32677cf926c10eeee0220.squirrel@www.codeaurora.org>
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
...

> +int _mmc_detect_card_removed(struct mmc_host *host)
> +{
> +	int ret;
> +
> +	if (!(host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)

This should be just "if ((host->caps & MMC_CAP_NONREMOVABLE) || ...)"

Otherwise, Acked-by: Sujit Reddy Thumma <sthumma@codeaurora.org>

> +		return 0;
> +
> +	if (!host->card || mmc_card_removed(host->card))
> +		return 1;
> +
> +	ret = host->bus_ops->alive(host);
> +	if (ret) {
> +		mmc_card_set_removed(host->card);
> +		pr_info("%s: card removed\n", mmc_hostname(host));
> +	}
> +
> +	return ret;
> +}
> +


-- 
Thanks
Sujit
