From: Liming Sun <lsun@mellanox.com>
Subject: [PATCH 9/9] mmc: dw_mmc: Parse slot-specific configuration
Date: Fri,  6 Oct 2017 15:21:32 -0400
Message-ID: <d41a16f96273b31771310608df9718caaadd72a0.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
In-Reply-To: <cover.1507315433.git.lsun@mellanox.com>
References: <cover.1507315433.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Liming Sun <lsun@mellanox.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This commit adds code to parse the child-nodes for slot specific
configuration in the dw_mmc host driver according to
linux/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt

This change is needed when the cards have different configuration
like the 'bus-width'.

Signed-off-by: Liming Sun <lsun@mellanox.com>
Reviewed-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 drivers/mmc/host/dw_mmc.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a3188c2..9d870db 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2766,6 +2766,39 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void mmc_parse_slot_cfg(struct mmc_host *mmc)
+{
+	struct dw_mci_slot *slot = mmc_priv(mmc);
+	struct fwnode_handle *child;
+	u32 bus_width, id;
+
+	/* Find the node for this card. */
+	device_for_each_child_node(mmc->parent, child) {
+		if (!fwnode_property_read_u32(child, "reg", &id) &&
+		    id == slot->id)
+			break;
+	}
+
+	if (!child)
+		return;
+
+	if (!fwnode_property_read_u32(child, "bus-width", &bus_width)) {
+		switch (bus_width) {
+		case 8:
+			mmc->caps |= MMC_CAP_8_BIT_DATA;
+			/* Hosts capable of 8-bit can also do 4 bits. */
+		case 4:
+			mmc->caps |= MMC_CAP_4_BIT_DATA;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (fwnode_property_read_bool(child, "disable-wp"))
+		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
+}
+
 static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
@@ -2830,10 +2863,14 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps2)
 		mmc->caps2 = host->pdata->caps2;
 
+	/* Parse common configuration. */
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto err_host_allocated;
 
+	/* Check per-slot configuration. */
+	mmc_parse_slot_cfg(mmc);
+
 	/* Process SDIO IRQs through the sdio_irq_work. */
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
-- 
1.8.3.1
