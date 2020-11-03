Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03712C00A89
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 03:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE4A2084C
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 03:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKCD1b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 22:27:31 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54607 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKCD1a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Nov 2020 22:27:30 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A33RHV80025174, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A33RHV80025174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 11:27:17 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 11:27:17 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH] misc: rtsx: Fix some bugs and add test mode for rts5261
Date:   Tue, 3 Nov 2020 11:27:15 +0800
Message-ID: <1604374035-2945-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

1.Add force test mode
2.Fix OCP function
3.Use aspm in way of backdoor
4.Fix PAD driving
5.Not support MMC default
6.Support CD&WP reverse
7.Add hardware auto power down when unplug card

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 59 +++++++++++++++++++++++--------
 drivers/misc/cardreader/rts5261.h | 15 ++++----
 drivers/mmc/host/rtsx_pci_sdmmc.c | 20 +++++++++--
 include/linux/rtsx_pci.h          |  7 ++++
 4 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 536c90d4fd76..bf5c6776466d 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -26,16 +26,16 @@ static u8 rts5261_get_ic_version(struct rtsx_pcr *pcr)
 static void rts5261_fill_driving(struct rtsx_pcr *pcr, u8 voltage)
 {
 	u8 driving_3v3[4][3] = {
-		{0x13, 0x13, 0x13},
 		{0x96, 0x96, 0x96},
-		{0x7F, 0x7F, 0x7F},
 		{0x96, 0x96, 0x96},
+		{0x7F, 0x7F, 0x7F},
+		{0x13, 0x13, 0x13},
 	};
 	u8 driving_1v8[4][3] = {
-		{0x99, 0x99, 0x99},
+		{0xB3, 0xB3, 0xB3},
 		{0x3A, 0x3A, 0x3A},
 		{0xE6, 0xE6, 0xE6},
-		{0xB3, 0xB3, 0xB3},
+		{0x99, 0x99, 0x99},
 	};
 	u8 (*driving)[3], drive_sel;
 
@@ -67,12 +67,17 @@ static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 
 	if (!rts5261_vendor_setting_valid(reg)) {
+		/* Not support MMC default */
+		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
 		pcr_dbg(pcr, "skip fetch vendor setting\n");
 		return;
 	}
 
-	pcr->card_drive_sel &= 0x3F;
-	pcr->card_drive_sel |= rts5261_reg_to_card_drive_sel(reg);
+	if (!rts5261_reg_check_mmc_support(reg))
+		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
+
+	/* TO do: need to add rtd3 function */
+	pcr->rtd3_en = rts5261_reg_to_rtd3(reg);
 
 	if (rts5261_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
@@ -171,6 +176,8 @@ static int rts5261_card_power_on(struct rtsx_pcr *pcr, int card)
 	if (option->ocp_en)
 		rtsx_pci_enable_ocp(pcr);
 
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0,
+			CFG_SD_POW_AUTO_PD, CFG_SD_POW_AUTO_PD);
 
 	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG1,
 			RTS5261_LDO1_TUNE_MASK, RTS5261_LDO1_33);
@@ -272,6 +279,9 @@ static void rts5261_enable_ocp(struct rtsx_pcr *pcr)
 	u8 val = 0;
 
 	val = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN);
 	rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
 
 }
@@ -295,6 +305,8 @@ static int rts5261_card_power_off(struct rtsx_pcr *pcr, int card)
 	err = rtsx_pci_write_register(pcr, RTS5261_LDO1233318_POW_CTL,
 				RTS5261_LDO_POWERON_MASK, 0);
 
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0,
+			CFG_SD_POW_AUTO_PD, 0);
 	if (pcr->option.ocp_en)
 		rtsx_pci_disable_ocp(pcr);
 
@@ -340,7 +352,7 @@ static void rts5261_clear_ocpstat(struct rtsx_pcr *pcr)
 
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
 
-	udelay(10);
+	udelay(1000);
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
 
 }
