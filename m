From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 08/12] mmc: sdhci: Program a relatively accurate SW
 timeout value
Date: Thu, 26 Apr 2018 10:52:22 +0300
Message-ID: <f6ce52ca-0756-1eca-e86b-3514d0a68323@intel.com>
References: <20180425120937.29867-1-kishon@ti.com>
 <20180425120937.29867-9-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-9-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 25/04/18 15:09, Kishon Vijay Abraham I wrote:
> sdhci has a 10 second timeout to catch devices that stop responding.
> In the case of quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, instead of
> programming 10 second arbitrary value, calculate the total time it would
> take for the entire transfer to happen and program the timeout value
> accordingly.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Looks like I lost a couple of chunks of the patch, sorry :-(
i.e.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1ed0b8b6570a..a019fd01ccf2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1234,13 +1234,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	timeout = jiffies;
-	if (!cmd->data && cmd->busy_timeout > 9000)
-		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
-	else
-		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd->mrq, timeout);
-
 	host->cmd = cmd;
 	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
@@ -1280,6 +1273,15 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
+	timeout = jiffies;
+	if (host->data_timeout)
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else if (!cmd->data && cmd->busy_timeout > 9000)
+		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, cmd->mrq, timeout);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);


> ---
>  drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c432ec3644aa..1ed0b8b6570a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -738,6 +738,39 @@ static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>  	return target_timeout;
>  }
>  
> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
> +				  struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +	struct mmc_host *mmc = host->mmc;
> +	struct mmc_ios *ios = &mmc->ios;
> +	unsigned char bus_width = 1 << ios->bus_width;
> +	unsigned int blksz;
> +	unsigned int freq;
> +	u64 target_timeout;
> +	u64 transfer_time;
> +
> +	target_timeout = sdhci_target_timeout(host, cmd, data);
> +	target_timeout *= NSEC_PER_USEC;
> +
> +	if (data) {
> +		blksz = data->blksz;
> +		freq = host->mmc->actual_clock ? : host->clock;
> +		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
> +		do_div(transfer_time, freq);
> +		/* multiply by '2' to account for any unknowns */
> +		transfer_time = transfer_time * 2;
> +		/* calculate timeout for the entire data */
> +		host->data_timeout = data->blocks * target_timeout +
> +				     transfer_time;
> +	} else {
> +		host->data_timeout = target_timeout;
> +	}
> +
> +	if (host->data_timeout)
> +		host->data_timeout += MMC_CMD_TRANSFER_TIME;
> +}
> +
>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
>  			     bool *too_big)
>  {
> @@ -831,6 +864,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  		if (too_big &&
>  		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
> +			sdhci_calc_sw_timeout(host, cmd);
>  			sdhci_set_data_timeout_irq(host, false);
>  		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
>  			sdhci_set_data_timeout_irq(host, true);
> @@ -845,6 +879,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	u8 ctrl;
>  	struct mmc_data *data = cmd->data;
>  
> +	host->data_timeout = 0;
> +
>  	if (sdhci_data_line_cmd(cmd))
>  		sdhci_set_timeout(host, cmd);
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f6555c0f4ad3..23966f887da6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -332,6 +332,14 @@ struct sdhci_adma2_64_desc {
>  /* Allow for a a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS		2
>  
> +/*
> + * 48bit command and 136 bit response in 100KHz clock could take upto 2.48ms.
> + * However since the start time of the command, the time between
> + * command and response, and the time between response and start of data is
> + * not known, set the command transfer time to 10ms.
> + */
> +#define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
> +
>  enum sdhci_cookie {
>  	COOKIE_UNMAPPED,
>  	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
> @@ -555,6 +563,8 @@ struct sdhci_host {
>  	/* Host SDMA buffer boundary. */
>  	u32			sdma_boundary;
>  
> +	u64			data_timeout;
> +
>  	unsigned long private[0] ____cacheline_aligned;
>  };
>  
> 
