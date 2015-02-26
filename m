From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 1/8] mmc: sdhci-st: Add macros for register offsets and bitfields for mmcss glue regs
Date: Thu, 26 Feb 2015 13:10:20 +0000
Message-ID: <1424956227-18258-2-git-send-email-peter.griffin@linaro.org>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org

The stih407 family SoC's have additional glue registers in the flashSS which
are used to configure the Arasan controller.

This patch adds macros for the register offsets and bitfields which will be used by
subsequent patches to support stih407 family SoC's.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-st.c | 91 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 882b07e..a3bc3c3 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -26,6 +26,97 @@
 
 #include "sdhci-pltfm.h"
 
+/* MMCSS glue logic to setup the HC on some ST SoCs (e.g. STiH407 family) */
+
+#define	ST_MMC_CCONFIG_REG_1		0x400
+#define ST_MMC_CCONFIG_TIMEOUT_CLK_UNIT	BIT(24)
+#define ST_MMC_CCONFIG_TIMEOUT_CLK_FREQ	BIT(12)
+#define ST_MMC_CCONFIG_TUNING_COUNT_DEFAULT	BIT(8)
+#define ST_MMC_CCONFIG_ASYNC_WAKEUP	BIT(0)
+#define ST_MMC_CCONFIG_1_DEFAULT	\
+				((ST_MMC_CCONFIG_TIMEOUT_CLK_UNIT) | \
+				 (ST_MMC_CCONFIG_TIMEOUT_CLK_FREQ) | \
+				 (ST_MMC_CCONFIG_TUNING_COUNT_DEFAULT))
+
+#define ST_MMC_CCONFIG_REG_2		0x404
+#define ST_MMC_CCONFIG_HIGH_SPEED	BIT(28)
+#define ST_MMC_CCONFIG_ADMA2		BIT(24)
+#define ST_MMC_CCONFIG_8BIT		BIT(20)
+#define ST_MMC_CCONFIG_MAX_BLK_LEN	16
+#define  MAX_BLK_LEN_1024		1
+#define  MAX_BLK_LEN_2048		2
+#define BASE_CLK_FREQ_200		0xc8
+#define BASE_CLK_FREQ_100		0x64
+#define BASE_CLK_FREQ_50		0x32
+#define ST_MMC_CCONFIG_2_DEFAULT \
+	(ST_MMC_CCONFIG_HIGH_SPEED | ST_MMC_CCONFIG_ADMA2 | \
+	 ST_MMC_CCONFIG_8BIT | \
+	 (MAX_BLK_LEN_1024 << ST_MMC_CCONFIG_MAX_BLK_LEN))
+
+#define ST_MMC_CCONFIG_REG_3			0x408
+#define ST_MMC_CCONFIG_EMMC_SLOT_TYPE		BIT(28)
+#define ST_MMC_CCONFIG_64BIT			BIT(24)
+#define ST_MMC_CCONFIG_ASYNCH_INTR_SUPPORT	BIT(20)
+#define ST_MMC_CCONFIG_1P8_VOLT			BIT(16)
+#define ST_MMC_CCONFIG_3P0_VOLT			BIT(12)
+#define ST_MMC_CCONFIG_3P3_VOLT			BIT(8)
+#define ST_MMC_CCONFIG_SUSP_RES_SUPPORT		BIT(4)
+#define ST_MMC_CCONFIG_SDMA			BIT(0)
+#define ST_MMC_CCONFIG_3_DEFAULT	\
+			 (ST_MMC_CCONFIG_ASYNCH_INTR_SUPPORT	| \
+			  ST_MMC_CCONFIG_3P3_VOLT		| \
+			  ST_MMC_CCONFIG_SUSP_RES_SUPPORT	| \
+			  ST_MMC_CCONFIG_SDMA)
+
+#define ST_MMC_CCONFIG_REG_4	0x40c
+#define ST_MMC_CCONFIG_D_DRIVER	BIT(20)
+#define ST_MMC_CCONFIG_C_DRIVER	BIT(16)
+#define ST_MMC_CCONFIG_A_DRIVER	BIT(12)
+#define ST_MMC_CCONFIG_DDR50	BIT(8)
+#define ST_MMC_CCONFIG_SDR104	BIT(4)
+#define ST_MMC_CCONFIG_SDR50	BIT(0)
+#define ST_MMC_CCONFIG_4_DEFAULT	0
+
+#define ST_MMC_CCONFIG_REG_5		0x410
+#define ST_MMC_CCONFIG_TUNING_FOR_SDR50	BIT(8)
+#define RETUNING_TIMER_CNT_MAX		0xf
+#define ST_MMC_CCONFIG_5_DEFAULT	0
+
+/* I/O configuration for Arasan IP */
+#define	ST_MMC_GP_OUTPUT	0x450
+#define ST_MMC_GP_OUTPUT_CD	BIT(12)
+
+#define ST_MMC_STATUS_R		0x460
+
+#define ST_TOP_MMC_DLY_FIX_OFF(x)	(x - 0x8)
+
+/* TOP config registers to manage static and dynamic delay */
+#define	ST_TOP_MMC_TX_CLK_DLY			ST_TOP_MMC_DLY_FIX_OFF(0x8)
+#define	ST_TOP_MMC_RX_CLK_DLY			ST_TOP_MMC_DLY_FIX_OFF(0xc)
+/* MMC delay control register */
+#define	ST_TOP_MMC_DLY_CTRL			ST_TOP_MMC_DLY_FIX_OFF(0x18)
+#define	ST_TOP_MMC_DLY_CTRL_DLL_BYPASS_CMD	BIT(0)
+#define	ST_TOP_MMC_DLY_CTRL_DLL_BYPASS_PH_SEL	BIT(1)
+#define	ST_TOP_MMC_DLY_CTRL_TX_DLL_ENABLE	BIT(8)
+#define	ST_TOP_MMC_DLY_CTRL_RX_DLL_ENABLE	BIT(9)
+#define	ST_TOP_MMC_DLY_CTRL_ATUNE_NOT_CFG_DLY	BIT(10)
+#define	ST_TOP_MMC_START_DLL_LOCK		BIT(11)
+
+/* register to provide the phase-shift value for DLL */
+#define	ST_TOP_MMC_TX_DLL_STEP_DLY		ST_TOP_MMC_DLY_FIX_OFF(0x1c)
+#define	ST_TOP_MMC_RX_DLL_STEP_DLY		ST_TOP_MMC_DLY_FIX_OFF(0x20)
+#define	ST_TOP_MMC_RX_CMD_STEP_DLY		ST_TOP_MMC_DLY_FIX_OFF(0x24)
+
+/* phase shift delay on the tx clk 2.188ns */
+#define	ST_TOP_MMC_TX_DLL_STEP_DLY_VALID	0x6
+
+#define	ST_TOP_MMC_DLY_MAX			0xf
+
+#define ST_TOP_MMC_DYN_DLY_CONF	\
+		(ST_TOP_MMC_DLY_CTRL_TX_DLL_ENABLE | \
+		 ST_TOP_MMC_DLY_CTRL_ATUNE_NOT_CFG_DLY | \
+		 ST_TOP_MMC_START_DLL_LOCK)
+
 static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
-- 
1.9.1
