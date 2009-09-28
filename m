From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [at91sam9g45] DMA driver for AC97 and MCI
Date: Mon, 28 Sep 2009 12:34:46 +0200
Message-ID: <4AC09146.4000608@visionsystems.de>
References: <4ABCBD32.7080408@visionsystems.de> <4ABCE36F.1000205@atmel.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4ABCE36F.1000205@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

>> I try to get sound and SD card working on at91sam9g45-ekes development
>> board using linux-next tree. As far as I understand AT_HDMAC is the
>> appropriate DMA driver for ARCH_AT91SAM9G45.
> 
> Correct.
> 
>> I resolved dependencies with this patch, so I could activate it for
>> my platform.
>>
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -48,7 +48,7 @@ config DW_DMAC
>>
>>  config AT_HDMAC
>>         tristate "Atmel AHB DMA support"
>> -       depends on ARCH_AT91SAM9RL
>> +       depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45
>>         select DMA_ENGINE
>>         help
>>           Support the Atmel AHB DMA controller.  This can be integrated in
> 
> Well, this patch was waiting for this other to reach mainline:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5621/1
> 
> It is true that you will need it.
> 
>> Should this driver be also used for sound driver and MCI?
> 
> Sure. For sound, maybe we will have to conform to the dma cyclic API
> introduced by dw_dmac driver.
> 
> For MCI, here is a patch series that goes before the patch that will do
> the link between atmel_mci, at_hdmac and at91sam9g45.
> 
> http://lkml.org/lkml/2009/9/17/224
> 
> This last patch is not posted to the mailing list yet, I am waiting for
> the others to reach mainline.
> 
> I you are interested in it, you can have a preview here:
> ftp://ftp.linux4sam.org/devel/linux/2630_lnx4sam_patchset-tmp_20090828.tgz
> patch named :
> "at91/atmel-mci: inclusion of sd/mmc driver in at91sam9g45 chip and
> board" aka:
> 2630_lnx4sam_patchset-tmp/2.6.30-at91-exp-0033-at91-atmel-mci-inclusion-of-sd-mmc-driver-in-at91sa.patch

Thanks for the patches. I could get the stuff working. I applied 

2.6.30-at91-exp-0031-atmel-mci-change-use-of-dma-slave-interface.patch
2.6.30-at91-exp-0032-mmc-atmel-mci-New-MCI2-module-support-in-atmel-mci.patch
2.6.30-at91-exp-0033-at91-atmel-mci-inclusion-of-sd-mmc-driver-in-at91sa.patch

to Linus tree (2.6.32-rc2)

As to 2.6.30-at91-exp-0033-at91-atmel-mci-inclusion-of-sd-mmc-driver-in-at91sa.patch I've only changed
DW_DMA_SLAVE_WIDTH_32BIT to AT_DMA_SLAVE_WIDTH_32BIT

I couldn't apply 2.6.30-at91-exp-0032-mmc-atmel-mci-New-MCI2-module-support-in-atmel-mci.patch with quilt at once, so I had to make it manually. Here is applicable version:

>From db778d85fe91649735f0fb23fa1088fee745f0ec Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Fri, 21 Aug 2009 18:23:30 +0200
Subject: [PATCH 32/47] mmc: atmel-mci: New MCI2 module support in atmel-mci driver

This new revision of the IP adds some improvements to the MCI already present
in several Atmel SOC.
Some new registers are added and a particular way of handling DMA interaction
lead to a new sequence in function call which is backward compatible: On MCI2,
we must set the DMAEN bit to enable the DMA handshaking interface. This must
happen before the data transfer command is sent.

