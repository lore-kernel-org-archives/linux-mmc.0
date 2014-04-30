From: Ian Molton <ian.molton@codethink.co.uk>
Subject: [PATCH 1/6] mmc: TMIO: Refactor driver core probe function
Date: Wed, 30 Apr 2014 17:59:06 +0100
Message-ID: <1398877151-6965-2-git-send-email-ian.molton@codethink.co.uk>
References: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47905 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:27 -0400
In-Reply-To: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net, Ian Molton <ian.molton@codethink.co.uk>

	Refactor to remove a return by reference.

Reviewed-by: Violeta Menendez <violeta.menendez@codethink.co.uk>
Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   8 ++-
 drivers/mmc/host/tmio_mmc.c       |   8 ++-
 drivers/mmc/host/tmio_mmc.h       |   4 +-
 drivers/mmc/host/tmio_mmc_pio.c   | 106 ++++++++++++++++++++------------------
 4 files changed, 73 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 91058da..02c1cc3 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -233,7 +233,13 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
 	mmc_data->bus_shift = resource_size(res) >> 9;
 
-	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
+	host = tmio_mmc_alloc_host(pdev, mmc_data);
+	if (!host) {
+		ret = -ENOMEM;
+		goto eprobe;
+	}
+
+	ret = tmio_mmc_host_probe(host);
 	if (ret < 0)
 		goto eprobe;
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index cfad844..bf6252c 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -92,7 +92,13 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	pdata->bus_shift = resource_size(res) >> 10;
 	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
 
-	ret = tmio_mmc_host_probe(&host, pdev, pdata);
+	host = tmio_mmc_alloc_host(pdev, pdata);
+	if (!host) {
+		ret = -ENOMEM;
+		goto cell_disable;
+	}
+
+	ret = tmio_mmc_host_probe(host);
 	if (ret)
 		goto cell_disable;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 100ffe0..42894b7 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -103,8 +103,8 @@ struct tmio_mmc_host {
 	bool			resuming;
 };
 
-int tmio_mmc_host_probe(struct tmio_mmc_host **host,
-			struct platform_device *pdev,
+int tmio_mmc_host_probe(struct tmio_mmc_host *host);
+struct tmio_mmc_host *tmio_mmc_alloc_host(struct platform_device *pdev,
 			struct tmio_mmc_data *pdata);
 void tmio_mmc_host_remove(struct tmio_mmc_host *host);
 void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index faf0924..7db9310 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -970,49 +970,59 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
 		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
 }
 
-int tmio_mmc_host_probe(struct tmio_mmc_host **host,
-				  struct platform_device *pdev,
-				  struct tmio_mmc_data *pdata)
+struct tmio_mmc_host *tmio_mmc_alloc_host(struct platform_device *pdev,
+		struct tmio_mmc_data *pdata)
 {
-	struct tmio_mmc_host *_host;
+	struct tmio_mmc_host *host;
 	struct mmc_host *mmc;
+
+	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
+	if (!mmc)
+		return NULL;
+
+	pdata->dev = &pdev->dev;
+
+	host = mmc_priv(mmc);
+	host->pdata = pdata;
+	host->mmc = mmc;
+	host->pdev = pdev;
+
+	platform_set_drvdata(pdev, mmc);
+
+	return host;
+}
+
+int tmio_mmc_host_probe(struct tmio_mmc_host *host)
+{
+	struct mmc_host *mmc = host->mmc;
+	struct tmio_mmc_data *pdata = host->pdata;
+	struct device *dev = &host->pdev->dev;
 	struct resource *res_ctl;
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
-	tmio_mmc_of_parse(pdev, pdata);
+	tmio_mmc_of_parse(host->pdev, pdata);
 
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		pdata->write16_hook = NULL;
 
-	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res_ctl = platform_get_resource(host->pdev, IORESOURCE_MEM, 0);
 	if (!res_ctl)
 		return -EINVAL;
 
-	mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
-	if (!mmc)
-		return -ENOMEM;
-
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
 		goto host_free;
 
-	pdata->dev = &pdev->dev;
-	_host = mmc_priv(mmc);
-	_host->pdata = pdata;
-	_host->mmc = mmc;
-	_host->pdev = pdev;
-	platform_set_drvdata(pdev, mmc);
-
-	_host->set_pwr = pdata->set_pwr;
-	_host->set_clk_div = pdata->set_clk_div;
+	host->set_pwr = pdata->set_pwr;
+	host->set_clk_div = pdata->set_clk_div;
 
-	ret = tmio_mmc_init_ocr(_host);
+	ret = tmio_mmc_init_ocr(host);
 	if (ret < 0)
 		goto host_free;
 
-	_host->ctl = ioremap(res_ctl->start, resource_size(res_ctl));
-	if (!_host->ctl) {
+	host->ctl = ioremap(res_ctl->start, resource_size(res_ctl));
+	if (!host->ctl) {
 		ret = -ENOMEM;
 		goto host_free;
 	}
@@ -1027,14 +1037,14 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
+	host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  mmc->caps & MMC_CAP_NONREMOVABLE ||
 				  mmc->slot.cd_irq >= 0);
 
-	_host->power = TMIO_MMC_OFF_STOP;
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume(&pdev->dev);
+	host->power = TMIO_MMC_OFF_STOP;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume(dev);
 	if (ret < 0)
 		goto pm_disable;
 
@@ -1055,63 +1065,61 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	 *  must additionally ensure that in case 2) the tmio mmc hardware stays
 	 *  powered on during runtime for the card detection to work.
 	 */
