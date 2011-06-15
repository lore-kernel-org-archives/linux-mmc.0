From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH/RFC] mmc: ignore asynchronous calls on dead buses
Date: Wed, 15 Jun 2011 19:50:18 +0530
Message-ID: <4DF8BFA2.4080701@codeaurora.org>
References: <Pine.LNX.4.64.1106151349260.23363@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:13026 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab1FOOUX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 10:20:23 -0400
In-Reply-To: <Pine.LNX.4.64.1106151349260.23363@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 6/15/2011 6:58 PM, Guennadi Liakhovetski wrote:
> MMC host drivers have three main asynchronous event types, that they
> report to the MMC core: request completions, SDIO interrupts and card
> hotplug events. Avoid processing these calls during driver removal.
>
> Signed-off-by: Guennadi Liakhovetski<g.liakhovetski@gmx.de>
> ---
>
> This is my attempt to answer my own question:
>
> http://article.gmane.org/gmane.linux.kernel.mmc/8280
>
> All these races are very unlikely, but can be triggered artificially by
> inserting a delay in host drivers after mmc_remove_host().
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68091dd..c11e47b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -95,6 +95,9 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>   	struct mmc_command *cmd = mrq->cmd;
>   	int err = cmd->error;
>
> +	if (host->bus_dead)
> +		return;
> +
host->bus_dead is set when there are no interesting cards left on the 
bus. It doesn't mean host driver being removed. Probably, you should use 
host->removed instead.
>   	if (err&&  cmd->retries&&  mmc_host_is_spi(host)) {
>   		if (cmd->resp[0]&  R1_SPI_ILLEGAL_COMMAND)
>   			cmd->retries = 0;
> @@ -1162,7 +1165,8 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>   	spin_unlock_irqrestore(&host->lock, flags);
>   #endif
>
> -	mmc_schedule_delayed_work(&host->detect, delay);
> +	if (!host->bus_dead)
> +		mmc_schedule_delayed_work(&host->detect, delay);
>   }
>
>   EXPORT_SYMBOL(mmc_detect_change);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1ee4424..1a1f2a4 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -311,6 +311,9 @@ extern void mmc_request_done(struct mmc_host *, struct mmc_request *);
>
>   static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>   {
> +	if (host->bus_dead)
> +		return;
> +
>   	host->ops->enable_sdio_irq(host, 0);
>   	wake_up_process(host->sdio_irq_thread);
>   }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Thanks
Sujit

--
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
