Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C5C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A890320FC3
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHUOJN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:09:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:18192 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgHUOJL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:09:11 -0400
IronPort-SDR: StiXKbY20082zEYBV/3NOQlqTL9TOH2gv/1oRm6zrW8NVannRiPb5GFdvj6tPD8LVjPXyPV6j9
 ItYspp+rn2eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143173093"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143173093"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:09:10 -0700
IronPort-SDR: nfLffOHtZEWSfoU31VB811MBRjhlQkQVO61jdFiN9SRKRLr97hvekhFbnfTZxJrJwWtgrwWGB4
 Xv+Y91XGmr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="442357089"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2020 07:09:04 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 12/21] mmc: sdhci: UHS-II support, add hooks for
 additional operations
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111054.29562-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9fa17d60-a540-d0d8-7b2c-0016c3b5c532@intel.com>
Date:   Fri, 21 Aug 2020 17:08:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111054.29562-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/20 2:10 pm, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> In this commit, UHS-II related operations will be called via a function
> pointer array, sdhci_uhs2_ops, in order to make UHS-II support as
> a kernel module.
> This array will be initialized only if CONFIG_MMC_SDHCI_UHS2 is enabled
> and when the UHS-II module is loaded. Otherwise, all the functions
> stay void.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.c | 152 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 136 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aaf41954511a..5511649946b9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -32,8 +32,12 @@
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/sdio.h>
>  #include <linux/mmc/slot-gpio.h>
> +#include <linux/mmc/uhs2.h>

Ideally, we wouldn't need to use any UHS-II definitions in sdhci.c

> +#include <linux/pci.h>

And never PCI.  Please remove

>  
>  #include "sdhci.h"
> +#include "sdhci-uhs2.h"

sdhci-uhs2.h must not be included because the point of having it is to separate UHS-II from SD mode, so please remove

> +#include "sdhci-pci.h"

Also this include must be removed

>  
>  #define DRIVER_NAME "sdhci"
>  
> @@ -45,6 +49,11 @@
>  
>  #define MAX_TUNING_LOOP 40
>  
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)
> +struct sdhci_uhs2_ops sdhci_uhs2_ops;
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_ops);
> +#endif

As I mentioned in a previous patch, please add to sdhci_ops instead.

> +
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> @@ -1041,8 +1050,11 @@ EXPORT_SYMBOL_GPL(sdhci_set_data_timeout_irq);
>  
>  void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
> +	u8 count;
> +
>  	bool too_big = false;
> -	u8 count = sdhci_calc_timeout(host, cmd, &too_big);
> +
> +	count = sdhci_calc_timeout(host, cmd, &too_big);

Last 2 chunks do nothing.  Please remove

>  
>  	if (too_big &&
>  	    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
> @@ -1053,6 +1065,11 @@ void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> +
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc->flags & MMC_UHS2_SUPPORT &&
> +	    sdhci_uhs2_ops.set_timeout)
> +		sdhci_uhs2_ops.set_timeout(host);

This is the kind of thing I want to avoid.  We already have a ->set_timeout() callback.  I would suggest creating something like:

static void __uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
{
	<whatever>
}

void uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
{
	if (host->uhs2_mode)
		__uhs2_set_timeout(host, cmd);
	else
		__sdhci_set_timeout(host, cmd);
}
EXPORT_SYMBOL_GPL(uhs2_set_timeout);

Then uhs2 drivers need to set:

	.set_timeout = uhs2_set_timeout,

>  }
>  EXPORT_SYMBOL_GPL(__sdhci_set_timeout);
>  
> @@ -1191,7 +1208,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  	sdhci_set_transfer_irqs(host);
>  
> -	sdhci_set_block_info(host, data);
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc->flags & MMC_UHS2_SUPPORT &&
> +	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +		sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
> +		sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
> +	} else {
> +		sdhci_set_block_info(host, data);
> +	}

Again, this is what I want to avoid.  I would like to have 3 kinds of functions:
	- SD mode only
	- UHS-II only
	- SD functions with no UHS-II code, that can also be used by UHS-II
i.e. I don't want to mix UHS-II code and SD mode code in the same function.

I think sdhci-uhs2.c should provide a request function and a send_command function.
I would start by removing everything you may not need, and then see if you have any problems.
e.g.

void uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
{
	struct sdhci_host *host = mmc_priv(mmc);
	struct mmc_command *cmd;
	unsigned long flags;

	if (!host->uhs2_mode) {
		sdhci_request(mmc, mrq);
		return;
	}

	spin_lock_irqsave(&host->lock, flags);
	uhs2_send_command(host, cmd);
	spin_unlock_irqrestore(&host->lock, flags);
}
EXPORT_SYMBOL_GPL(uhs2_request);

For sdhci_prepare_data(), I would factor out the dma part, so

static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
{
	struct mmc_data *data = cmd->data;

	sdhci_initialize_data(host, data);

	sdhci_prepare_dma(host, data);

	sdhci_set_block_info(host, data);
}