@@ -353,9 +365,9 @@ static void rts5261_process_ocp(struct rtsx_pcr *pcr)
 	rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
 
 	if (pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
+		rts5261_clear_ocpstat(pcr);
 		rts5261_card_power_off(pcr, RTSX_SD_CARD);
 		rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
-		rts5261_clear_ocpstat(pcr);
 		pcr->ocp_stat = 0;
 	}
 
@@ -467,6 +479,7 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
+	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -481,6 +494,10 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 			AUX_CLK_ACTIVE_SEL_MASK, MAC_CKSW_DONE);
 	rtsx_pci_write_register(pcr, L1SUB_CONFIG3, 0xFF, 0);
 
+	if (is_version_higher_than(pcr, PID_5261, IC_VER_B)) {
+		val = rtsx_pci_readl(pcr, RTSX_DUM_REG);
+		rtsx_pci_writel(pcr, RTSX_DUM_REG, val | 0x1);
+	}
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG4,
 			RTS5261_AUX_CLK_16M_EN, 0);
 
@@ -502,6 +519,10 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	/* Configure driving */
 	rts5261_fill_driving(pcr, OUTPUT_3V3);
 
+	if (pcr->flags & PCR_REVERSE_SOCKET)
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x30);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
@@ -513,6 +534,7 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 		rtsx_pci_write_register(pcr, PETXCFG,
 				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
 
+	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
 			FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
@@ -526,22 +548,31 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 
 static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
+	u8 val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+
 	if (pcr->aspm_enabled == enable)
 		return;
 
+	val |= (pcr->aspm_en & 0x02);
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
 	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
 					   PCI_EXP_LNKCTL_ASPMC, pcr->aspm_en);
 	pcr->aspm_enabled = enable;
-
 }
 
 static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
+	u8 val = FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+	u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0 | FORCE_ASPM_CTL1;
+
 	if (pcr->aspm_enabled == enable)
 		return;
 
 	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC, 0);
+		PCI_EXP_LNKCTL_ASPMC, 0);
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
+
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
 	pcr->aspm_enabled = enable;
