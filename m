From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 01/11] mmc: add kerneldoc to mmc_regulator_get_supply()
Date: Sat, 14 Oct 2017 21:17:09 +0200
Message-ID: <20171014191719.2129-2-wsa+renesas@sang-engineering.com>
References: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171014191719.2129-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Especially, make clear what the return value means.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c287d297710aa4..7859bb617a2f60 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1595,6 +1595,16 @@ EXPORT_SYMBOL_GPL(mmc_regulator_set_vqmmc);
 
 #endif /* CONFIG_REGULATOR */
 
+/**
+ * mmc_regulator_get_supply - try to get VMMC and VQMMC regulators for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. errno should be handled, it is either a critical error
+ * or -EPROBE_DEFER. 0 means no critical error but it does not mean all
+ * regulators have been found because they all are optional. If you require
+ * certain regulators, you need to check separately in your driver if they got
+ * populated after calling this function.
+ */
 int mmc_regulator_get_supply(struct mmc_host *mmc)
 {
 	struct device *dev = mmc_dev(mmc);
-- 
2.11.0
