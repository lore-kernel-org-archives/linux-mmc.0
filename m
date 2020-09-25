Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89E2C4346E
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 02:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA4120BED
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 02:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIYCIB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 22:08:01 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59024 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIYCIA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 22:08:00 -0400
X-Greylist: delayed 665 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 22:08:00 EDT
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P1vhAfB002096, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P1vhAfB002096
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 09:57:43 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Fri, 25 Sep 2020
 09:57:42 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 3/3] mmc: rtsx: Add SD Express mode support for RTS5261
Date:   Fri, 25 Sep 2020 09:57:41 +0800
Message-ID: <1600999061-13669-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

RTS5261 support legacy SD mode and SD Express mode.
In SD7.x, SD association introduce SD Express as a new mode.
This patch makes RTS5261 support SD Express mode.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 59 +++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 2763a376b054..efde374a4a5e 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -895,7 +895,9 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
 static int sd_power_on(struct realtek_pci_sdmmc *host)
 {
 	struct rtsx_pcr *pcr = host->pcr;
+	struct mmc_host *mmc = host->mmc;
 	int err;
+	u32 val;
 
 	if (host->power_state == SDMMC_POWER_ON)
 		return 0;
@@ -922,6 +924,14 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
 	if (err < 0)
 		return err;
 
+	if (PCI_PID(pcr) == PID_5261) {
+		val = rtsx_pci_readl(pcr, RTSX_BIPR);
+		if (val & SD_WRITE_PROTECT) {
+			pcr->extra_caps &= ~EXTRA_CAPS_SD_EXPRESS;
+			mmc->caps2 &= ~(MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V);
+		}
+	}
+
 	host->power_state = SDMMC_POWER_ON;
 	return 0;
 }
@@ -1127,6 +1137,8 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	if (val & SD_EXIST)
 		cd = 1;
 
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 	mutex_unlock(&pcr->pcr_mutex);
 
 	return cd;
@@ -1308,6 +1320,50 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
+static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	u32 relink_time, val;
+	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
+	struct rtsx_pcr *pcr = host->pcr;
+
+	/*
+	 * If card has PCIe availability and WP if off,
+	 * reader switch to PCIe mode.
+	 */
+	val = rtsx_pci_readl(pcr, RTSX_BIPR);
+	if (!(val & SD_WRITE_PROTECT)) {
+		/* Set relink_time for changing to PCIe card */
+		relink_time = 0x8FFF;
+
+		rtsx_pci_write_register(pcr, 0xFF01, 0xFF, relink_time);
+		rtsx_pci_write_register(pcr, 0xFF02, 0xFF, relink_time >> 8);
+		rtsx_pci_write_register(pcr, 0xFF03, 0x01, relink_time >> 16);
+
+		rtsx_pci_write_register(pcr, PETXCFG, 0x80, 0x80);
+		rtsx_pci_write_register(pcr, LDO_VCC_CFG0,
+			RTS5261_LDO1_OCP_THD_MASK,
+			pcr->option.sd_800mA_ocp_thd);
+
+		if (pcr->ops->disable_auto_blink)
+			pcr->ops->disable_auto_blink(pcr);
+
+		/* For PCIe/NVMe mode can't enter delink issue */
+		pcr->hw_param.interrupt_en &= ~(SD_INT_EN);
+		rtsx_pci_writel(pcr, RTSX_BIER, pcr->hw_param.interrupt_en);
+
+		rtsx_pci_write_register(pcr, RTS5260_AUTOLOAD_CFG4,
+			RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
+			RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+		rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+			RTS5261_MCU_BUS_SEL_MASK | RTS5261_MCU_CLOCK_SEL_MASK
+			| RTS5261_MCU_CLOCK_GATING | RTS5261_DRIVER_ENABLE_FW,
+			RTS5261_MCU_CLOCK_SEL_16M | RTS5261_MCU_CLOCK_GATING
+			| RTS5261_DRIVER_ENABLE_FW);
+	}
+	return 0;
+}
+
 static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.pre_req = sdmmc_pre_req,
 	.post_req = sdmmc_post_req,
@@ -1317,6 +1373,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
 	.get_cd = sdmmc_get_cd,
 	.start_signal_voltage_switch = sdmmc_switch_voltage,
 	.execute_tuning = sdmmc_execute_tuning,
+	.init_sd_express = sdmmc_init_sd_express,
 };
 
 static void init_extra_caps(struct realtek_pci_sdmmc *host)
@@ -1338,6 +1395,8 @@ static void init_extra_caps(struct realtek_pci_sdmmc *host)
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
 	if (pcr->extra_caps & EXTRA_CAPS_NO_MMC)
 		mmc->caps2 |= MMC_CAP2_NO_MMC;
+	if (pcr->extra_caps & EXTRA_CAPS_SD_EXPRESS)
+		mmc->caps2 |= MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 }
 
 static void realtek_init_host(struct realtek_pci_sdmmc *host)
-- 
2.17.1

