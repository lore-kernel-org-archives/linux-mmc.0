From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v3 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Fri, 13 Jan 2017 13:05:53 -0200
Message-ID: <1484319953-6479-3-git-send-email-sergio.prado@e-labworks.com>
References: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484319953-6479-1-git-send-email-sergio.prado@e-labworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>
List-Id: linux-mmc@vger.kernel.org

Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
tree.

Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
---
 drivers/mmc/host/s3cmci.c | 298 ++++++++++++++++++++++++----------------------
 drivers/mmc/host/s3cmci.h |   3 +-
 2 files changed, 158 insertions(+), 143 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 932a4b1fed33..55535b65e0b3 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -23,6 +23,10 @@
 #include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <mach/dma.h>
@@ -127,6 +131,22 @@ enum dbg_channels {
 	dbg_conf  = (1 << 8),
 };
 
+struct s3cmci_variant_data {
+	int s3c2440_compatible;
+};
+
+static const struct s3cmci_variant_data s3c2410_s3cmci_variant_data = {
+	.s3c2440_compatible = 0,
+};
+
+static const struct s3cmci_variant_data s3c2412_s3cmci_variant_data = {
+	.s3c2440_compatible = 1,
+};
+
+static const struct s3cmci_variant_data s3c2440_s3cmci_variant_data = {
+	.s3c2440_compatible = 1,
+};
+
 static const int dbgmap_err   = dbg_fail;
 static const int dbgmap_info  = dbg_info | dbg_conf;
 static const int dbgmap_debug = dbg_err | dbg_debug;
@@ -730,7 +750,7 @@ static irqreturn_t s3cmci_irq(int irq, void *dev_id)
 		goto clear_status_bits;
 
 	/* Check for FIFO failure */
