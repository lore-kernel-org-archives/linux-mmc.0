Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4361C2D0C9
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F0424671
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfLLM4Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:56:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:10104 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbfLLM4Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Dec 2019 07:56:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 04:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="388303860"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.169]) ([10.237.72.169])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2019 04:56:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/7] mmc: sdhci: add support for using external DMA
 devices
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org, zhang.chunyan@linaro.org, tony@atomide.com
References: <20191210095151.15441-1-faiz_abbas@ti.com>
 <20191210095151.15441-3-faiz_abbas@ti.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <92fd22bf-3024-928d-ebf5-e7382988a36b@intel.com>
Date:   Thu, 12 Dec 2019 14:55:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210095151.15441-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/12/19 11:51 am, Faiz Abbas wrote:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> 
> Some standard SD host controllers can support both external dma
> controllers as well as ADMA/SDMA in which the SD host controller
> acts as DMA master. TI's omap controller is the case as an example.
> 
> Currently the generic SDHCI code supports ADMA/SDMA integrated in
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine, meaning that custom code is
> needed for any systems that use an external DMA controller with SDHCI.
> 
> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
> 1. Map scatterlists before dmaengine_prep_slave_sg()
> 2. Use dma_async() functions inside of the send_command() path and call
> terminate_sync() in non-atomic context in case of an error.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/Kconfig |   3 +
>  drivers/mmc/host/sdhci.c | 285 +++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci.h |   8 ++
>  3 files changed, 268 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c467bf..66ba8daa1cbe 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1019,3 +1019,6 @@ config MMC_SDHCI_AM654
>  	  If you have a controller with this interface, say Y or M here.
>  
>  	  If unsure, say N.
> +
> +config MMC_SDHCI_EXTERNAL_DMA
> +        bool
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b056400e34b1..6f3d4991bee1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -10,6 +10,7 @@
>   */
>  
>  #include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/ktime.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> @@ -30,6 +31,7 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/workqueue.h>

This is unrelated and should be a separate patch.

>  
>  #include "sdhci.h"
>  
> @@ -1014,18 +1016,9 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +static inline void sdhci_reset_data(struct sdhci_host *host,

'inline' is not necessary

'sdhci_reset_data' is too much like SDHCI_RESET_DATA.  Maybe 'sdhci_set_data'

Please make the factoring out of sdhci_reset_data and sdhci_set_block_info a
separate patch

> +				    struct mmc_data *data)
>  {
> -	struct mmc_data *data = cmd->data;
> -
> -	host->data_timeout = 0;
> -
> -	if (sdhci_data_line_cmd(cmd))
> -		sdhci_set_timeout(host, cmd);
> -
> -	if (!data)
> -		return;
> -
>  	WARN_ON(host->data);
>  
>  	/* Sanity checks */
> @@ -1036,6 +1029,34 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  	host->data = data;
>  	host->data_early = 0;
>  	host->data->bytes_xfered = 0;
> +}
> +
> +static inline void sdhci_set_block_info(struct sdhci_host *host)

'inline' is not necessary

Please add 'data' as a parameter like sdhci_reset_data.

> +{
> +
> +	/* Set the DMA boundary value and block size */
> +	sdhci_writew(host,
> +		     SDHCI_MAKE_BLKSZ(host->sdma_boundary, host->data->blksz),
> +		     SDHCI_BLOCK_SIZE);
> +	/*
> +	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
> +	 * can be supported, in that case 16-bit block count register must be 0.
> +	 */
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
> +		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> +			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> +		sdhci_writew(host, host->data->blocks, SDHCI_32BIT_BLK_CNT);
> +	} else {
> +		sdhci_writew(host, host->data->blocks, SDHCI_BLOCK_COUNT);
> +	}
> +}
> +
> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_reset_data(host, data);
>  
>  	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>  		struct scatterlist *sg;
> @@ -1122,24 +1143,186 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  	sdhci_set_transfer_irqs(host);
>  
> -	/* Set the DMA boundary value and block size */
> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
> -		     SDHCI_BLOCK_SIZE);
> +	sdhci_set_block_info(host);
> +}
>  
> -	/*
> -	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
> -	 * can be supported, in that case 16-bit block count register must be 0.
> -	 */
> -	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> -	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
> -		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
> -			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
> -		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)

Please add blank line

