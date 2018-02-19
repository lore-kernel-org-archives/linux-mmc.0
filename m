From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 11/16] mmc: sdhci: Program a relatively accurate SW
 timeout value
Date: Mon, 19 Feb 2018 11:24:37 +0200
Message-ID: <a65e45a0-8032-b2b8-c590-c28a5e12a5c6@intel.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-12-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180205125029.21570-12-kishon@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
> sdhci has a 10 second timeout to catch devices that stop responding.
> Instead of programming 10 second arbitrary value, calculate the total time
> it would take for the entire transfer to happen and program the timeout
> value accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>  2 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0489572d1892..d52f9e7eabe2 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -673,6 +673,37 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd,
> +				  unsigned int target_timeout)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned long long transfer_time;
> +	struct mmc_ios *ios = &mmc->ios;
> +	unsigned char bus_width = ios->bus_width;
> +	unsigned int blksz;
> +	unsigned int freq;
> +
> +	if (data) {
> +		blksz = data->blksz;
> +		freq = host->mmc->actual_clock ? host->mmc->actual_clock :
> +						host->clock;

I think this can be:

		freq = host->mmc->actual_clock ? : host->clock;

> +		transfer_time = (unsigned long long)(blksz * NSEC_PER_SEC *
> +						     (8 / bus_width)) / freq;

You have got a 32-bit overflow here and a 64-bit division that can't always
be done with '/'

> +		/* multiply by '2' to account for any unknowns */
> +		transfer_time = transfer_time * 2;

		transfer_time *= 2;

> +		/* calculate timeout for the entire data */
> +		host->data_timeout = (data->blocks * ((target_timeout *
> +						       NSEC_PER_USEC) +
> +						       transfer_time));
> +	} else {
> +		host->data_timeout = target_timeout * NSEC_PER_USEC;

And another 32-bit overflow here

> +	}
> +
> +	host->data_timeout += MMC_CMD_TRANSFER_TIME;
> +}
> +
>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 count;
> @@ -742,6 +773,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  			host->hw_timeout_disabled = true;
>  		}
>  	}
> +	sdhci_calc_sw_timeout(host, cmd, target_timeout);
>  
>  	return count;
>  }
> @@ -1130,13 +1162,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		mdelay(1);
>  	}
>  
> -	timeout = jiffies;
> -	if (!cmd->data && cmd->busy_timeout > 9000)
> -		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> -	else
> -		timeout += 10 * HZ;
> -	sdhci_mod_timer(host, cmd, timeout);
> -
>  	host->cmd = cmd;
>  	if (sdhci_data_line_cmd(cmd)) {
>  		WARN_ON(host->data_cmd);
> @@ -1176,6 +1201,13 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
>  		flags |= SDHCI_CMD_DATA;
>  
> +	timeout = jiffies;
> +	if (sdhci_data_line_cmd(cmd))
> +		timeout += nsecs_to_jiffies(host->data_timeout);
> +	else
> +		timeout += 10 * HZ;
> +	sdhci_mod_timer(host, cmd, timeout);

Here you probably want to avoid updating the timer if the mrq has already
started using host->data_timeout.

> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_command);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 3a967a56fcc3..b73577d77856 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -332,6 +332,14 @@ struct sdhci_adma2_64_desc {
>  /* Allow for a a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS		2
>  
> +/*
> + * 48bit command and 136 bit response in 400KHz clock should take 0.46ms.

I am not sure the math is correct here.  I would add the 64 clocks before
the response also, and allow for 100 kHz clock.

	(48 + 64 + 136) * 100 us = 24.8 ms

Given that you are looking at data block timeouts in excess of 700 ms, and
anything up to 10% of that is relatively negligible, anything less that 70
ms seems fine, so I would set 30 ms here as a round number.

> + * However since the start time of the command, the time between
> + * command and response, and the time between response and start of data is
> + * not known, set the command transfer time to 2ms.
> + */
> +#define MMC_CMD_TRANSFER_TIME	(2 * NSEC_PER_MSEC) /* max 2 ms */
> +
>  enum sdhci_cookie {
>  	COOKIE_UNMAPPED,
>  	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
> @@ -554,6 +562,8 @@ struct sdhci_host {
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
>  
> +	unsigned long long	data_timeout;

nsecs_to_jiffies() uses u64 which is nicer I think

> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> 