The you could export sdhci_initialize_data() and sdhci_prepare_dma() for uhs2.

>  }
>  
>  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
> @@ -1439,6 +1463,13 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>  	u16 mode = 0;
>  	struct mmc_data *data = cmd->data;
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc->flags & MMC_UHS2_SUPPORT) {
> +		if (sdhci_uhs2_ops.set_transfer_mode)
> +			sdhci_uhs2_ops.set_transfer_mode(host, cmd);
> +		return;
> +	}
> +

Once you provide uhs2_request() and uhs2_send_command(), the transfer mode setting can be done in sdhci-uhs2.c

>  	if (data == NULL) {
>  		if (host->quirks2 &
>  			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
> @@ -1570,6 +1601,12 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
>  	else
>  		data->bytes_xfered = data->blksz * data->blocks;
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +		__sdhci_finish_mrq(host, data->mrq);
> +		return;
> +	}

At least to start with, I think it would be better to handle UHS-II cmd and data interrupts completely in sdhci-uhs2.c

> +
>  	/*
>  	 * Need to send CMD12 if -
>  	 * a) open-ended multiblock transfer not using auto CMD12 (no CMD23)
> @@ -1654,7 +1691,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  			sdhci_prepare_data(host, cmd);
>  	}
>  
> -	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> +	if (!IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
> +		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);

Not needed when instead you provide uhs2_send_command() 
>  
>  	sdhci_set_transfer_mode(host, cmd);
>  
> @@ -1699,6 +1737,17 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  	if (host->use_external_dma)
>  		sdhci_external_dma_pre_transfer(host, cmd);
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    (host->mmc->flags & MMC_UHS2_SUPPORT)) {
> +		if (sdhci_uhs2_ops.send_command)
> +			sdhci_uhs2_ops.send_command(host, cmd);
> +
> +		return true;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2))
> +		sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);

Not needed when instead you provide uhs2_send_command()

> +
>  	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
>  
>  	return true;
> @@ -1780,13 +1829,20 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> -	host->cmd = NULL;
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->mmc->flags & MMC_UHS2_SUPPORT) {
> +		if (sdhci_uhs2_ops.finish_command)
> +			sdhci_uhs2_ops.finish_command(host);
> +	} else {
> +		host->cmd = NULL;
>  
> -	if (cmd->flags & MMC_RSP_PRESENT) {
> -		if (cmd->flags & MMC_RSP_136) {
> -			sdhci_read_rsp_136(host, cmd);
> -		} else {
> -			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
> +		if (cmd->flags & MMC_RSP_PRESENT) {
> +			if (cmd->flags & MMC_RSP_136) {
> +				sdhci_read_rsp_136(host, cmd);
> +			} else {
> +				cmd->resp[0] = sdhci_readl(host,
> +							   SDHCI_RESPONSE);
> +			}

At least to start with, I think it would be better to handle UHS-II cmd and data interrupts completely in sdhci-uhs2.c

>  		}
>  	}
>  
> @@ -1809,6 +1865,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
>  			   cmd == host->data_cmd) {
>  			/* Command complete before busy is ended */
> +			host->cmd = NULL;

host->cmd is set to NULL at the start of this function, so this is not needed.

>  			return;
>  		}
>  	}
> @@ -1828,6 +1885,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  		if (!cmd->data)
>  			__sdhci_finish_mrq(host, cmd->mrq);
>  	}
> +
> +	host->cmd = NULL;

host->cmd is set to NULL at the start of this function, so this is not needed.

>  }
>  
>  static u16 sdhci_get_preset_value(struct sdhci_host *host)
> @@ -1855,6 +1914,11 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	case MMC_TIMING_MMC_HS400:
>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>  		break;
> +#if IS_ENABLED(CONFIG_MMC_SDHCI_UHS2)

Shouldn't need conditional compilation for this

> +	case MMC_TIMING_UHS2:
> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> +		break;
> +#endif
>  	default:
>  		pr_warn("%s: Invalid UHS-I mode selected\n",
>  			mmc_hostname(host->mmc));
> @@ -2095,7 +2159,6 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>  
>  		pwr |= SDHCI_POWER_ON;
> -

No white space changes mixed in please

>  		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>  
>  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> @@ -2261,6 +2324,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
>  	u8 ctrl;
> +	u16 ctrl_2;
>  
>  	if (ios->power_mode == MMC_POWER_UNDEFINED)
>  		return;
> @@ -2287,6 +2351,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		sdhci_enable_preset_value(host, false);
>  
>  	if (!ios->clock || ios->clock != host->clock) {
> +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		    ios->timing == MMC_TIMING_UHS2)
> +			host->timing = ios->timing;
> +
>  		host->ops->set_clock(host, ios->clock);
>  		host->clock = ios->clock;
>  
> @@ -2308,6 +2376,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_set_power(host, ios->power_mode, ios->vdd);
>  
> +	/* 4.0 host support */
> +	if (host->version >= SDHCI_SPEC_400) {
> +		/* UHS2 Support */
> +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		    host->mmc->flags & MMC_UHS2_SUPPORT &&
> +		    host->mmc->caps & MMC_CAP_UHS2) {
> +			if (sdhci_uhs2_ops.do_set_ios)
> +				sdhci_uhs2_ops.do_set_ios(host, ios);
> +			return;
> +		}
> +	}
> +