> +static int sdhci_external_dma_init(struct sdhci_host *host)
> +{
> +	int ret = 0;
> +	struct mmc_host *mmc = host->mmc;
> +
> +	host->tx_chan = dma_request_chan(mmc->parent, "tx");
> +	if (IS_ERR(host->tx_chan)) {
> +		ret = PTR_ERR(host->tx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			pr_warn("Failed to request TX DMA channel.\n");
> +		host->tx_chan = NULL;
> +		return ret;
> +	}
> +
> +	host->rx_chan = dma_request_chan(mmc->parent, "rx");
> +	if (IS_ERR(host->rx_chan)) {
> +		if (host->tx_chan) {
> +			dma_release_channel(host->tx_chan);
> +			host->tx_chan = NULL;
> +		}
> +
> +		ret = PTR_ERR(host->rx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			pr_warn("Failed to request RX DMA channel.\n");
> +		host->rx_chan = NULL;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline struct dma_chan *

My preference is not to wrap this line

> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
> +{
> +	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
> +}
> +
> +static int sdhci_external_dma_setup(struct sdhci_host *host,
> +				    struct mmc_command *cmd)
> +{
> +	int ret, i;
> +	struct dma_async_tx_descriptor *desc;
> +	struct mmc_data *data = cmd->data;
> +	struct dma_chan *chan;
> +	struct dma_slave_config cfg;
> +	dma_cookie_t cookie;
> +	int sg_cnt;
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
> +	chan = sdhci_external_dma_channel(host, data);
> +
> +	ret = dmaengine_slave_config(chan, &cfg);
> +	if (ret)
> +		return ret;
> +
> +	sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
> +	if (sg_cnt <= 0)
> +		return -EINVAL;
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
> +	cookie = dmaengine_submit(desc);
> +	if (cookie < 0)
> +		ret = cookie;
> +
> +	return ret;
> +}
> +
> +static void sdhci_external_dma_release(struct sdhci_host *host)
> +{
> +	if (host->tx_chan) {
> +		dma_release_channel(host->tx_chan);
> +		host->tx_chan = NULL;
> +	}
> +
> +	if (host->rx_chan) {
> +		dma_release_channel(host->rx_chan);
> +		host->rx_chan = NULL;
> +	}
> +
> +	sdhci_switch_external_dma(host, false);
> +}
> +
> +static void __sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					      struct mmc_command *cmd)
> +{
> +	struct mmc_data *data = cmd->data;
> +
> +	sdhci_reset_data(host, data);
> +
> +	host->flags |= SDHCI_REQ_USE_DMA;
> +	sdhci_set_transfer_irqs(host);
> +
> +	sdhci_set_block_info(host);
> +}
> +
> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	if (!sdhci_external_dma_setup(host, cmd)) {
> +		__sdhci_external_dma_prepare_data(host, cmd);
>  	} else {
> -		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
> +		sdhci_external_dma_release(host);
> +		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
> +		       mmc_hostname(host->mmc));
> +		sdhci_prepare_data(host, cmd);
>  	}
>  }
>  
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	struct dma_chan *chan;
> +
> +	if (!cmd->data)
> +		return;
> +
> +	chan = sdhci_external_dma_channel(host, cmd->data);
> +	if (chan)
> +		dma_async_issue_pending(chan);
> +}
> +
> +#else

Please add blank line

> +static int sdhci_external_dma_init(struct sdhci_host *host)

This and 4 below can be inline

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void sdhci_external_dma_release(struct sdhci_host *host)
> +{}

{
}

> +
> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{
> +	/* If MMC_SDHCI_EXTERNAL_DMA not supported, PIO will be used */

Isn't this actually unreachable?  Maybe WARN_ON_ONCE would be better.

> +	sdhci_prepare_data(host, cmd);
> +}
> +
> +static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
> +					    struct mmc_command *cmd)
> +{}

{
}

> +
> +static inline struct dma_chan *

My preference is not to wrap this line

> +sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
> +{
> +	return NULL;
> +}

Please add blank line

> +#endif
> +
> +void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
> +{
> +	host->use_external_dma = en;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
> +
>  static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  				    struct mmc_request *mrq)
>  {
> @@ -1379,12 +1562,19 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	host->cmd = cmd;
> +	host->data_timeout = 0;
>  	if (sdhci_data_line_cmd(cmd)) {
>  		WARN_ON(host->data_cmd);
>  		host->data_cmd = cmd;
> +		sdhci_set_timeout(host, cmd);
>  	}
>  
> -	sdhci_prepare_data(host, cmd);
> +	if (cmd->data) {
> +		if (host->use_external_dma)
> +			sdhci_external_dma_prepare_data(host, cmd);
> +		else
> +			sdhci_prepare_data(host, cmd);
> +	}

Please make the 3 changes above and the corresponding changes
sdhci_prepare_data into a separate patch i.e.

 	host->cmd = cmd;
+	host->data_timeout = 0;
 	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
 		host->data_cmd = cmd;
+		sdhci_set_timeout(host, cmd);
 	}

-	sdhci_prepare_data(host, cmd);
+	if (cmd->data)
		sdhci_prepare_data(host, cmd);

