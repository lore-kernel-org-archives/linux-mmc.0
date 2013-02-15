From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v4 2/5] mmc: davinci_mmc: derive controller IP version from platform_device_id
Date: Fri, 15 Feb 2013 11:51:59 +0530
Message-ID: <1360909322-1858-3-git-send-email-prakash.pm@ti.com>
References: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1360909322-1858-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, "Manjunathappa, Prakash" <prakash.pm@ti.com>
List-Id: linux-mmc@vger.kernel.org

Stop getting controller IP version via platform data, instead derive it
from platform_device_id table.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Suppose to be v1 but got added later to this series.

 drivers/mmc/host/davinci_mmc.c            |   17 ++++++++++++++++-
 include/linux/platform_data/mmc-davinci.h |    3 ---
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 27123f8..874dc60 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1156,6 +1156,17 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
 
 	mmc_davinci_reset_ctrl(host, 0);
 }
+static struct platform_device_id davinci_mmc_devtype[] = {
+	{
+		.name	= "davinci-mmc-dm355",
+		.driver_data = MMC_CTLR_VERSION_1,
+	}, {
+		.name	= "davinci-mmc-da830",
+		.driver_data = MMC_CTLR_VERSION_2,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);
 
 static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 {
@@ -1165,6 +1176,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	struct resource *r, *mem = NULL;
 	int ret = 0, irq = 0;
 	size_t mem_size;
+	const struct platform_device_id *id_entry;
 
 	/* REVISIT:  when we're fully converted, fail if pdata is NULL */
 
@@ -1239,7 +1251,9 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	if (pdata && (pdata->wires == 8))
 		mmc->caps |= (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
 
-	host->version = pdata->version;
+	id_entry = platform_get_device_id(pdev);
+	if (id_entry)
+		host->version = id_entry->driver_data;
 
 	mmc->ops = &mmc_davinci_ops;
 	mmc->f_min = 312500;
@@ -1410,6 +1424,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.pm	= davinci_mmcsd_pm_ops,
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
+	.id_table	= davinci_mmc_devtype,
 };
 
 static int __init davinci_mmcsd_init(void)
diff --git a/include/linux/platform_data/mmc-davinci.h b/include/linux/platform_data/mmc-davinci.h
index 5ba6b22..9cea4ee 100644
--- a/include/linux/platform_data/mmc-davinci.h
+++ b/include/linux/platform_data/mmc-davinci.h
@@ -23,9 +23,6 @@ struct davinci_mmc_config {
 	/* any additional host capabilities: OR'd in to mmc->f_caps */
 	u32     caps;
 
-	/* Version of the MMC/SD controller */
-	u8	version;
-
 	/* Number of sg segments */
 	u8	nr_sg;
 };
-- 
1.7.4.1

