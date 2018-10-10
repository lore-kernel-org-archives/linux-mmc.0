From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 2/2] mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
Date: Wed, 10 Oct 2018 12:51:32 +0900
Message-ID: <1539143492-32605-3-git-send-email-yamada.masahiro@socionext.com>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

TMIO_MMC_HAVE_HIGH_REG is confusing due to its counter-intuitive name.

All the TMIO MMC variants (TMIO MMC, Renesas SDHI, UniPhier SD) actually
have high registers. It is just that each of them implements its own
registers there. The original IP from Panasonic only defines registers
0x00-0xff in the bus_shift=1 review. The register area above them is
platform-dependent.

In fact, TMIO_MMC_HAVE_HIGH_REG is set only by tmio-mmc.c and used to
test the accessibility of CTL_SDIO_REGS. Because it is specific to
the TMIO MFD variant, the right thing to do is to move such registers
to tmio_mmc.c and delete the TMIO_MMC_HAVE_HIGH_REG flag.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/tmio_mmc.c | 7 +++++--
 drivers/mmc/host/tmio_mmc.h | 3 ---
 include/linux/mfd/tmio.h    | 7 -------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 00d291c..4e91020 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -24,6 +24,11 @@
 
 #include "tmio_mmc.h"
 
+/* Registers specific to this variant */
+#define CTL_SDIO_REGS		0x100
+#define CTL_CLK_AND_WAIT_CTL	0x138
+#define CTL_RESET_SDIO		0x1e0
+
 static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
 {
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
@@ -161,8 +166,6 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 		goto cell_disable;
 	}
 
-	pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
-
 	host = tmio_mmc_host_alloc(pdev, pdata);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index a1a661b..18b4308 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -47,9 +47,6 @@
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
 #define CTL_SDIF_MODE 0xe6
-#define CTL_SDIO_REGS 0x100
-#define CTL_CLK_AND_WAIT_CTL 0x138
-#define CTL_RESET_SDIO 0x1e0
 
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
 #define TMIO_STOP_STP		BIT(0)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 7786621..1e70060 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -62,13 +62,6 @@
 #define TMIO_MMC_USE_GPIO_CD		BIT(5)
 
 /*
- * Some controllers doesn't have over 0x100 register.
- * it is used to checking accessibility of
- * CTL_SD_CARD_CLK_CTL / CTL_CLK_AND_WAIT_CTL
- */
-#define TMIO_MMC_HAVE_HIGH_REG		BIT(6)
-
-/*
  * Some controllers have CMD12 automatically
  * issue/non-issue register
  */
-- 
2.7.4
