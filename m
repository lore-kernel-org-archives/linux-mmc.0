From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 09/12] mmc: sdhci: Use software timer when timeout
 greater than hardware capablility
Date: Wed, 20 Dec 2017 16:11:10 +0200
Message-ID: <74170f0a-329a-2c66-7ad4-a1fedb9747df@intel.com>
References: <20171214130941.26666-1-kishon@ti.com>
 <20171214130941.26666-10-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754337AbdLTOLq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 20 Dec 2017 09:11:46 -0500
In-Reply-To: <20171214130941.26666-10-kishon@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com

On 14/12/17 15:09, Kishon Vijay Abraham I wrote:
> Errata i834 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
> (SPRZ429K July 2014–Revised March 2017 [1]) mentions
> Under high speed HS200 and SDR104 modes, the functional clock for MMC
> modules will reach up to 192 MHz. At this frequency, the maximum obtainable
> timeout (DTO = 0xE) through MMC host controller is (1/192MHz)*2^27 = 700ms.
> Commands taking longer than 700ms may be affected by this small window
> frame. Workaround for this errata is use a software timer instead of
> hardware timer to provide the delay requested by the upper layer.
> 
> While this errata is specific to AM572x, it is applicable to all sdhci
> based controllers when a particular request require timeout greater
> than hardware capability.

It doesn't work for our controllers.  Even if the data timeout interrupt is
disabled, it seems like the timeout still "happens" in some fashion - after
which the host controller starts misbehaving.

So you will need to add a quirk.

> 
> Re-use the software timer already implemented in sdhci to program the
> correct timeout value and also disable the hardware timeout when
> the required timeout is greater than hardware capabiltiy in order to
> avoid spurious timeout interrupts.
> 
> This patch is based on the earlier patch implemented for omap_hsmmc [2]
> 
> [1] -> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf
> [2] -> https://patchwork.kernel.org/patch/9791449/
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/sdhci.h | 11 +++++++++++
>  2 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..d0655e1d2cc7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -673,6 +673,27 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd,
> +				  unsigned int target_timeout)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	struct mmc_ios *ios = &mmc->ios;
> +	struct mmc_data *data = cmd->data;
> +	unsigned long long transfer_time;
> +
> +	if (data) {
> +		transfer_time = MMC_BLOCK_TRANSFER_TIME_MS(data->blksz,
> +							   ios->bus_width,
> +							   ios->clock);

If it has a value, actual_clock is better than ios->clock.

> +		/* calculate timeout for the entire data */
> +		host->data_timeout = (data->blocks * (target_timeout +
> +						      transfer_time));
> +	} else if (cmd->flags & MMC_RSP_BUSY) {
> +		host->data_timeout = cmd->busy_timeout * MSEC_PER_SEC;

Doesn't need MSEC_PER_SEC multiplier.

> +	}
> +}
> +
>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 count;
> @@ -732,8 +753,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	if (count >= 0xF) {
> -		DBG("Too large timeout 0x%x requested for CMD%d!\n",
> -		    count, cmd->opcode);
> +		DBG("Too large timeout.. using SW timeout for CMD%d!\n",
> +		    cmd->opcode);
> +		sdhci_calc_sw_timeout(host, cmd, target_timeout);
> +		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
> +		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  		count = 0xE;
>  	}
>  
> @@ -1198,6 +1223,14 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> +	if (host->data_timeout) {
> +		unsigned long timeout;
> +
> +		timeout = jiffies +
> +			  msecs_to_jiffies(host->data_timeout);
> +		sdhci_mod_timer(host, host->cmd->mrq, timeout);

cmd could be the sbc or a stop cmd or a command during transfer, so this
needs more logic.

> +	}
> +
>  	host->cmd = NULL;
>  
>  	if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -2341,6 +2374,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  		return true;
>  	}
>  
> +	host->data_timeout = 0;
> +	host->ier |= SDHCI_INT_DATA_TIMEOUT;
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);

sdhci can have 2 requests in progress to allow for commands to be sent while
a data transfer is in progress, so this is not necessarily the data transfer
request that is done.  Also we want to avoid unnecessary register writes.

>  	sdhci_del_timer(host, mrq);
>  
>  	/*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 54bc444c317f..e6e0278bea1a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -332,6 +332,15 @@ struct sdhci_adma2_64_desc {
>  /* Allow for a a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS		2
>  
> +/*
> + * Time taken for transferring one block. It is multiplied by a constant
> + * factor '2' to account for any errors
> + */
> +#define MMC_BLOCK_TRANSFER_TIME_MS(blksz, bus_width, freq)		\
> +				   ((unsigned long long)		\
> +				   (2 * (((blksz) * MSEC_PER_SEC *	\
> +				   (8 / (bus_width))) / (freq))))

I don't think the macro helps make the code more readable.  Might just as
well write a nice function to calculate the entire data request timeout.

> +
>  enum sdhci_cookie {
>  	COOKIE_UNMAPPED,
>  	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
> @@ -546,6 +555,8 @@ struct sdhci_host {
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
>  
> +	unsigned long long	data_timeout;

msecs_to_jiffies() will truncate to 'unsigned int' anyway, so this might as
well be 'unsigned int'.

> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> 

