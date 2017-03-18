From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v5 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Fri, 17 Mar 2017 22:13:53 -0300
Message-ID: <1489799633-29278-3-git-send-email-sergio.prado@e-labworks.com>
References: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35079 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdCRBOq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 21:14:46 -0400
Received: by mail-qk0-f194.google.com with SMTP id o135so11815688qke.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 18:14:40 -0700 (PDT)
In-Reply-To: <1489799633-29278-1-git-send-email-sergio.prado@e-labworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>

Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
tree.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 drivers/mmc/host/s3cmci.c | 257 +++++++++++++++++++++++-----------------------
 1 file changed, 126 insertions(+), 131 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 7a173f8c455b..3020f31d593c 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -24,6 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <mach/dma.h>
@@ -807,21 +811,6 @@ static irqreturn_t s3cmci_irq(int irq, void *dev_id)
 
 }
 
-/*
- * ISR for the CardDetect Pin
-*/
-
-static irqreturn_t s3cmci_irq_cd(int irq, void *dev_id)
-{
-	struct s3cmci_host *host = (struct s3cmci_host *)dev_id;
-
-	dbg(host, dbg_irq, "card detect\n");
-
-	mmc_detect_change(host->mmc, msecs_to_jiffies(500));
-
-	return IRQ_HANDLED;
-}
-
 static void s3cmci_dma_done_callback(void *arg)
 {
 	struct s3cmci_host *host = arg;
@@ -1177,19 +1166,6 @@ static void s3cmci_send_request(struct mmc_host *mmc)
 	s3cmci_enable_irq(host, true);
 }
 
-static int s3cmci_card_present(struct mmc_host *mmc)
-{
-	struct s3cmci_host *host = mmc_priv(mmc);
-	struct s3c24xx_mci_pdata *pdata = host->pdata;
-	int ret;
-
-	if (pdata->no_detect)
-		return -ENOSYS;
-
-	ret = gpio_get_value(pdata->gpio_detect) ? 0 : 1;
-	return ret ^ pdata->detect_invert;
-}
-
 static void s3cmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct s3cmci_host *host = mmc_priv(mmc);
@@ -1198,7 +1174,7 @@ static void s3cmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->cmd_is_stop = 0;
 	host->mrq = mrq;
 
-	if (s3cmci_card_present(mmc) == 0) {
+	if (mmc_gpio_get_cd(mmc) == 0) {
 		dbg(host, dbg_err, "%s: no medium present\n", __func__);
 		host->mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
@@ -1242,8 +1218,9 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_ON:
 	case MMC_POWER_UP:
 		/* Configure GPE5...GPE10 pins in SD mode */
-		s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
-				      S3C_GPIO_PULL_NONE);
+		if (!host->pdev->dev.of_node)
+			s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
+					      S3C_GPIO_PULL_NONE);
 
 		if (host->pdata->set_power)
 			host->pdata->set_power(ios->power_mode, ios->vdd);
@@ -1255,7 +1232,8 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	case MMC_POWER_OFF:
 	default:
-		gpio_direction_output(S3C2410_GPE(5), 0);
+		if (!host->pdev->dev.of_node)
+			gpio_direction_output(S3C2410_GPE(5), 0);
 
 		if (host->is2440)
 			mci_con |= S3C2440_SDICON_SDRESET;
@@ -1295,21 +1273,6 @@ static void s3cmci_reset(struct s3cmci_host *host)
 	writel(con, host->base + S3C2410_SDICON);
 }
 
-static int s3cmci_get_ro(struct mmc_host *mmc)
-{
-	struct s3cmci_host *host = mmc_priv(mmc);
-	struct s3c24xx_mci_pdata *pdata = host->pdata;
-	int ret;
-
-	if (pdata->no_wprotect)
-		return 0;
-
-	ret = gpio_get_value(pdata->gpio_wprotect) ? 1 : 0;
-	ret ^= pdata->wprotect_invert;
-
-	return ret;
-}
-
 static void s3cmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct s3cmci_host *host = mmc_priv(mmc);
@@ -1353,8 +1316,8 @@ static void s3cmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 static struct mmc_host_ops s3cmci_ops = {
 	.request	= s3cmci_request,
 	.set_ios	= s3cmci_set_ios,
-	.get_ro		= s3cmci_get_ro,
-	.get_cd		= s3cmci_card_present,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = s3cmci_enable_sdio_irq,
 };
 