Please look at using existing callbacks instead, maybe creating uhs2_set_ios(), uhs2_set_clock(), uhs2_set_power()

>  	if (host->ops->platform_send_init_74_clocks)
>  		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>  
> @@ -2331,7 +2411,7 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	}
>  
>  	if (host->version >= SDHCI_SPEC_300) {
> -		u16 clk, ctrl_2;
> +		u16 clk;
>  
>  		if (!host->preset_enabled) {
>  			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> @@ -3173,11 +3253,19 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  			/* This is to force an update */
>  			host->ops->set_clock(host, host->clock);
>  
> -		/* Spec says we should do both at the same time, but Ricoh
> -		   controllers do not like that. */
> -		sdhci_do_reset(host, SDHCI_RESET_CMD);
> -		sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		    host->mmc->flags & MMC_UHS2_INITIALIZED) {
> +			if (sdhci_uhs2_ops.reset)
> +				sdhci_uhs2_ops.reset(host,
> +						     SDHCI_UHS2_SW_RESET_SD);
> +		} else {
> +			/*
> +			 * Spec says we should do both at the same time, but
> +			 * Ricoh controllers do not like that.
> +			 */
> +			sdhci_do_reset(host, SDHCI_RESET_CMD);
> +			sdhci_do_reset(host, SDHCI_RESET_DATA);
> +		}

Please look at using the existing ->reset() sdhci host op instead.

>  		host->pending_reset = false;
>  	}
>  
> @@ -3532,6 +3620,13 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  				  SDHCI_INT_BUS_POWER);
>  		sdhci_writel(host, mask, SDHCI_INT_STATUS);
>  
> +		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +		    intmask & SDHCI_INT_ERROR &&
> +		    host->mmc->flags & MMC_UHS2_SUPPORT) {
> +			if (sdhci_uhs2_ops.irq)
> +				sdhci_uhs2_ops.irq(host);
> +		}
> +

Please look at using the existing ->irq() sdhci host op instead

>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
>  			u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
>  				      SDHCI_CARD_PRESENT;
> @@ -4717,6 +4812,14 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		/* This may alter mmc->*_blk_* parameters */
>  		sdhci_allocate_bounce_buffer(host);
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    host->version >= SDHCI_SPEC_400 &&
> +	    sdhci_uhs2_ops.add_host) {
> +		ret = sdhci_uhs2_ops.add_host(host, host->caps1);
> +		if (ret)
> +			goto unreg;
> +	}
> +

I think you should look at creating uhs2_add_host() instead

>  	return 0;
>  
>  unreg:
> @@ -4738,6 +4841,8 @@ void sdhci_cleanup_host(struct sdhci_host *host)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  
> +	/* FIXME: Do we have to do some cleanup for UHS2 here? */
> +
>  	if (!IS_ERR(mmc->supply.vqmmc))
>  		regulator_disable(mmc->supply.vqmmc);
>  
> @@ -4766,6 +4871,14 @@ int __sdhci_add_host(struct sdhci_host *host)
>  		mmc->cqe_ops = NULL;
>  	}
>  
> +	if ((mmc->caps & MMC_CAP_UHS2) && !host->v4_mode) {
> +		/* host doesn't want to enable UHS2 support */
> +		mmc->caps &= ~MMC_CAP_UHS2;
> +		mmc->flags &= ~MMC_UHS2_SUPPORT;
> +
> +		/* FIXME: Do we have to do some cleanup here? */
> +	}
> +
>  	host->complete_wq = alloc_workqueue("sdhci", flags, 0);
>  	if (!host->complete_wq)
>  		return -ENOMEM;
> @@ -4812,6 +4925,9 @@ int __sdhci_add_host(struct sdhci_host *host)
>  unled:
>  	sdhci_led_unregister(host);
>  unirq:
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    sdhci_uhs2_ops.remove_host)
> +		sdhci_uhs2_ops.remove_host(host, 0);
>  	sdhci_do_reset(host, SDHCI_RESET_ALL);
>  	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
>  	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> @@ -4869,6 +4985,10 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>  
>  	sdhci_led_unregister(host);
>  
> +	if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
> +	    sdhci_uhs2_ops.remove_host)
> +		sdhci_uhs2_ops.remove_host(host, dead);
> +

I think you should look at creating uhs2_remove_host() instead

>  	if (!dead)
>  		sdhci_do_reset(host, SDHCI_RESET_ALL);
>  
> 

