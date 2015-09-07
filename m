From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH-v2 2/3] mmc: sdhci-pxav3: Use BIT macro for bit field definitions
Date: Mon,  7 Sep 2015 17:01:10 +0530
Message-ID: <1441625471-16315-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, ulf.hansson@linaro.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Instead of using shift operation use BIT macro for bit field
definitions.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 7a07177..a8a8c94 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -47,7 +47,7 @@
 #define  SDCLK_DELAY_MASK		0x1f
 
 #define SD_CFG_FIFO_PARAM		0x100
-#define  SDCFG_GEN_PAD_CLK_ON		(1<<6)
+#define  SDCFG_GEN_PAD_CLK_ON		BIT(6)
 #define  SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
 #define  SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
 
@@ -55,8 +55,8 @@
 #define SD_CE_ATA_1			0x10C
 
 #define SD_CE_ATA_2			0x10E
-#define  SDCE_MISC_INT			(1<<2)
-#define  SDCE_MISC_INT_EN		(1<<1)
+#define  SDCE_MISC_INT			BIT(2)
+#define  SDCE_MISC_INT_EN		BIT(1)
 
 struct sdhci_pxa {
 	struct clk *clk_core;
-- 
1.9.1
