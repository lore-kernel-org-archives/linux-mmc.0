From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 7/9] Revert "mmc: dw_mmc: deprecated the "num-slots" property"
Date: Fri,  6 Oct 2017 15:21:30 -0400
Message-ID: <8a128c02687629bee2cda9ca02ca5895be8202c4.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This reverts commit d30a8f7bdf6498e47bd3a6f31e5028f239deb208.

The Mellanox BlueField SoC requires multiple slot dw-mmc support.

Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ef36e05..150cd05 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3018,8 +3018,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	}
 
 	/* find out number of slots supported */
-	if (!device_property_read_u32(dev, "num-slots", &pdata->num_slots))
-		dev_info(dev, "'num-slots' was deprecated.\n");
+	device_property_read_u32(dev, "num-slots", &pdata->num_slots);
 
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
@@ -3252,12 +3251,18 @@ int dw_mci_probe(struct dw_mci *host)
 	if (ret)
 		goto err_dmaunmap;
 
-	/*
-	 * Even though dwmmc IP is provided the multiple slots,
-	 * there is no use case in mmc subsystem.
-	 * dwmmc host controller needs to initialize the one slot per an IP.
-	 */
-	host->num_slots = 1;
+	if (host->pdata->num_slots)
+		host->num_slots = host->pdata->num_slots;
+	else
+		host->num_slots = 1;
+
+	if (host->num_slots < 1 ||
+	    host->num_slots > SDMMC_GET_SLOT_NUM(mci_readl(host, HCON))) {
+		dev_err(host->dev,
+			"Platform data must supply correct num_slots.\n");
+		ret = -ENODEV;
+		goto err_clk_ciu;
+	}
 
 	/*
 	 * Enable interrupts for command done, data over, data empty,
-- 
1.8.3.1
