From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 1/3] mmc: sdhci: add support for using external DMA
 devices
Date: Wed, 7 Nov 2018 16:13:40 +0200
Message-ID: <904b3126-59eb-2834-ddcd-8adba00469b0@intel.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 5/11/18 5:16 AM, Chunyan Zhang wrote:
> Some standard SD host controller can support both external dma
> controllers as well as ADMA in which the controller acts as
> DMA master.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated into
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine meaning that custom code is
> needed for any systems that use a generic DMA controller with SDHCI.

I have no object to supporting external DMA, but there are a few comments below.

> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> ---
>  drivers/mmc/host/Kconfig |  13 +++++
>  drivers/mmc/host/sdhci.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci.h |  12 +++++
>  3 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1b58739..c4745d8 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,3 +977,16 @@ config MMC_SDHCI_OMAP
>  	  If you have a controller with this interface, say Y or M here.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_EXTDMA
> +        bool "Support external DMA in standard SD host controller"
> +	depends on MMC_SDHCI
> +	depends on DMA_ENGINE
> +	help
> +	  This is an option for using external DMA device via dmaengine
> +	  framework.
> +
> +	  If you have a controller which supports using external DMA device
> +	  for data transfer, can say Y.
> +
> +	  If unsure, say N.
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 99bdae5..ffb1d2b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/ktime.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> @@ -1309,6 +1310,128 @@ static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
>  		del_timer(&host->timer);
>  }
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTDMA)
> +static int sdhci_extdma_init_chan(struct sdhci_host *host)

I would prefer "external_dma" to extdma e.g.
	CONFIG_MMC_SDHCI_EXTERNAL_DMA
	sdhci_external_dma_init
	sdhci_external_dma_channel
	sdhci_external_dma_setup
	etc


