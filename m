Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1A2FFF8D;
	Fri, 24 Apr 2026 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014563; cv=none; b=SMwhMopGd7H7gWhi7bJgFdKWR302ifaH6vIsutfhq+8b3TaMIVvb/gLVG1YUuyWRepKparyatus2l+OHtSHNBOgKJ88iYONTF2yvJ8/I42162PV+0KYtrR+pdKcd4C5Bv1Gz8xLA97q2GfNawxfq3n4CI5fpIDx4JhrZWw1drl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014563; c=relaxed/simple;
	bh=WO/wfk0Son2FQmaJqoMSE4SQR5dXtqHSMo/L20p/Fds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGJaOZiXCc6lS0q1PvGK4/yK4hgacvANPrmJ57hlXZND6vWB5MmyOHKKjFTD1OPL1HF0Ukx5O8F+EXM49+wWIp5Iwbx+EOHZ1KYPurzO2nZjoTvPCLuAmeRKvC9v/xUiFt/oycuJu68B0pQa7GcM1eimz81USY6pMwq8Ec9in0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgDXbHEXF+tpIU8UAA--.15002S2;
	Fri, 24 Apr 2026 15:09:12 +0800 (CST)
From: hehuan1@eswincomputing.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: Fix SDIO support for Eswin EIC7700
Date: Fri, 24 Apr 2026 15:09:07 +0800
Message-Id: <20260424070907.1422-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDXbHEXF+tpIU8UAA--.15002S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWUJw15XF1kJFW5uw48JFb_yoWxGw4fpF
	4rCryfKFWUtF45CrZ7AayDAw1Iqa1SgFZrKF93K3WftanFyryjqasrCa4UtFWDJry8G3yY
	ga1UXrn8Cr9rAaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1oUDtUUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

The EIC7700 code in sdhci-of-dwcmshc uses host->mmc->caps2 to select
different configuration paths for different card types. The current logic
distinguishes eMMC and SD, but does not handle SDIO separately.

Update the EIC7700 card-type checks so that eMMC, SD and SDIO are
distinguished explicitly.

Switch the reset path to dwcmshc_reset() so that pending interrupt state
is cleared consistently, and use sdhci_enable_clk() so the clock enable
sequence follows the standard SDHCI flow.

Fixes: 32b2633219d3 ("mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700")
Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 45 +++++++++++++++--------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 0b2158a7e409..0c1b39d48502 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -277,6 +277,7 @@
 #define PHY_DELAY_CODE_MAX		0x7f
 #define PHY_DELAY_CODE_EMMC		0x17
 #define PHY_DELAY_CODE_SD		0x55
+#define PHY_DELAY_CODE_SDIO		0x29
 
 struct rk35xx_priv {
 	struct reset_control *reset;
@@ -1433,10 +1434,7 @@ static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk_set_rate(pltfm_host->clk, clock);
 
 	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	clk |= SDHCI_CLOCK_INT_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-	dwcmshc_enable_card_clk(host);
+	sdhci_enable_clk(host, clk);
 }
 
 static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int delay)
@@ -1497,7 +1495,7 @@ static void sdhci_eic7700_config_phy(struct sdhci_host *host)
 
 static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
 {
-	sdhci_reset(host, mask);
+	dwcmshc_reset(host, mask);
 
 	/* after reset all, the phy's config will be clear */
 	if (mask == SDHCI_RESET_ALL)
@@ -1594,18 +1592,18 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 	int phase_code = -1;
 	int code_range = -1;
-	bool is_sd = false;
+	bool is_non_emmc = false;
 	int code_min = -1;
 	int code_max = -1;
 	int cmd_error = 0;
 	int ret = 0;
 	int i = 0;
 
-	if ((host->mmc->caps2 & sd_caps) == sd_caps)
-		is_sd = true;
+	if ((host->mmc->caps2 & emmc_caps) != emmc_caps)
+		is_non_emmc = true;
 
 	for (i = 0; i <= MAX_PHASE_CODE; i++) {
 		/* Centered Phase code */
@@ -1614,8 +1612,8 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
 		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
 		if (ret) {
-			/* SD specific range tracking */
-			if (is_sd && code_min != -1 && code_max != -1) {
+			/* SD/SDIO specific range tracking */
+			if (is_non_emmc && code_min != -1 && code_max != -1) {
 				if (code_max - code_min > code_range) {
 					code_range = code_max - code_min;
 					phase_code = (code_min + code_max) / 2;
@@ -1626,17 +1624,17 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
 				code_max = -1;
 			}
 			/* EMMC breaks after first valid range */
-			if (!is_sd && code_min != -1 && code_max != -1)
+			if (!is_non_emmc && code_min != -1 && code_max != -1)
 				break;
 		} else {
 			/* Track valid phase code range */
 			if (code_min == -1) {
 				code_min = i;
-				if (!is_sd)
+				if (!is_non_emmc)
 					continue;
 			}
 			code_max = i;
-			if (is_sd && i == MAX_PHASE_CODE) {
+			if (is_non_emmc && i == MAX_PHASE_CODE) {
 				if (code_max - code_min > code_range) {
 					code_range = code_max - code_min;
 					phase_code = (code_min + code_max) / 2;
@@ -1646,19 +1644,19 @@ static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
 	}
 
 	/* Handle tuning failure case */
-	if ((is_sd && phase_code == -1) ||
-	    (!is_sd && code_min == -1 && code_max == -1)) {
+	if ((is_non_emmc && phase_code == -1) ||
+	    (!is_non_emmc && code_min == -1 && code_max == -1)) {
 		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
 		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
 		return -EIO;
 	}
-	if (!is_sd)
+	if (!is_non_emmc)
 		phase_code = (code_min + code_max) / 2;
 
 	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
 
-	/* SD specific final verification */
-	if (is_sd) {
+	/* SD/SDIO specific final verification */
+	if (is_non_emmc) {
 		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
 		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 		if (ret) {
@@ -1756,9 +1754,9 @@ static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned in
 
 static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int timing)
 {
-	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
+	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 
-	if ((host->mmc->caps2 & sd_caps) == sd_caps)
+	if ((host->mmc->caps2 & emmc_caps) != emmc_caps)
 		sdhci_set_uhs_signaling(host, timing);
 	else
 		sdhci_eic7700_set_uhs_signaling(host, timing);
@@ -1767,6 +1765,7 @@ static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int
 static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
 	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
+	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
 	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
 	static const char * const clk_ids[] = {"axi"};
 	struct of_phandle_args args;
@@ -1821,8 +1820,10 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 
 	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
 		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
-	else
+	else if ((host->mmc->caps2 & sd_caps) == sd_caps)
 		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
+	else
+		dwc_priv->delay_line = PHY_DELAY_CODE_SDIO;
 
 	if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-ohms", &val))
 		priv->drive_impedance = eic7700_convert_drive_impedance_ohm(dev, val);
-- 
2.34.1

