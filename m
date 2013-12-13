From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: Allow for long command timeouts
Date: Fri, 13 Dec 2013 12:45:21 +0200
Message-ID: <52AAE541.6090606@intel.com>
References: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14530 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269Ab3LMKpV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Dec 2013 05:45:21 -0500
In-Reply-To: <1384416980-15850-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Chris

What about this one?

Regards
Adrian

On 14/11/13 10:16, Adrian Hunter wrote:
> The driver has a timer with a 10 second
> timeout to catch devices that stop responding.
> However it is possible for commands to take
> even longer than that.  Change the timer
> timeout to reflect the command timeout.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..614a34d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1013,7 +1013,12 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		mdelay(1);
>  	}
>  
> -	mod_timer(&host->timer, jiffies + 10 * HZ);
> +	timeout = jiffies;
> +	if (!cmd->data && cmd->cmd_timeout_ms > 9000)
> +		timeout += DIV_ROUND_UP(cmd->cmd_timeout_ms, 1000) * HZ + HZ;
> +	else
> +		timeout += 10 * HZ;
> +	mod_timer(&host->timer, timeout);
>  
>  	host->cmd = cmd;
>  
> 

