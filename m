From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mfd: tmio: move register macros to tmio_core.c
Date: Tue,  7 Nov 2017 17:14:12 +0900
Message-ID: <1510042453-27619-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-10.nifty.com ([210.131.2.77]:35897 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbdKGIRM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2017 03:17:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Simon Horman <simon.horman@netronome.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

These registers are only used in drivers/mfd/tmio_core.c

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mfd/tmio_core.c  | 20 ++++++++++++++++++++
 include/linux/mfd/tmio.h | 20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/tmio_core.c b/drivers/mfd/tmio_core.c
index 83af78c..ebf54cc 100644
--- a/drivers/mfd/tmio_core.c
+++ b/drivers/mfd/tmio_core.c
@@ -9,6 +9,26 @@
 #include <linux/export.h>
 #include <linux/mfd/tmio.h>
 
+#define CNF_CMD     0x04
+#define CNF_CTL_BASE   0x10
+#define CNF_INT_PIN  0x3d
+#define CNF_STOP_CLK_CTL 0x40
+#define CNF_GCLK_CTL 0x41
+#define CNF_SD_CLK_MODE 0x42
+#define CNF_PIN_STATUS 0x44
+#define CNF_PWR_CTL_1 0x48
+#define CNF_PWR_CTL_2 0x49
+#define CNF_PWR_CTL_3 0x4a
+#define CNF_CARD_DETECT_MODE 0x4c
+#define CNF_SD_SLOT 0x50
+#define CNF_EXT_GCLK_CTL_1 0xf0
+#define CNF_EXT_GCLK_CTL_2 0xf1
+#define CNF_EXT_GCLK_CTL_3 0xf9
+#define CNF_SD_LED_EN_1 0xfa
+#define CNF_SD_LED_EN_2 0xfe
+
+#define   SDCREN 0x2   /* Enable access to MMC CTL regs. (flag in COMMAND_REG)*/
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base)
 {
 	/* Enable the MMC/SD Control registers */
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index e1cfe91..396a103c 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -25,26 +25,6 @@
 		writew((val) >> 16, (addr) + 2); \
 	} while (0)
 
-#define CNF_CMD     0x04
-#define CNF_CTL_BASE   0x10
-#define CNF_INT_PIN  0x3d
-#define CNF_STOP_CLK_CTL 0x40
-#define CNF_GCLK_CTL 0x41
-#define CNF_SD_CLK_MODE 0x42
-#define CNF_PIN_STATUS 0x44
-#define CNF_PWR_CTL_1 0x48
-#define CNF_PWR_CTL_2 0x49
-#define CNF_PWR_CTL_3 0x4a
-#define CNF_CARD_DETECT_MODE 0x4c
-#define CNF_SD_SLOT 0x50
-#define CNF_EXT_GCLK_CTL_1 0xf0
-#define CNF_EXT_GCLK_CTL_2 0xf1
-#define CNF_EXT_GCLK_CTL_3 0xf9
-#define CNF_SD_LED_EN_1 0xfa
-#define CNF_SD_LED_EN_2 0xfe
-
-#define   SDCREN 0x2   /* Enable access to MMC CTL regs. (flag in COMMAND_REG)*/
-
 #define sd_config_write8(base, shift, reg, val) \
 	tmio_iowrite8((val), (base) + ((reg) << (shift)))
 #define sd_config_write16(base, shift, reg, val) \
-- 
2.7.4