@@ -1545,21 +1508,14 @@ static inline void s3cmci_debugfs_remove(struct s3cmci_host *host) { }
 
 #endif /* CONFIG_DEBUG_FS */
 
-static int s3cmci_probe(struct platform_device *pdev)
+static int s3cmci_probe_pdata(struct s3cmci_host *host)
 {
-	struct s3cmci_host *host;
-	struct mmc_host	*mmc;
-	int ret;
-	int is2440;
-	int i;
+	struct platform_device *pdev = host->pdev;
+	struct mmc_host *mmc = host->mmc;
+	struct s3c24xx_mci_pdata *pdata;
+	int i, ret;
 
-	is2440 = platform_get_device_id(pdev)->driver_data;
-
-	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto probe_out;
-	}
+	host->is2440 = platform_get_device_id(pdev)->driver_data;
 
 	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++) {
 		ret = gpio_request(i, dev_name(&pdev->dev));
@@ -1569,25 +1525,101 @@ static int s3cmci_probe(struct platform_device *pdev)
 			for (i--; i >= S3C2410_GPE(5); i--)
 				gpio_free(i);
 
-			goto probe_free_host;
+			return ret;
+		}
+	}
+
+	if (!pdev->dev.platform_data)
+		pdev->dev.platform_data = &s3cmci_def_pdata;
+
+	pdata = pdev->dev.platform_data;
+
+	if (pdata->no_wprotect)
+		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
+
+	if (pdata->no_detect)
+		mmc->caps |= MMC_CAP_NEEDS_POLL;
+
+	if (pdata->wprotect_invert);
+		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+
+	if (pdata->detect_invert)
+		 mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
+	if (gpio_is_valid(pdata->gpio_detect)) {
+		ret = mmc_gpio_request_cd(mmc, pdata->gpio_detect, 0);
+		if (ret) {
+			dev_err(&pdev->dev, "error requesting GPIO for CD %d\n",
+				ret);
+			return ret;
 		}
 	}
 