-	if (host->is2440) {
+	if (host->variant->s3c2440_compatible) {
 		if (mci_fsta & S3C2440_SDIFSTA_FIFOFAIL) {
 			dbg(host, dbg_err, "FIFO failure\n");
 			host->mrq->data->error = -EILSEQ;
@@ -806,21 +826,6 @@ static irqreturn_t s3cmci_irq(int irq, void *dev_id)
 
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
@@ -912,7 +917,7 @@ static void finalize_request(struct s3cmci_host *host)
 		if (s3cmci_host_usedma(host))
 			dmaengine_terminate_all(host->dma);
 
-		if (host->is2440) {
+		if (host->variant->s3c2440_compatible) {
 			/* Clear failure register and reset fifo. */
 			writel(S3C2440_SDIFSTA_FIFORESET |
 			       S3C2440_SDIFSTA_FIFOFAIL,
@@ -1025,7 +1030,7 @@ static int s3cmci_setup_data(struct s3cmci_host *host, struct mmc_data *data)
 		dcon |= S3C2410_SDIDCON_XFER_RXSTART;
 	}
 
-	if (host->is2440) {
+	if (host->variant->s3c2440_compatible) {
 		dcon |= S3C2440_SDIDCON_DS_WORD;
 		dcon |= S3C2440_SDIDCON_DATSTART;
 	}
@@ -1044,7 +1049,7 @@ static int s3cmci_setup_data(struct s3cmci_host *host, struct mmc_data *data)
 
 	/* write TIMER register */
 
-	if (host->is2440) {
+	if (host->variant->s3c2440_compatible) {
 		writel(0x007FFFFF, host->base + S3C2410_SDITIMER);
 	} else {
 		writel(0x0000FFFF, host->base + S3C2410_SDITIMER);
@@ -1176,19 +1181,6 @@ static void s3cmci_send_request(struct mmc_host *mmc)
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
@@ -1197,7 +1189,7 @@ static void s3cmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->cmd_is_stop = 0;
 	host->mrq = mrq;
 
-	if (s3cmci_card_present(mmc) == 0) {
+	if (mmc_gpio_get_cd(mmc) == 0) {
 		dbg(host, dbg_err, "%s: no medium present\n", __func__);
 		host->mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
@@ -1241,22 +1233,24 @@ static void s3cmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
 
-		if (!host->is2440)
+		if (!host->variant->s3c2440_compatible)
 			mci_con |= S3C2410_SDICON_FIFORESET;
 
 		break;
 
 	case MMC_POWER_OFF:
 	default:
-		gpio_direction_output(S3C2410_GPE(5), 0);
+		if (!host->pdev->dev.of_node)
+			gpio_direction_output(S3C2410_GPE(5), 0);
 
-		if (host->is2440)
+		if (host->variant->s3c2440_compatible)
 			mci_con |= S3C2440_SDICON_SDRESET;
 
 		if (host->pdata->set_power)
@@ -1294,21 +1288,6 @@ static void s3cmci_reset(struct s3cmci_host *host)
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
@@ -1352,8 +1331,8 @@ static void s3cmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 static struct mmc_host_ops s3cmci_ops = {
 	.request	= s3cmci_request,
 	.set_ios	= s3cmci_set_ios,
-	.get_ro		= s3cmci_get_ro,
-	.get_cd		= s3cmci_card_present,
+	.get_ro		= mmc_gpio_get_ro,
+	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = s3cmci_enable_sdio_irq,
 };
 
@@ -1429,7 +1408,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "Register base = 0x%08x\n", (u32)host->base);
 	seq_printf(seq, "Clock rate = %ld\n", host->clk_rate);
 	seq_printf(seq, "Prescale = %d\n", host->prescaler);
-	seq_printf(seq, "is2440 = %d\n", host->is2440);
+	seq_printf(seq, "S3C2440 compatible = %d\n", host->variant->s3c2440_compatible);
 	seq_printf(seq, "IRQ = %d\n", host->irq);
 	seq_printf(seq, "IRQ enabled = %d\n", host->irq_enabled);
 	seq_printf(seq, "IRQ disabled = %d\n", host->irq_disabled);
@@ -1544,21 +1523,15 @@ static inline void s3cmci_debugfs_remove(struct s3cmci_host *host) { }
 
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
+	host->variant = (const struct s3cmci_variant_data *)
+		platform_get_device_id(pdev)->driver_data;
 
 	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++) {
 		ret = gpio_request(i, dev_name(&pdev->dev));
@@ -1568,25 +1541,103 @@ static int s3cmci_probe(struct platform_device *pdev)
 			for (i--; i >= S3C2410_GPE(5); i--)
 				gpio_free(i);
 
-			goto probe_free_host;
+			return ret;
 		}
 	}
 
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
+		}
+	}
+
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
+	host->variant = of_device_get_match_data(&pdev->dev);
+	if (!host->variant)
+		return -ENODEV;
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
+	if (host->variant->s3c2440_compatible) {
 		host->sdiimsk	= S3C2440_SDIIMSK;
 		host->sdidata	= S3C2440_SDIDATA;
 		host->clk_div	= 1;
@@ -1644,43 +1695,6 @@ static int s3cmci_probe(struct platform_device *pdev)
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
@@ -1688,7 +1702,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 		ret = PTR_ERR_OR_ZERO(host->dma);
 		if (ret) {
 			dev_err(&pdev->dev, "cannot get DMA channel.\n");
-			goto probe_free_gpio_wp;
+			goto probe_free_irq;
 		}
 	}
 
@@ -1730,7 +1744,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 
 	dbg(host, dbg_debug,
 	    "probe: mode:%s mapped mci_base:%p irq:%u irq_cd:%u dma:%p.\n",
-	    (host->is2440?"2440":""),
+	    (host->variant->s3c2440_compatible?"2440":""),
 	    host->base, host->irq, host->irq_cd, host->dma);
 
 	ret = s3cmci_cpufreq_register(host);
@@ -1767,18 +1781,6 @@ static int s3cmci_probe(struct platform_device *pdev)
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
 
@@ -1789,8 +1791,9 @@ static int s3cmci_probe(struct platform_device *pdev)
 	release_mem_region(host->mem->start, resource_size(host->mem));
 
  probe_free_gpio:
-	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
-		gpio_free(i);
+	if (!pdev->dev.of_node)
+		for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
+			gpio_free(i);
 
  probe_free_host:
 	mmc_free_host(mmc);
@@ -1817,7 +1820,6 @@ static int s3cmci_remove(struct platform_device *pdev)
 {
 	struct mmc_host		*mmc  = platform_get_drvdata(pdev);
 	struct s3cmci_host	*host = mmc_priv(mmc);
-	struct s3c24xx_mci_pdata *pd = host->pdata;
 	int i;
 
 	s3cmci_shutdown(pdev);
@@ -1831,15 +1833,9 @@ static int s3cmci_remove(struct platform_device *pdev)
 
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
@@ -1848,16 +1844,33 @@ static int s3cmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id s3cmci_dt_match[] = {
+	{
+		.compatible = "samsung,s3c2410-sdi",
+		.data = &s3c2410_s3cmci_variant_data,
+	},
+	{
+		.compatible = "samsung,s3c2412-sdi",
+		.data = &s3c2412_s3cmci_variant_data,
+	},
+	{
+		.compatible = "samsung,s3c2440-sdi",
+		.data = &s3c2440_s3cmci_variant_data,
+	},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
+
 static const struct platform_device_id s3cmci_driver_ids[] = {
 	{
 		.name	= "s3c2410-sdi",
-		.driver_data	= 0,
+		.driver_data	= (kernel_ulong_t) &s3c2410_s3cmci_variant_data,
 	}, {
 		.name	= "s3c2412-sdi",
-		.driver_data	= 1,
+		.driver_data	= (kernel_ulong_t) &s3c2412_s3cmci_variant_data,
 	}, {
 		.name	= "s3c2440-sdi",
-		.driver_data	= 1,
+		.driver_data	= (kernel_ulong_t) &s3c2440_s3cmci_variant_data,
 	},
 	{ }
 };
@@ -1867,6 +1880,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 static struct platform_driver s3cmci_driver = {
 	.driver	= {
 		.name	= "s3c-sdi",
+		.of_match_table = s3cmci_dt_match,
 	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..e9fe48915a2e 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -33,7 +33,8 @@ struct s3cmci_host {
 	unsigned long		real_rate;
 	u8			prescaler;
 
-	int			is2440;
+	const struct s3cmci_variant_data *variant;
+
 	unsigned		sdiimsk;
 	unsigned		sdidata;
 
-- 
1.9.1