@@ -618,7 +649,7 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 
 	if (initial_mode) {
 		/* We use 250k(around) here, in initial stage */
-		if (is_version(pcr, PID_5261, IC_VER_D)) {
+		if (is_version_higher_than(pcr, PID_5261, IC_VER_C)) {
 			clk_divider = SD_CLK_DIVIDE_256;
 			card_clock = 60000000;
 		} else {
@@ -669,7 +700,7 @@ int rts5261_pci_switch_clock(struct rtsx_pcr *pcr, unsigned int card_clock,
 		div++;
 	}
 
-	n = (n / 2);
+	n = (n / 2) - 1;
 	pcr_dbg(pcr, "n = %d, div = %d\n", n, div);
 
 	ssc_depth = depth[ssc_depth];
@@ -749,8 +780,8 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 
 	pcr->flags = 0;
 	pcr->card_drive_sel = RTSX_CARD_DRIVE_DEFAULT;
-	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
-	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
+	pcr->sd30_drive_sel_1v8 = 0x00;
+	pcr->sd30_drive_sel_3v3 = 0x00;
 	pcr->aspm_en = ASPM_L1_EN;
 	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index 8d80f0d5d5d6..cd4bdba6ae7e 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -12,11 +12,13 @@
 
 /*New add*/
 #define rts5261_vendor_setting_valid(reg)	((reg) & 0x010000)
-#define rts5261_reg_to_aspm(reg)		(((reg) >> 28) ^ 0x03)
+#define rts5261_reg_to_aspm(reg) \
+	(((~(reg) >> 28) & 0x02) | (((reg) >> 28) & 0x01))
 #define rts5261_reg_check_reverse_socket(reg)	((reg) & 0x04)
-#define rts5261_reg_to_card_drive_sel(reg)	((((reg) >> 6) & 0x01) << 6)
-#define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) ^ 0x03)
-#define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) ^ 0x03)
+#define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) & 0x03)
+#define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) & 0x03)
+#define rts5261_reg_to_rtd3(reg)		((reg) & 0x08)
+#define rts5261_reg_check_mmc_support(reg)	((reg) & 0x10)
 
 
 #define RTS5261_AUTOLOAD_CFG0		0xFF7B
@@ -60,11 +62,6 @@
 /* DMACTL 0xFE2C */
 #define RTS5261_DMA_PACK_SIZE_MASK	0xF0
 
-/* FW config info register */
-#define RTS5261_FW_CFG_INFO0		0xFF50
-#define RTS5261_FW_EXPRESS_TEST_MASK	(0x01<<0)
-#define RTS5261_FW_EA_MODE_MASK		(0x01<<5)
-
 /* FW status register */
 #define RTS5261_FW_STATUS		0xFF56
 #define RTS5261_EXPRESS_LINK_FAIL_MASK	(0x01<<7)
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index c453ad403aa8..6c56b5518bc5 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -47,6 +47,8 @@ struct realtek_pci_sdmmc {
 	bool			using_cookie;
 };
 
+static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
+
 static inline struct device *sdmmc_dev(struct realtek_pci_sdmmc *host)
 {
 	return &(host->pdev->dev);
@@ -898,6 +900,7 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	struct mmc_host *mmc = host->mmc;
 	int err;
 	u32 val;
+	u8 test_mode;
 
 	if (host->power_state == SDMMC_POWER_ON)
 		return 0;
@@ -925,6 +928,15 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 		return err;
 
 	if (PCI_PID(pcr) == PID_5261) {
+		/*
+		 * If test mode is set switch to SD Express mandatorily,
+		 * this is only for factory testing.
+		 */
+		rtsx_pci_read_register(pcr, RTS5261_FW_CFG_INFO0, &test_mode);
+		if (test_mode & RTS5261_FW_EXPRESS_TEST_MASK) {
+			sdmmc_init_sd_express(mmc, NULL);
+			return 0;
+		}
 		if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
 			mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 		/*
@@ -1354,11 +1366,13 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 		RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
 	rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
 		RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+	rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+		RTS5261_MCU_CLOCK_GATING, RTS5261_MCU_CLOCK_GATING);
+
 	rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
 		RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
-		| RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
-		RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
-		| RTS5261_DRIVER_ENABLE_FW);
+		| RTS5261_DRIVER_ENABLE_FW,
+		RTS5261_MCU_CLOCK_SEL_16M | RTS5261_DRIVER_ENABLE_FW);
 	host->eject = true;
 	return 0;
 }
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index b47959f48ccd..d36e96974bce 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -82,6 +82,7 @@
 #define   MS_OC_INT_EN			(1 << 23)
 #define   SD_OC_INT_EN			(1 << 22)
 
+#define RTSX_DUM_REG			0x1C
 
 /*
  * macros for easy use
@@ -658,6 +659,10 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+/* FW config info register */
+#define RTS5261_FW_CFG_INFO0            0xFF50
+#define   RTS5261_FW_EXPRESS_TEST_MASK	(0x01 << 0)
+#define   RTS5261_FW_EA_MODE_MASK	(0x01 << 5)
 #define RTS5261_FW_CFG0			0xFF54
 #define   RTS5261_FW_ENTER_EXPRESS	(0x01 << 0)
 
@@ -1268,6 +1273,8 @@ struct rtsx_pcr {
 #define PCI_PID(pcr)			((pcr)->pci->device)
 #define is_version(pcr, pid, ver)				\
 	(CHK_PCI_PID(pcr, pid) && (pcr)->ic_version == (ver))
+#define is_version_higher_than(pcr, pid, ver)				\
+	(CHK_PCI_PID(pcr, pid) && (pcr)->ic_version > (ver))
 #define pcr_dbg(pcr, fmt, arg...)				\
 	dev_dbg(&(pcr)->pci->dev, fmt, ##arg)
 
-- 
2.17.1