> +{
> +	int ret = 0;
> +	struct mmc_host *mmc = host->mmc;
> +	struct sdhci_extdma *dma = &host->extdma;
> +
> +	dma->tx_chan = dma_request_chan(mmc->parent, "tx");
> +	if (IS_ERR(dma->tx_chan)) {
> +		ret = PTR_ERR(dma->tx_chan);
> +		dma->tx_chan = NULL;
> +		pr_warn("Failed to request TX DMA channel.\n");
> +		return ret;
> +	}
> +
> +	dma->rx_chan = dma_request_chan(mmc->parent, "rx");
> +	if (IS_ERR(dma->rx_chan)) {
> +		ret = PTR_ERR(dma->rx_chan);
> +		if (ret == -EPROBE_DEFER && dma->tx_chan)
> +			dma_release_channel(dma->tx_chan);
> +
> +		dma->rx_chan = NULL;
> +		pr_warn("Failed to request RX DMA channel.\n");
> +	}

I guess the channels need to be released in sdhci_cleanup_host() and
sdhci_remove_host()

> +
> +	return ret;
> +}
> +
> +static inline struct dma_chan *
> +sdhci_extdma_get_chan(struct sdhci_extdma *dma, struct mmc_data *data)
> +{
> +	return data->flags & MMC_DATA_WRITE ? dma->tx_chan : dma->rx_chan;
> +}
> +
> +static int sdhci_extdma_setup(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	int ret = 0, i;
> +	struct dma_async_tx_descriptor *desc;
> +	struct mmc_data *data = cmd->data;
> +	struct dma_chan *chan;
> +	struct dma_slave_config cfg;
> +
> +	if (!host->mapbase)
> +		return -EINVAL;
> +
> +	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
> +	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.src_maxburst = data->blksz / 4;
> +	cfg.dst_maxburst = data->blksz / 4;
> +
> +	/* Sanity check: all the SG entries must be aligned by block size. */
> +	for (i = 0; i < data->sg_len; i++) {
> +		if ((data->sg + i)->length % data->blksz)
> +			return -EINVAL;
> +	}
> +
> +	chan = sdhci_extdma_get_chan(&host->extdma, data);
> +
> +	ret = dmaengine_slave_config(chan, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
> +				       mmc_get_dma_dir(data),
> +				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	desc->callback = NULL;
> +	desc->callback_param = NULL;
> +
> +	dmaengine_submit(desc);

Doesn't the DMA need to be cleaned up somewhere if there are transfer errors?

> +
> +	return 0;
> +}
> +
> +static void sdhci_extdma_prepare_data(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	host->flags |= SDHCI_REQ_USE_DMA;
> +	sdhci_prepare_data(host, cmd);
> +
> +	if (sdhci_extdma_setup(host, cmd))
> +		dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
> +}
> +
> +static void sdhci_extdma_pre_transfer(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan = sdhci_extdma_get_chan(&host->extdma, cmd->data);
> +
> +	if (cmd->opcode != MMC_SET_BLOCK_COUNT) {
> +		sdhci_set_timeout(host, cmd);
> +		dma_async_issue_pending(chan);
> +	}
> +}
> +#else
> +static int sdhci_extdma_init_chan(struct sdhci_host *host)
> +{
> +	return 0;
> +}
> +
> +static void sdhci_extdma_prepare_data(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{
> +	/* If SDHCI_EXTDMA not supported, PIO will be used */
> +	sdhci_prepare_data(host, cmd);
> +}
> +
> +static void sdhci_extdma_pre_transfer(struct sdhci_host *host,
> +				      struct mmc_command *cmd)
> +{}
> +#endif
> +
> +void sdhci_switch_extdma(struct sdhci_host *host, bool en)
> +{
> +	host->use_extdma = en;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_switch_extdma);
> +
>  void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	int flags;
> @@ -1355,7 +1478,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		host->data_cmd = cmd;
>  	}
>  
> -	sdhci_prepare_data(host, cmd);
> +	if (host->use_extdma)
> +		sdhci_extdma_prepare_data(host, cmd);
> +	else
> +		sdhci_prepare_data(host, cmd);
>  
>  	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>  
> @@ -1397,6 +1523,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		timeout += 10 * HZ;
>  	sdhci_mod_timer(host, cmd->mrq, timeout);
>  
> +	if (host->use_extdma)
> +		sdhci_extdma_pre_transfer(host, cmd);
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_command);
> @@ -4133,6 +4262,12 @@ int sdhci_setup_host(struct sdhci_host *host)
>  			return ret;
>  	}
>  
> +	if (host->use_extdma) {
> +		ret = sdhci_extdma_init_chan(host);
> +		if (ret)
> +			goto unreg;
> +	}
> +
>  	return 0;
>  
>  unreg:
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b001cf4..2d4a3ba 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -361,6 +361,12 @@ enum sdhci_cookie {
>  	COOKIE_MAPPED,		/* mapped by sdhci_prepare_data() */
>  };
>  
> +struct sdhci_extdma {
> +	struct sdhci_host	*host;
> +	struct dma_chan		*rx_chan;
> +	struct dma_chan		*tx_chan;
> +};

Is this struct really needed?  Otherwise kernel style is not to nest
structures. i.e. just put rx/tx_chan in struct sdhci_host.

> +
>  struct sdhci_host {
>  	/* Data set by hardware interface driver */
>  	const char *hw_name;	/* Hardware bus name */
> @@ -475,6 +481,7 @@ struct sdhci_host {
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> +	phys_addr_t mapbase;	/* physical address base */
>  	char *bounce_buffer;	/* For packing SDMA reads/writes */
>  	dma_addr_t bounce_addr;
>  	unsigned int bounce_buffer_size;
> @@ -524,6 +531,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool use_extdma;
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> @@ -551,6 +559,9 @@ struct sdhci_host {
>  
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTDMA)
> +	struct sdhci_extdma	extdma;	/* support external DMA */
> +#endif
>  
>  	u32 caps;		/* CAPABILITY_0 */
>  	u32 caps1;		/* CAPABILITY_1 */
> @@ -785,5 +796,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_switch_extdma(struct sdhci_host *host, bool en);
>  
>  #endif /* __SDHCI_HW_H */
> 
