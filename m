From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] mmc: sdhci: make sdhci-dove driver self registered
Date: Mon, 21 Mar 2011 16:07:01 +0800
Message-ID: <1300694823-8300-4-git-send-email-shawn.guo@linaro.org>
References: <1300694823-8300-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1300694823-8300-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The patch adds sdhci-dove its own .probe and .remove which in turn
call into the common functions provided by sdhci-pltfm.c, so that
sdhci-dove driver registers itself and keep all sdhci-dove specific
things like sdhci_dove_pdata away from sdhci-pltfm.c which is common.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/sdhci-dove.c  |   70 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pltfm.c |    3 --
 drivers/mmc/host/sdhci-pltfm.h |    1 -
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 2aeef4f..e985338 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -3,7 +3,7 @@
  *
  * Author: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
  *	   Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
- * Based on sdhci-cns3xxx.c
+ * Based on sdhci-dove.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -61,10 +61,76 @@ static struct sdhci_ops sdhci_dove_ops = {
 	.read_l	= sdhci_dove_readl,
 };
 
-struct sdhci_pltfm_data sdhci_dove_pdata = {
+static struct sdhci_pltfm_data sdhci_dove_pdata = {
 	.ops	= &sdhci_dove_ops,
 	.quirks	= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_FORCE_DMA,
 };
+
+static int __devinit sdhci_dove_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	int ret;
+
+	host = sdhci_pltfm_init(pdev, &sdhci_dove_pdata);
+	if (!host)
+		return -ENOMEM;
+
+	ret = sdhci_add_host(host);
+	if (ret)
+		goto err_add_host;
+
+	return 0;
+
+err_add_host:
+	sdhci_pltfm_free(pdev);
+	return ret;
+}
+
+static int __devexit sdhci_dove_remove(struct platform_device *pdev)
+{
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	int dead = 0;
+	u32 scratch;
+
+	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
+	if (scratch == (u32)-1)
+		dead = 1;
+
+	sdhci_remove_host(pdev, dead);
+	sdhci_pltfm_free(pdev);
+
+	return 0;
+}
+
+static struct platform_driver sdhci_dove_driver = {
+	.driver		= {
+		.name	= "sdhci-dove",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sdhci_dove_probe,
+	.remove		= __devexit_p(sdhci_dove_remove),
+#ifdef CONFIG_PM
+	.suspend	= sdhci_pltfm_suspend,
+	.resume		= sdhci_pltfm_resume,
+#endif
+};
+
+static int __init sdhci_dove_init(void)
+{
+	return platform_driver_register(&sdhci_dove_driver);
+}
+
+static void __exit sdhci_dove_exit(void)
+{
+	platform_driver_unregister(&sdhci_dove_driver);
+}
+
+module_init(sdhci_dove_init);
+module_exit(sdhci_dove_exit);
+
+MODULE_DESCRIPTION("SDHCI driver for Dove");
+MODULE_AUTHOR("Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index b9a904d..c4bba33 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -272,9 +272,6 @@ static int __devexit sdhci_pltfm_remove(struct platform_device *pdev)
 
 static const struct platform_device_id sdhci_pltfm_ids[] = {
 	{ "sdhci", },
-#ifdef CONFIG_MMC_SDHCI_DOVE
-	{ "sdhci-dove", (kernel_ulong_t)&sdhci_dove_pdata },
-#endif
 #ifdef CONFIG_MMC_SDHCI_TEGRA
 	{ "sdhci-tegra", (kernel_ulong_t)&sdhci_tegra_pdata },
 #endif
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 493a8d0..d7267f0 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -21,7 +21,6 @@ struct sdhci_pltfm_host {
 	u32 scratchpad; /* to handle quirks across io-accessor calls */
 };
 
-extern struct sdhci_pltfm_data sdhci_dove_pdata;
 extern struct sdhci_pltfm_data sdhci_tegra_pdata;
 extern struct sdhci_pltfm_data sdhci_tegra_dt_pdata;
 
-- 
1.7.1
