From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/8] mmc: atmel-mci: Remove redundant runtime PM calls
Date: Tue, 29 Mar 2016 17:03:36 +0200
Message-ID: <20160329150336.GG820@odux.rfo.atmel.com>
References: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:3445 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbcC2PEF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 11:04:05 -0400
Content-Disposition: inline
In-Reply-To: <1459236673-5639-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

On Tue, Mar 29, 2016 at 09:31:06AM +0200, Ulf Hansson wrote:
> Commit 9250aea76bfc ("mmc: core: Enable runtime PM management of host
> devices"), made some calls to the runtime PM API from the driver
> redundant. Especially those which deals with runtime PM reference
> counting, so let's remove them.
> 
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  drivers/mmc/host/atmel-mci.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 9268c41..0ad8ef5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1410,8 +1410,6 @@ static void atmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	WARN_ON(slot->mrq);
>  	dev_dbg(&host->pdev->dev, "MRQ: cmd %u\n", mrq->cmd->opcode);
>  
> -	pm_runtime_get_sync(&host->pdev->dev);
> -
>  	/*
>  	 * We may "know" the card is gone even though there's still an
>  	 * electrical connection. If so, we really need to communicate
> @@ -1442,8 +1440,6 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	struct atmel_mci	*host = slot->host;
>  	unsigned int		i;
>  
> -	pm_runtime_get_sync(&host->pdev->dev);
> -
>  	slot->sdc_reg &= ~ATMCI_SDCBUS_MASK;
>  	switch (ios->bus_width) {
>  	case MMC_BUS_WIDTH_1:
> @@ -1576,8 +1572,6 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		break;
>  	}
>  
> -	pm_runtime_mark_last_busy(&host->pdev->dev);
> -	pm_runtime_put_autosuspend(&host->pdev->dev);
>  }
>  
>  static int atmci_get_ro(struct mmc_host *mmc)
> @@ -1669,9 +1663,6 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
>  	spin_unlock(&host->lock);
>  	mmc_request_done(prev_mmc, mrq);
>  	spin_lock(&host->lock);
> -
> -	pm_runtime_mark_last_busy(&host->pdev->dev);
> -	pm_runtime_put_autosuspend(&host->pdev->dev);
>  }
>  
>  static void atmci_command_complete(struct atmel_mci *host,
> -- 
> 1.9.1
> 
