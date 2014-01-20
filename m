From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH] mmc: sdhci: fix possible scheduling while atomic
Date: Mon, 20 Jan 2014 10:51:19 +0100
Message-ID: <A623A9FE-1971-47A9-B05E-C48BA438EA43@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3823 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbaATJvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 04:51:22 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Chris,

The suggested fix can lock out interrupts for up to 150ms.  There needs to be another way.
So, I would strongly recommend we find another solution.

Philip

On Jan 17, 2014, at 7:57 PM, Andrew Bresticker <abrestic@chromium.org> wrote:

> sdhci_execute_tuning() takes host->lock without disabling interrupts.
> Use spin_lock_irq{save,restore} instead so that we avoid taking an
> interrupt and scheduling while holding host->lock.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
> drivers/mmc/host/sdhci.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ec3eb30..84c80e7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1857,12 +1857,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 	unsigned long timeout;
> 	int err = 0;
> 	bool requires_tuning_nonuhs = false;
> +	unsigned long flags;
> 
> 	host = mmc_priv(mmc);
> 
> 	sdhci_runtime_pm_get(host);
> 	disable_irq(host->irq);
> -	spin_lock(&host->lock);
> +	spin_lock_irqsave(&host->lock, flags);


The disable_irq() call stops the controller from doing interrupts.  
Please explain what problem you are seeing

> 
> 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 
> @@ -1882,14 +1883,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 	    requires_tuning_nonuhs)
> 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
> 	else {
> -		spin_unlock(&host->lock);
> +		spin_unlock_irqrestore(&host->lock, flags);
> 		enable_irq(host->irq);
> 		sdhci_runtime_pm_put(host);
> 		return 0;
> 	}
> 
> 	if (host->ops->platform_execute_tuning) {
> -		spin_unlock(&host->lock);
> +		spin_unlock_irqrestore(&host->lock, flags);
> 		enable_irq(host->irq);
> 		err = host->ops->platform_execute_tuning(host, opcode);
> 		sdhci_runtime_pm_put(host);
> @@ -1963,7 +1964,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 		host->cmd = NULL;
> 		host->mrq = NULL;
> 
> -		spin_unlock(&host->lock);
> +		spin_unlock_irqrestore(&host->lock, flags);
> 		enable_irq(host->irq);
> 
> 		/* Wait for Buffer Read Ready interrupt */
> @@ -1971,7 +1972,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
> 					(host->tuning_done == 1),
> 					msecs_to_jiffies(50));
> 		disable_irq(host->irq);
> -		spin_lock(&host->lock);
> +		spin_lock_irqsave(&host->lock, flags);
> 
> 		if (!host->tuning_done) {
> 			pr_info(DRIVER_NAME ": Timeout waiting for "
> @@ -2046,7 +2047,7 @@ out:
> 		err = 0;
> 
> 	sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
> -	spin_unlock(&host->lock);
> +	spin_unlock_irqrestore(&host->lock, flags);
> 	enable_irq(host->irq);
> 	sdhci_runtime_pm_put(host);
> 
> -- 
> 1.8.5.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
