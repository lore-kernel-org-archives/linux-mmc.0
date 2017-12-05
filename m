From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFT 2/3] mmc: renesas_sdhi: Add eMMC HS400 mode support
Date: Tue,  5 Dec 2017 13:37:55 +0100
Message-ID: <20171205123756.18424-3-horms+renesas@verge.net.au>
References: <20171205123756.18424-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171205123756.18424-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add eMMC HS400 support to SDHI driver.

In this mode of operation tuning uses 4 taps rather than 8 on
hardware currently supported in mainline.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v1 [Simon Horman]
- Combined patched by Ai Kyuse and Masaharu Hayakawa
- Rebase

v0 [Ai Kyuse]
---
 drivers/mmc/host/renesas_sdhi_core.c | 123 ++++++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index fcf7235d5742..73b963e506ab 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -223,6 +223,7 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_CKSEL	0x006
 #define SH_MOBILE_SDHI_SCC_RVSCNTL	0x008
 #define SH_MOBILE_SDHI_SCC_RVSREQ	0x00A
+#define SH_MOBILE_SDHI_SCC_TMPPORT2	0x00E
 
 /* Definitions for values the SH_MOBILE_SDHI_SCC_DTCNTL register */
 #define SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN		BIT(0)
@@ -235,6 +236,9 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN	BIT(0)
 /* Definitions for values the SH_MOBILE_SDHI_SCC_RVSREQ register */
 #define SH_MOBILE_SDHI_SCC_RVSREQ_RVSERR	BIT(2)
+/* Definitions for values the SH_MOBILE_SDHI_SCC_TMPPORT2 register */
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
+#define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 
 static inline u32 sd_scc_read32(struct tmio_mmc_host *host,
 				struct renesas_sdhi *priv, int addr)
@@ -249,39 +253,57 @@ static inline void sd_scc_write32(struct tmio_mmc_host *host,
 	writel(val, priv->scc_ctl + (addr << host->bus_shift));
 }
 
+
+static void renesas_sdhi_disable_scc(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+	sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
+		       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+		       ~SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN &
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+	sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+}
+
 static unsigned int renesas_sdhi_init_tuning(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv;
 
 	priv = host_to_priv(host);
 
-	/* set sampling clock selection range */
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
-		       0x8 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
-
 	/* Initialize SCC */
 	sd_ctrl_write32_as_16_and_16(host, CTL_STATUS, 0x0);
 
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
-		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
-		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL));
-
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
+	/* set sampling clock selection range */
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
+		       0x8 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
 		       SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
 
-	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
-			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
-
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
 		       ~SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
 
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, host->scc_tappos);
 
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
 	/* Read TAPNUM */
 	return (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL) >>
 		SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT) &
@@ -297,13 +319,69 @@ static void renesas_sdhi_prepare_tuning(struct tmio_mmc_host *host,
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap);
 }
 
+static void renesas_sdhi_prepare_hs400_tuning(struct mmc_host *mmc,
+					struct mmc_ios *ios)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* Set HS400 mode */
+	sd_ctrl_write16(host, CTL_SDIF_MODE, 0x0001 |
+			sd_ctrl_read16(host, CTL_SDIF_MODE));
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
+		       SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+		       SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL |
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+
+
+	/* HS400 mode sets sampling clock selection range to 4 */
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DTCNTL,
+		       SH_MOBILE_SDHI_SCC_DTCNTL_TAPEN |
+		       0x4 << SH_MOBILE_SDHI_SCC_DTCNTL_TAPNUM_SHIFT);
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET,
+		       host->tap_set / 2);
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL,
+		       SH_MOBILE_SDHI_SCC_CKSEL_DTSEL |
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+}
+
+static void renesas_sdhi_reset_hs400_mode(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct renesas_sdhi *priv = host_to_priv(host);
+
+	if (!priv->scc_ctl)
+		return;
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+
+	/* Reset HS400 mode */
+	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
+			sd_ctrl_read16(host, CTL_SDIF_MODE));
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
+		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
+}
+
 #define SH_MOBILE_SDHI_MAX_TAP 3
 
 static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 	unsigned long tap_cnt;  /* counter of tuning success */
-	unsigned long tap_set;  /* tap position */
 	unsigned long tap_start;/* start position of tuning success */
 	unsigned long tap_end;  /* end position of tuning success */
 	unsigned long ntap;     /* temporary counter of tuning success */
@@ -341,12 +419,12 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	}
 
 	if (tap_cnt >= SH_MOBILE_SDHI_MAX_TAP)
-		tap_set = (tap_start + tap_end) / 2 % host->tap_num;
+		host->tap_set = (tap_start + tap_end) / 2 % host->tap_num;
 	else
 		return -EIO;
 
 	/* Set SCC */
-	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, tap_set);
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TAPSET, host->tap_set);
 
 	/* Enable auto re-tuning */
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL,
@@ -387,6 +465,14 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
 		       ~SH_MOBILE_SDHI_SCC_CKSEL_DTSEL &
 		       sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_CKSEL));
 
+	/* Reset HS400 mode */
+	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
+			sd_ctrl_read16(host, CTL_SDIF_MODE));
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
+			~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
+			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
+			sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2));
+
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
 			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 
@@ -597,7 +683,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* Enable tuning iff we have an SCC and a supported mode */
 	if (of_data && of_data->scc_offset &&
 	    (host->mmc->caps & MMC_CAP_UHS_SDR104 ||
-	     host->mmc->caps2 & MMC_CAP2_HS200_1_8V_SDR)) {
+	     host->mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR |
+				 MMC_CAP2_HS400_1_8V))) {
 		const struct renesas_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
@@ -619,8 +706,12 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->init_tuning = renesas_sdhi_init_tuning;
 		host->prepare_tuning = renesas_sdhi_prepare_tuning;
 		host->select_tuning = renesas_sdhi_select_tuning;
-		host->check_scc_error = renesas_sdhi_check_scc_error;
+		if (!(host->mmc->caps2 & MMC_CAP2_HS400_1_8V))
+			host->check_scc_error = renesas_sdhi_check_scc_error;
 		host->hw_reset = renesas_sdhi_hw_reset;
+		host->disable_scc = renesas_sdhi_disable_scc;
+		host->prepare_hs400_tuning = renesas_sdhi_prepare_hs400_tuning;
+		host->reset_hs400_mode = renesas_sdhi_reset_hs400_mode;
 	}
 
 	i = 0;
-- 
2.11.0
