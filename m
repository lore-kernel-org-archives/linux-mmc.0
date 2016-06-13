From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 01/12] mmc: sdhci: add init_card callback to sdhci
Date: Mon, 13 Jun 2016 11:32:18 +0300
Message-ID: <575E6F92.6090305@intel.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55310 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880AbcFMIg0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Jun 2016 04:36:26 -0400
In-Reply-To: <1465456218-28354-2-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

On 09/06/16 10:10, Gregory CLEMENT wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> Some sdhci hosts may require handling quirks during card initialization
> at the time when its type is already known. Hence a new callback
> (init_card) is added in sdhci_ops.

I plan to remove init_card and other host ops that sdhci doesn't use (like
sdhci_select_drive_strength).  The driver must provide the mmc op instead.
e.g. in sdhci-xenon.c

	host->mmc_host_ops.init_card = sdhci_xenon_init_card

> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/sdhci.c | 9 +++++++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e3d7c056cb1..fd4e9a84f739 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2117,6 +2117,14 @@ static void sdhci_card_event(struct mmc_host *mmc)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +static void sdhci_init_card(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	if (host->ops->init_card)
> +		host->ops->init_card(host, card);
> +}
> +
>  static const struct mmc_host_ops sdhci_ops = {
>  	.request	= sdhci_request,
>  	.post_req	= sdhci_post_req,
> @@ -2132,6 +2140,7 @@ static const struct mmc_host_ops sdhci_ops = {
>  	.select_drive_strength		= sdhci_select_drive_strength,
>  	.card_event			= sdhci_card_event,
>  	.card_busy	= sdhci_card_busy,
> +	.init_card	= sdhci_init_card,
>  };
>  
>  /*****************************************************************************\
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 609f87ca536b..49c6c5b0e33b 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -549,6 +549,7 @@ struct sdhci_ops {
>  					 struct mmc_card *card,
>  					 unsigned int max_dtr, int host_drv,
>  					 int card_drv, int *drv_type);
> +	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 

