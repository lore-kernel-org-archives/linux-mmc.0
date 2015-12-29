From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 07/24] mmc: sdhci: command response CRC error handling
Date: Tue, 29 Dec 2015 15:08:20 +0200
Message-ID: <568285C4.9070909@intel.com>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <E1aAypl-00016T-IM@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12908 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbbL2NLl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Dec 2015 08:11:41 -0500
In-Reply-To: <E1aAypl-00016T-IM@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

On 21/12/15 13:40, Russell King wrote:
> When we get a response CRC error on a command, it means that the
> response we received back from the card was not correct.  It does not
> mean that the card did not receive the command correctly.  If the

Pedantically, if the timeout bit is set as well (CMD line conflict),
it does mean the card did not receive the command, so it should be coded
that way.

> command is one which initiates a data transfer, the card can enter the
> data transfer state, and start sending data.
> 
> Moreover, if the request contained a data phase, we do not clean this
> up, and this results in the driver triggering DMA API debug warnings,
> and also creates a race condition in the driver, between running the
> finish_tasklet and the data transfer interrupts, which can trigger a
> "Got data interrupt" state dump.
> 
> Fix this by handing a response CRC error slightly differently: record
> the failure of the data initiating command, but allow the remainder of
> the request to be processed normally.  This is safe as core MMC checks

"processed normally" confused me at first because it sounded like you are
ignoring the error.  Not sure why you have a much better explanation in the
cover email than here.

> the status of all commands and data transfer phases of the request.

MMC core is not the only initiator of requests, but it is safe because the
command error takes precedence by design.

Also you don't explain why it is better to continue rather than attempt to
send a stop command and clean up the request properly.  It looks simpler and
less racy, but if that is the reason then it seems worth saying so.

> 
> If the card does not initiate a data transfer, then we should time out
> according to the data transfer parameters.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 86310b162304..3e718e465a1b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2340,6 +2340,23 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
>  		else
>  			host->cmd->error = -EILSEQ;
>  
> +		/*
> +		 * If this command initiates a data phase and a response
> +		 * CRC error is signalled, the card can start transferring
> +		 * data - the card may have received the command without
> +		 * error.  We must not terminate the request early.

This is misleading.  We could terminate the request early if we cleaned it
up.  You should say here why it is better to continue.

> +		 *
> +		 * If the card did not receive the command, the data phase
> +		 * will time out.
> +		 *
> +		 * FIXME: we also need to clean up the data phase if any
> +		 * command fails, not just the data initiating command.

This FIXME is too vague.  Please give at least one example of what needs fixing.

> +		 */
> +		if (host->cmd->data && intmask & SDHCI_INT_CRC) {
> +			host->cmd = NULL;
> +			return;
> +		}
> +
>  		tasklet_schedule(&host->finish_tasklet);
>  		return;
>  	}
> 