+	if (gpio_is_valid(pdata->gpio_wprotect)) {
+		ret = mmc_gpio_request_ro(mmc, pdata->gpio_wprotect);
+		if (ret) {
+			dev_err(&pdev->dev, "error requesting GPIO for WP %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int s3cmci_probe_dt(struct s3cmci_host *host)
+{
+	struct platform_device *pdev = host->pdev;
+	struct s3c24xx_mci_pdata *pdata;
+	struct mmc_host *mmc = host->mmc;
+	int ret;
+
+	host->is2440 = (int) of_device_get_match_data(&pdev->dev);
+
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		return ret;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdev->dev.platform_data = pdata;
+
+	return 0;
+}
+
+static int s3cmci_probe(struct platform_device *pdev)
+{
+	struct s3cmci_host *host;
+	struct mmc_host	*mmc;
+	int ret;
+	int i;
+
+	mmc = mmc_alloc_host(sizeof(struct s3cmci_host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto probe_out;
+	}
+
 	host = mmc_priv(mmc);
 	host->mmc 	= mmc;
 	host->pdev	= pdev;
-	host->is2440	= is2440;
+
+	if (pdev->dev.of_node)
+		ret = s3cmci_probe_dt(host);
+	else
+		ret = s3cmci_probe_pdata(host);
+
+	if (ret)
+		goto probe_free_host;
 
 	host->pdata = pdev->dev.platform_data;
-	if (!host->pdata) {
-		pdev->dev.platform_data = &s3cmci_def_pdata;
-		host->pdata = &s3cmci_def_pdata;
-	}
 
 	spin_lock_init(&host->complete_lock);
 	tasklet_init(&host->pio_tasklet, pio_tasklet, (unsigned long) host);
 
-	if (is2440) {
+	if (host->is2440) {
 		host->sdiimsk	= S3C2440_SDIIMSK;
 		host->sdidata	= S3C2440_SDIDATA;
 		host->clk_div	= 1;
@@ -1645,43 +1677,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 	disable_irq(host->irq);
 	host->irq_state = false;
 
-	if (!host->pdata->no_detect) {
-		ret = gpio_request(host->pdata->gpio_detect, "s3cmci detect");
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get detect gpio\n");
-			goto probe_free_irq;
-		}
-
-		host->irq_cd = gpio_to_irq(host->pdata->gpio_detect);
-
-		if (host->irq_cd >= 0) {
-			if (request_irq(host->irq_cd, s3cmci_irq_cd,
-					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
-					DRIVER_NAME, host)) {
-				dev_err(&pdev->dev,
-					"can't get card detect irq.\n");
-				ret = -ENOENT;
-				goto probe_free_gpio_cd;
-			}
-		} else {
-			dev_warn(&pdev->dev,
-				 "host detect has no irq available\n");
-			gpio_direction_input(host->pdata->gpio_detect);
-		}
-	} else
-		host->irq_cd = -1;
-
-	if (!host->pdata->no_wprotect) {
-		ret = gpio_request(host->pdata->gpio_wprotect, "s3cmci wp");
-		if (ret) {
-			dev_err(&pdev->dev, "failed to get writeprotect\n");
-			goto probe_free_irq_cd;
-		}
-
-		gpio_direction_input(host->pdata->gpio_wprotect);
-	}
-
 	/* Depending on the dma state, get a DMA channel to use. */
 
 	if (s3cmci_host_usedma(host)) {
@@ -1689,7 +1684,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 		ret = PTR_ERR_OR_ZERO(host->dma);
 		if (ret) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
-			goto probe_free_gpio_wp;
+			goto probe_free_irq;
 		}
 	}
 
@@ -1768,18 +1763,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 	if (s3cmci_host_usedma(host))
 		dma_release_channel(host->dma);
 
- probe_free_gpio_wp:
-	if (!host->pdata->no_wprotect)
-		gpio_free(host->pdata->gpio_wprotect);
-
- probe_free_gpio_cd:
-	if (!host->pdata->no_detect)
-		gpio_free(host->pdata->gpio_detect);
-
- probe_free_irq_cd:
-	if (host->irq_cd >= 0)
-		free_irq(host->irq_cd, host);
-
  probe_free_irq:
 	free_irq(host->irq, host);
 
@@ -1790,8 +1773,9 @@ static int s3cmci_probe(struct platform_device *pdev)
 	release_mem_region(host->mem->start, resource_size(host->mem));
 
  probe_free_gpio:
-	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
-		gpio_free(i);
+	if (!pdev->dev.of_node)
+		for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
+			gpio_free(i);
 
  probe_free_host:
 	mmc_free_host(mmc);
@@ -1818,7 +1802,6 @@ static int s3cmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host		*mmc  = platform_get_drvdata(pdev);
 	struct s3cmci_host	*host = mmc_priv(mmc);
-	struct s3c24xx_mci_pdata *pd = host->pdata;
 	int i;
 
 	s3cmci_shutdown(pdev);
@@ -1832,15 +1815,9 @@ static int s3cmci_remove(struct platform_device *pdev)
 
 	free_irq(host->irq, host);
 
-	if (!pd->no_wprotect)
-		gpio_free(pd->gpio_wprotect);
-
-	if (!pd->no_detect)
-		gpio_free(pd->gpio_detect);
-
-	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
-		gpio_free(i);
-
+	if (!pdev->dev.of_node)
+		for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
+			gpio_free(i);
 
 	iounmap(host->base);
 	release_mem_region(host->mem->start, resource_size(host->mem));
@@ -1849,6 +1826,23 @@ static int s3cmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id s3cmci_dt_match[] = {
+	{
+		.compatible = "samsung,s3c2410-sdi",
+		.data = (void *)0,
+	},
+	{
+		.compatible = "samsung,s3c2412-sdi",
+		.data = (void *)1,
+	},
+	{
+		.compatible = "samsung,s3c2440-sdi",
+		.data = (void *)1,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
+
 static const struct platform_device_id s3cmci_driver_ids[] = {
 	{
 		.name	= "s3c2410-sdi",
@@ -1868,6 +1862,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 static struct platform_driver s3cmci_driver = {
 	.driver	= {
 		.name	= "s3c-sdi",
+		.of_match_table = s3cmci_dt_match,
 	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
-- 
1.9.1

