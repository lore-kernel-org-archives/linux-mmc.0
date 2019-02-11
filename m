From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/7] mmc: sdhci: add support for using external DMA
 devices
Date: Mon, 11 Feb 2019 17:53:57 +0530
Message-ID: <00acd303-b3fa-f083-0412-0aa121a5394d@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
 <20190111110851.6805-2-faiz_abbas@ti.com>
 <bcea7bae-41c8-358a-11c1-3886f9dc0351@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bcea7bae-41c8-358a-11c1-3886f9dc0351@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: zhang.chunyan@linaro.org, kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On 24/01/19 5:10 PM, Adrian Hunter wrote:
> On 11/01/19 1:08 PM, Faiz Abbas wrote:
>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>
>> Some standard SD host controllers can support both external dma
>> controllers as well as ADMA/SDMA in which the SD host controller
>> acts as DMA master. TI's omap controller is the case as an example.
>>
>> Currently the generic SDHCI code supports ADMA/SDMA integrated in
>> the host controller but does not have any support for external DMA
>> controllers implemented using dmaengine, meaning that custom code is
>> needed for any systems that use an external DMA controller with SDHCI.
>>
>> Fixes by Faiz Abbas <faiz_abbas@ti.com>:
>> 1. Map scatterlists before dmaengine_prep_slave_sg()
>> 2. Use dma_async() functions inside of the send_command() path and
>> synchronize once at the start of each request.
> 
> Sorry for the slow reply, but I do have some concerns.  Please see the comments.
>[snip]>>  	/*
>>  	 * Ensure we don't send the STOP for non-SET_BLOCK_COUNTED
>>  	 * requests if Auto-CMD12 is enabled.
>> @@ -2658,6 +2890,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
>>  				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
>>  					     data->sg_len,
>>  					     mmc_get_dma_dir(data));
>> +				if (host->use_external_dma)
>> +					sdhci_external_dma_cleanup(host, data);
> 
> Is sdhci_external_dma_cleanup() only needed in the error case?
> 
> The DMA must be stopped before the memory is unmapped and potentially freed.
> 
> Isn't the DMA cleanup also needed in the bounce buffer case?
> 
> Isn't the DMA cleanup also needed in the COOKIE_PRE_MAPPED case?
> 
> dmaengine_terminate_async() doesn't stop the DMA but
> dmaengine_terminate_sync() is not atomic, which looks like a problem.
> 
> Perhaps you look at scheduling some work for the external dma error case
> instead of calling __sdhci_finish_mrq()?  Then the work can do the
> dmaengine_terminate_sync() and call __sdhci_finish_mrq().
> 

Why don't we get rid of the finish_tasklet and use the already existing
threaded_irq for everything? I tested the following patch out and it
seems to work well. This enables us to just call
dmaengine_terminate_sync() in sdhci_request_done().

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a22e11a65658..beff2ac2dee5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1232,7 +1232,7 @@ static void __sdhci_finish_mrq(struct sdhci_host
*host, struct mmc_request *mrq)

 	WARN_ON(i >= SDHCI_MAX_MRQS);

-	tasklet_schedule(&host->finish_tasklet);
+	host->threaded_irq_needed = true;
 }

 static void sdhci_finish_mrq(struct sdhci_host *host, struct
mmc_request *mrq)
@@ -2705,14 +2705,6 @@ static bool sdhci_request_done(struct sdhci_host
*host)
 	return false;
 }

-static void sdhci_tasklet_finish(unsigned long param)
-{
-	struct sdhci_host *host = (struct sdhci_host *)param;
-
-	while (!sdhci_request_done(host))
-		;
-}
-
 static void sdhci_timeout_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
@@ -3000,6 +2992,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	u32 intmask, mask, unexpected = 0;
 	int max_loops = 16;

+	host->threaded_irq_needed = false;
+
 	spin_lock(&host->lock);

 	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
@@ -3077,6 +3071,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			result = IRQ_WAKE_THREAD;
 		}

+		if (host->threaded_irq_needed)
+			result = IRQ_WAKE_THREAD;
+
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
 			     SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
 			     SDHCI_INT_ERROR | SDHCI_INT_BUS_POWER |
@@ -3131,6 +3128,10 @@ static irqreturn_t sdhci_thread_irq(int irq, void
*dev_id)
 		spin_unlock_irqrestore(&host->lock, flags);
 	}

+	do {
+		isr = sdhci_request_done(host);
+	} while(isr);
+
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }

@@ -4211,12 +4212,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;

-	/*
-	 * Init tasklets.
-	 */
-	tasklet_init(&host->finish_tasklet,
-		sdhci_tasklet_finish, (unsigned long)host);
-
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);

@@ -4229,7 +4224,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
-		goto untasklet;
+		return ret;
 	}

 	ret = sdhci_led_register(host);
@@ -4262,8 +4257,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
-untasklet:
-	tasklet_kill(&host->finish_tasklet);

 	return ret;
 }
@@ -4325,8 +4318,6 @@ void sdhci_remove_host(struct sdhci_host *host,
int dead)
 	del_timer_sync(&host->timer);
 	del_timer_sync(&host->data_timer);

-	tasklet_kill(&host->finish_tasklet);
-
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..abf4f77650b5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -554,7 +554,7 @@ struct sdhci_host {

 	unsigned int desc_sz;	/* ADMA descriptor size */

-	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
+	bool threaded_irq_needed;

 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */

Thanks,
Faiz