>  
>  	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>  
> @@ -1426,6 +1616,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		timeout += 10 * HZ;
>  	sdhci_mod_timer(host, cmd->mrq, timeout);
>  
> +	if (host->use_external_dma)
> +		sdhci_external_dma_pre_transfer(host, cmd);
> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_send_command);
> @@ -2652,6 +2845,18 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  	if (host->flags & SDHCI_REQ_USE_DMA) {
>  		struct mmc_data *data = mrq->data;
>  
> +		spin_unlock_irqrestore(&host->lock, flags);
> +
> +		/* Terminate and synchronize dma in case of an error */
> +		if (data && (mrq->cmd->error || data->error) &&
> +		    host->use_external_dma) {
> +			struct dma_chan *chan = sdhci_external_dma_channel(host,
> +									  data);
> +			dmaengine_terminate_sync(chan);
> +		}
> +
> +		spin_lock_irqsave(&host->lock, flags);
> +

Need to take the mrq out of mrqs_done[] to ensure it is not processed again,
and put it back again to be consistent with the remaining code. Also put
host->use_external_dma as the first condition i.e.

		if (host->use_external_dma && data &&
		    (mrq->cmd->error || data->error)) {
			struct dma_chan *chan = sdhci_external_dma_channel(host, data);

			host->mrqs_done[i] = NULL;
			spin_unlock_irqrestore(&host->lock, flags);
			dmaengine_terminate_sync(chan);
			spin_lock_irqsave(&host->lock, flags);
			sdhci_set_mrq_done(host, mrq);
		}

where sdhci_set_mrq_done() is factored out from __sdhci_finish_mrq() i.e.

static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
{
	int i;

	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
		if (host->mrqs_done[i] == mrq) {
			WARN_ON(1);
			return;
		}
	}

	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
		if (!host->mrqs_done[i]) {
			host->mrqs_done[i] = mrq;
			break;
		}
	}

	WARN_ON(i >= SDHCI_MAX_MRQS);
}

sdhci_set_mrq_done() can be made in the refactoring patch.

>  		if (data && data->host_cookie == COOKIE_MAPPED) {
>  			if (host->bounce_buffer) {
>  				/*
> @@ -3758,12 +3963,28 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		       mmc_hostname(mmc), host->version);
>  	}
>  
> -	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> +	if (host->use_external_dma) {
> +		ret = sdhci_external_dma_init(host);
> +		if (ret == -EPROBE_DEFER)
> +			goto unreg;
> +
> +		/*
> +		 * Fall back to use the DMA/PIO integrated in standard SDHCI
> +		 * instead of external DMA devices.
> +		 */
> +		if (ret)
> +			sdhci_switch_external_dma(host, false);
> +	}
> +
> +	if (host->quirks & SDHCI_QUIRK_FORCE_DMA) {
>  		host->flags |= SDHCI_USE_SDMA;
> -	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
> +	} else if (!(host->caps & SDHCI_CAN_DO_SDMA)) {
>  		DBG("Controller doesn't have SDMA capability\n");
> -	else
> +	} else if (host->use_external_dma) {
> +		/* Using dma-names to detect external dma capability */

What is this change for?  Do you expect for SDHCI_USE_SDMA and
SDHCI_USE_ADMA flags to be clear?

> +	} else {
>  		host->flags |= SDHCI_USE_SDMA;
> +	}
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_DMA) &&
>  		(host->flags & SDHCI_USE_SDMA)) {
> @@ -4264,6 +4485,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>  		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
>  				  host->adma_table_sz, host->align_buffer,
>  				  host->align_addr);
> +
> +	if (host->use_external_dma)
> +		sdhci_external_dma_release(host);
> +
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
>  }
> @@ -4309,6 +4534,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  
>  	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>  		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
> +		host->use_external_dma ? "External DMA" :
>  		(host->flags & SDHCI_USE_ADMA) ?
>  		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
>  		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
> @@ -4397,6 +4623,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  				  host->adma_table_sz, host->align_buffer,
>  				  host->align_addr);
>  
> +	if (host->use_external_dma)
> +		sdhci_external_dma_release(host);
> +
>  	host->adma_table = NULL;
>  	host->align_buffer = NULL;
>  }
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0ed3e0eaef5f..b28706a1bc6f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -485,6 +485,7 @@ struct sdhci_host {
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> +	phys_addr_t mapbase;	/* physical address base */
>  	char *bounce_buffer;	/* For packing SDMA reads/writes */
>  	dma_addr_t bounce_addr;
>  	unsigned int bounce_buffer_size;
> @@ -533,6 +534,7 @@ struct sdhci_host {
>  	bool pending_reset;	/* Cmd/data reset is pending */
>  	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
>  	bool v4_mode;		/* Host Version 4 Enable */
> +	bool use_external_dma;	/* Host selects to use external DMA */
>  
>  	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
>  	struct mmc_command *cmd;	/* Current command */
> @@ -562,6 +564,11 @@ struct sdhci_host {
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> +	struct dma_chan	*rx_chan;
> +	struct dma_chan	*tx_chan;
> +#endif
> +
>  	u32 caps;		/* CAPABILITY_0 */
>  	u32 caps1;		/* CAPABILITY_1 */
>  	bool read_caps;		/* Capability flags have been read */
> @@ -793,5 +800,6 @@ void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
>  void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
>  
>  #endif /* __SDHCI_HW_H */
> 

