From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 09/10] MTD/GPMI : add a new field `gpmi_version`
Date: Thu, 19 Jan 2012 14:16:06 +0800
Message-ID: <1326953767-24155-10-git-send-email-b32955@freescale.com>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326953767-24155-1-git-send-email-b32955@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com
Cc: shawn.guo@linaro.org, artem.bityutskiy@intel.com, shijie8@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, LW@KARO-electronics.de, alsa-devel@alsa-project.org, b29396@freescale.com, Huang Shijie <b32955@freescale.com>
List-Id: linux-mmc@vger.kernel.org

add this field to store the GPMI verison.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |    3 +++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    4 ++++
 drivers/mtd/nand/gpmi-nand/gpmi-regs.h |    2 ++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 7f68042..5b73ae5 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -133,6 +133,9 @@ int gpmi_init(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
+	/* Read out the GPMI version */
+	this->gpmi_version = readl(r->gpmi_regs + HW_GPMI_VERSION);
+
 	/* Choose NAND mode. */
 	writel(BM_GPMI_CTRL1_GPMI_MODE, r->gpmi_regs + HW_GPMI_CTRL1_CLR);
 
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 1c7fdbb..5c277e3 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -132,6 +132,10 @@ struct gpmi_nand_data {
 	/* Flash Hardware */
 	struct nand_timing	timing;
 
+	/* GPMI hardware version */
+#define GPMI_VERSION_0501	(0x05010000)
+	u32			gpmi_version;
+
 	/* BCH */
 	struct bch_geometry	bch_geometry;
 	struct completion	bch_done;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
index 8343124..f005b24 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-regs.h
@@ -169,4 +169,6 @@
 #define HW_GPMI_DEBUG					0x000000c0
 #define MX23_BP_GPMI_DEBUG_READY0			28
 #define MX23_BM_GPMI_DEBUG_READY0	(1 << MX23_BP_GPMI_DEBUG_READY0)
+
+#define HW_GPMI_VERSION					0x000000d0
 #endif
-- 
1.7.0.4