-	if (_host->native_hotplug)
-		pm_runtime_get_noresume(&pdev->dev);
+	if (host->native_hotplug)
+		pm_runtime_get_noresume(dev);
 
-	tmio_mmc_clk_stop(_host);
-	tmio_mmc_reset(_host);
+	tmio_mmc_clk_stop(host);
+	tmio_mmc_reset(host);
 
-	_host->sdcard_irq_mask = sd_ctrl_read32(_host, CTL_IRQ_MASK);
-	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+	host->sdcard_irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
+	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	/* Unmask the IRQs we want to know about */
-	if (!_host->chan_rx)
+	if (!host->chan_rx)
 		irq_mask |= TMIO_MASK_READOP;
-	if (!_host->chan_tx)
+	if (!host->chan_tx)
 		irq_mask |= TMIO_MASK_WRITEOP;
-	if (!_host->native_hotplug)
+	if (!host->native_hotplug)
 		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
 
-	_host->sdcard_irq_mask &= ~irq_mask;
+	host->sdcard_irq_mask &= ~irq_mask;
 
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
-	spin_lock_init(&_host->lock);
-	mutex_init(&_host->ios_lock);
+	spin_lock_init(&host->lock);
+	mutex_init(&host->ios_lock);
 
 	/* Init delayed work for request timeouts */
-	INIT_DELAYED_WORK(&_host->delayed_reset_work, tmio_mmc_reset_work);
-	INIT_WORK(&_host->done, tmio_mmc_done_work);
+	INIT_DELAYED_WORK(&host->delayed_reset_work, tmio_mmc_reset_work);
+	INIT_WORK(&host->done, tmio_mmc_done_work);
 
 	/* See if we also get DMA */
-	tmio_mmc_request_dma(_host, pdata);
+	tmio_mmc_request_dma(host, pdata);
 
 	ret = mmc_add_host(mmc);
 	if (pdata->clk_disable)
-		pdata->clk_disable(pdev);
+		pdata->clk_disable(host->pdev);
 	if (ret < 0) {
-		tmio_mmc_host_remove(_host);
+		tmio_mmc_host_remove(host);
 		return ret;
 	}
 
-	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
+	dev_pm_qos_expose_latency_limit(dev, 100);
 
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
 		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio, 0);
 		if (ret < 0) {
-			tmio_mmc_host_remove(_host);
+			tmio_mmc_host_remove(host);
 			return ret;
 		}
 	}
 
-	*host = _host;
-
 	return 0;
 
 pm_disable:
-	pm_runtime_disable(&pdev->dev);
-	iounmap(_host->ctl);
+	pm_runtime_disable(dev);
+	iounmap(host->ctl);
 host_free:
 	mmc_free_host(mmc);
 
-- 
1.9.1

