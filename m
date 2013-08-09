From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] mmc:sdhci: Wait longer for command with busy flags
Date: Thu, 8 Aug 2013 17:18:33 -0700
Message-ID: <20130809001833.GC7427@lizard.mcd01528.sjc.wayport.net>
References: <1375258904-25163-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35212 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966954Ab3HIAXM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 20:23:12 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so4244851pab.7
        for <linux-mmc@vger.kernel.org>; Thu, 08 Aug 2013 17:23:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1375258904-25163-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On Wed, Jul 31, 2013 at 04:21:44PM +0800, Haijun Zhang wrote:
> When command with busy flags send and also data busy end interrupt
> will be generate, the command will be finished when data transfer
> complete or data busy state end, Sometimes this will expend more than
> 10*Hz time to finish this command, so we should wait longer to detect
> command complete timeout err.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a78bd4f..7b89ed6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -986,6 +986,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	int flags;
>  	u32 mask;
>  	unsigned long timeout;
> +	u32 timer = 10;
>  
>  	WARN_ON(host->cmd);
>  
> @@ -1014,6 +1015,17 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		mdelay(1);
>  	}
>  
> +	/*
> +	 * When send a commmand with busy state and also the data busy end
> +	 * interrupt can be generate, the command will be finished when date
> +	 * transfer complete or busy state end. Sometimes this will expend
> +	 * more than 10*HZ, In this case whe should wait longer to detect
> +	 * command complete timeout err.
> +	 */
> +	if ((host->cmd->flags & MMC_RSP_BUSY) &&
> +			!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ))
> +		timer = 1000;
> +

This code effectively does nothing... you never use the newly introduced
'timer' variable.

>  	mod_timer(&host->timer, jiffies + 10 * HZ);
>  
>  	host->cmd = cmd;
> -- 
> 1.8.0
