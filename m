From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Tue, 12 Apr 2011 17:06:56 +0800
Message-ID: <5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
 <1302556424-21951-2-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34209 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab1DLJHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 05:07:21 -0400
In-Reply-To: <1302556424-21951-2-git-send-email-andreiw@motorola.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Andrei Warkentin
> Sent: Tuesday, April 12, 2011 5:14 AM
> To: linux-mmc@vger.kernel.org
> Cc: arnd@arndb.de; cjb@laptop.org; Andrei Warkentin
> Subject: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
> 
> ERASE command needs R1B response, so fix R1B-type command
> handling for SDHCI controller. For non-DAT commands using a busy
> reponse, the cmd->cmd_timeout_ms (in ms) field is used for timeout
> calculations.
> 
> Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/host/sdhci.c |   43 +++++++++++++++++++++++++++----------------
>  1 files changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9e15f41..173e980 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -40,7 +40,6 @@
> 
>  static unsigned int debug_quirks = 0;
> 
> -static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
>  static void sdhci_finish_data(struct sdhci_host *);
> 
>  static void sdhci_send_command(struct sdhci_host *, struct mmc_command *);
> @@ -591,9 +590,10 @@ static void sdhci_adma_table_post(struct sdhci_host
> *host,
>  		data->sg_len, direction);
>  }
> 
> -static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_data *data)
> +static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command
> *cmd)
>  {
>  	u8 count;
> +	struct mmc_data *data = cmd->data;
>  	unsigned target_timeout, current_timeout;
> 
>  	/*
> @@ -605,12 +605,16 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host,
> struct mmc_data *data)
>  	if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>  		return 0xE;
> 
> -	/* timeout in us */
> -	target_timeout = data->timeout_ns / 1000 +
> -		data->timeout_clks / host->clock;
> +	/* Unspecified timeout, assume max */
> +	if (!data && !cmd->cmd_timeout_ms)
> +		return 0xE;
Just a inline question here. I noticed cmd_timeout_ms only be set for the ERASE command and SWITCH command, for other types of commands, this value is left not initialized. Cmd_timeout_ms may not be zero and also not be initialized. And next, driver will use this value to calculate the timeout. So I think using an uninitialized value here doesn't make sense. If we want to use it, we have to make sure at this point, this value is already initialized.

> 
> -	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> -		host->timeout_clk = host->clock / 1000;
> +	/* timeout in us */
> +	if (!data)
> +		target_timeout = cmd->cmd_timeout_ms * 1000;
That is where I concerned about the uninitialized cmd_timeout_ms.

> +	else
> +		target_timeout = data->timeout_ns / 1000 +
> +			data->timeout_clks / host->clock;
> 
>  	/*
>  	 * Figure out needed cycles.
> @@ -632,8 +636,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host,
> struct mmc_data *data)
>  	}
> 
>  	if (count >= 0xF) {
> -		printk(KERN_WARNING "%s: Too large timeout requested!\n",
> -			mmc_hostname(host->mmc));
> +		printk(KERN_WARNING "%s: Too large timeout requested for
> CMD%d!\n",
> +		       mmc_hostname(host->mmc),
> +		       cmd->opcode);
>  		count = 0xE;
>  	}
> 
> @@ -651,15 +656,21 @@ static void sdhci_set_transfer_irqs(struct sdhci_host
> *host)
>  		sdhci_clear_set_irqs(host, dma_irqs, pio_irqs);
>  }
> 
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_data *data)
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command
> *cmd)
>  {
>  	u8 count;
>  	u8 ctrl;
> +	struct mmc_data *data = cmd->data;
>  	int ret;
> 
>  	WARN_ON(host->data);
> 
> -	if (data == NULL)
> +	if (data || (cmd->flags & MMC_RSP_BUSY)) {
> +		count = sdhci_calc_timeout(host, cmd);
> +		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +	}
> +
> +	if (!data)
>  		return;
> 
>  	/* Sanity checks */
> @@ -670,9 +681,6 @@ static void sdhci_prepare_data(struct sdhci_host *host,
> struct mmc_data *data)
>  	host->data = data;
>  	host->data_early = 0;
> 
> -	count = sdhci_calc_timeout(host, data);
> -	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> -
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
>  		host->flags |= SDHCI_REQ_USE_DMA;
> 
> @@ -920,7 +928,7 @@ static void sdhci_send_command(struct sdhci_host *host,
> struct mmc_command *cmd)
> 
>  	host->cmd = cmd;
> 
> -	sdhci_prepare_data(host, cmd->data);
> +	sdhci_prepare_data(host, cmd);
> 
>  	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> 
> @@ -1867,6 +1875,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
>  		host->timeout_clk *= 1000;
> 
> +	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> +		host->timeout_clk = host->clock / 1000;
> +
>  	/*
>  	 * Set host parameters.
>  	 */
> @@ -1879,7 +1890,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
> 
>  	mmc->f_max = host->max_clk;
> -	mmc->caps |= MMC_CAP_SDIO_IRQ;
> +	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
> 
>  	/*
>  	 * A controller may support 8-bit width, but the board itself
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