A new function is able to differentiate MCI2 code and is based on knowledge of
processor id (cpu_is_xxx()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |   85 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 75 insertions(+), 10 deletions(-)

Index: linus2/drivers/mmc/host/atmel-mci.c
===================================================================
--- linus2.orig/drivers/mmc/host/atmel-mci.c
+++ linus2/drivers/mmc/host/atmel-mci.c
@@ -92,6 +92,7 @@ struct atmel_mci_dma {
  * @need_clock_update: Update the clock rate before the next request.
  * @need_reset: Reset controller before next request.
  * @mode_reg: Value of the MR register.
+ * @cfg_reg: Value of the CFG register.
  * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
  *	rate and timeout calculations.
  * @mapbase: Physical address of the MMIO registers.
@@ -155,6 +156,7 @@ struct atmel_mci {
 	bool			need_clock_update;
 	bool			need_reset;
 	u32			mode_reg;
+	u32			cfg_reg;
 	unsigned long		bus_hz;
 	unsigned long		mapbase;
 	struct clk		*mck;
@@ -223,6 +225,19 @@ static bool mci_has_rwproof(void)
 }
 
 /*
+ * The new MCI2 module isn't 100% compatible with the old MCI module,
+ * and it has a few nice features which we want to use...
+ */
+static inline bool atmci_is_mci2(void)
+{
+	if (cpu_is_at91sam9g45())
+		return true;
+
+	return false;
+}
+
+
+/*
  * The debugfs stuff below is mostly optimized away when
  * CONFIG_DEBUG_FS is not set.
  */
@@ -357,12 +372,33 @@ static int atmci_regs_show(struct seq_fi
 			buf[MCI_BLKR / 4],
 			buf[MCI_BLKR / 4] & 0xffff,
 			(buf[MCI_BLKR / 4] >> 16) & 0xffff);
+	if (atmci_is_mci2())
+		seq_printf(s, "CSTOR:\t0x%08x\n", buf[MCI_CSTOR / 4]);
 
 	/* Don't read RSPR and RDR; it will consume the data there */
 
 	atmci_show_status_reg(s, "SR", buf[MCI_SR / 4]);
 	atmci_show_status_reg(s, "IMR", buf[MCI_IMR / 4]);
 
+	if (atmci_is_mci2()) {
+		u32 val;
+
+		val = buf[MCI_DMA / 4];
+		seq_printf(s, "DMA:\t0x%08x OFFSET=%u CHKSIZE=%u%s\n",
+				val, val & 3,
+				((val >> 4) & 3) ?
+					1 << (((val >> 4) & 3) + 1) : 1,
+				val & MCI_DMAEN ? " DMAEN" : "");
+
+		val = buf[MCI_CFG / 4];
+		seq_printf(s, "CFG:\t0x%08x%s%s%s%s\n",
+				val,
+				val & MCI_CFG_FIFOMODE_1DATA ? " FIFOMODE_ONE_DATA" : "",
+				val & MCI_CFG_FERRCTRL_COR ? " FERRCTRL_CLEAR_ON_READ" : "",
+				val & MCI_CFG_HSMODE ? " HSMODE" : "",
+				val & MCI_CFG_LSYNC ? " LSYNC" : "");
+	}
+
 	kfree(buf);
 
 	return 0;
@@ -557,6 +593,10 @@ static void atmci_dma_complete(void *arg
 
 	dev_vdbg(&host->pdev->dev, "DMA complete\n");
 
+	if (atmci_is_mci2())
+		/* Disable DMA hardware handshaking on MCI */
+		mci_writel(host, DMA, mci_readl(host, DMA) & ~MCI_DMAEN);
+
 	atmci_dma_cleanup(host);
 
 	/*
@@ -592,7 +632,7 @@ static void atmci_dma_complete(void *arg
 }
 
 static int
-atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
+atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	struct dma_chan			*chan;
 	struct dma_async_tx_descriptor	*desc;
@@ -624,6 +664,9 @@ atmci_submit_data_dma(struct atmel_mci *
 	if (!chan)
 		return -ENODEV;
 
+	if (atmci_is_mci2())
+		mci_writel(host, DMA, MCI_DMA_CHKSIZE(3) | MCI_DMAEN);
+
 	if (data->flags & MMC_DATA_READ)
 		direction = DMA_FROM_DEVICE;
 	else
@@ -641,10 +684,6 @@ atmci_submit_data_dma(struct atmel_mci *
 	host->dma.data_desc = desc;
 	desc->callback = atmci_dma_complete;
 	desc->callback_param = host;
-	desc->tx_submit(desc);
-
-	/* Go! */
-	chan->device->device_issue_pending(chan);
 
 	return 0;
 unmap_exit:
@@ -652,13 +691,27 @@ unmap_exit:
 	return -ENOMEM;
 }
 
+static void atmci_submit_data(struct atmel_mci *host)
+{
+	struct dma_chan			*chan = host->data_chan;
+	struct dma_async_tx_descriptor	*desc = host->dma.data_desc;
+
+	if (chan) {
+		desc->tx_submit(desc);
+		chan->device->device_issue_pending(chan);
+	}
+}
+
 #else /* CONFIG_MMC_ATMELMCI_DMA */
 
-static int atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
+static int atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
 {
 	return -ENOSYS;
 }
 
+static void atmci_submit_data(struct atmel_mci *host) {}
+
+
 static void atmci_stop_dma(struct atmel_mci *host)
 {
 	/* Data transfer was stopped by the interrupt handler */
@@ -672,7 +725,7 @@ static void atmci_stop_dma(struct atmel_
  * Returns a mask of interrupt flags to be enabled after the whole
  * request has been prepared.
  */
-static u32 atmci_submit_data(struct atmel_mci *host, struct mmc_data *data)
+static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 {
 	u32 iflags;
 
@@ -683,7 +736,7 @@ static u32 atmci_submit_data(struct atme
 	host->data = data;
 
 	iflags = ATMCI_DATA_ERROR_FLAGS;
-	if (atmci_submit_data_dma(host, data)) {
+	if (atmci_prepare_data_dma(host, data)) {
 		host->data_chan = NULL;
 
 		/*
@@ -729,6 +782,8 @@ static void atmci_start_request(struct a
 		mci_writel(host, CR, MCI_CR_SWRST);
 		mci_writel(host, CR, MCI_CR_MCIEN);
 		mci_writel(host, MR, host->mode_reg);
+		if (atmci_is_mci2())
+			mci_writel(host, CFG, host->cfg_reg);
 		host->need_reset = false;
 	}
 	mci_writel(host, SDCR, slot->sdc_reg);
@@ -744,6 +799,7 @@ static void atmci_start_request(struct a
 		while (!(mci_readl(host, SR) & MCI_CMDRDY))
 			cpu_relax();
 	}
+	iflags = 0;
 	data = mrq->data;
 	if (data) {
 		atmci_set_timeout(host, slot, data);
@@ -753,15 +809,17 @@ static void atmci_start_request(struct a
 				| MCI_BLKLEN(data->blksz));
 		dev_vdbg(&slot->mmc->class_dev, "BLKR=0x%08x\n",
 			MCI_BCNT(data->blocks) | MCI_BLKLEN(data->blksz));
+
+		iflags |= atmci_prepare_data(host, data);
 	}
 
-	iflags = MCI_CMDRDY;
+	iflags |= MCI_CMDRDY;
 	cmd = mrq->cmd;
 	cmdflags = atmci_prepare_command(slot->mmc, cmd);
 	atmci_start_command(host, cmd, cmdflags);
 
 	if (data)
-		iflags |= atmci_submit_data(host, data);
+		atmci_submit_data(host);
 
 	if (mrq->stop) {
 		host->stop_cmdr = atmci_prepare_command(slot->mmc, mrq->stop);
@@ -857,6 +915,8 @@ static void atmci_set_ios(struct mmc_hos
 			clk_enable(host->mck);
 			mci_writel(host, CR, MCI_CR_SWRST);
 			mci_writel(host, CR, MCI_CR_MCIEN);
+			if (atmci_is_mci2())
+				mci_writel(host, CFG, host->cfg_reg);
 		}
 
 		/*
@@ -1095,6 +1155,8 @@ static void atmci_detect_change(unsigned
 				mci_writel(host, CR, MCI_CR_SWRST);
 				mci_writel(host, CR, MCI_CR_MCIEN);
 				mci_writel(host, MR, host->mode_reg);
+				if (atmci_is_mci2())
+					mci_writel(host, CFG, host->cfg_reg);
 
 				host->data = NULL;
 				host->cmd = NULL;
@@ -1644,6 +1706,10 @@ static void atmci_configure_dma(struct a
 	}
 	if (!host->dma.chan)
 		dev_notice(&host->pdev->dev, "DMA not available, using PIO\n");
+	else
+		dev_info(&host->pdev->dev,
+					"Using %s for DMA transfers\n",
+					dma_chan_name(host->dma.chan));
 }
 #else
 static void atmci_configure_dma(struct atmel_mci *host) {}


Best regards,
Yegor Yefremov
