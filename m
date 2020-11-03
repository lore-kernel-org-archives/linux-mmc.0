Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6BBC2D0A3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F312080C
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgKCJyo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:54:44 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39260 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCJyn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:54:43 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39sVo75015308, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39sVo75015308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:54:31 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:54:30 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 1/8] mmc: rtsx: Add test mode for RTS5261
Date:   Tue, 3 Nov 2020 17:54:29 +0800
Message-ID: <1604397269-2780-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch add test mode for RTS5261.
If test mode is set, reader will switch to SD Express mode
mandatorily, and this mode is used by factory testing only.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.h |  5 -----
 drivers/mmc/host/rtsx_pci_sdmmc.c | 19 ++++++++++++++++---
 include/linux/rtsx_pci.h          |  4 ++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index 8d80f0d5d5d6..80179353bc46 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -60,11 +60,6 @@
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
index c453ad403aa8..26be11a096cb 100644
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
@@ -1354,11 +1366,12 @@ static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
 		RTS5261_AUX_CLK_16M_EN, RTS5261_AUX_CLK_16M_EN);
 	rtsx_pci_write_register(pcr, RTS5261_FW_CFG0,
 		RTS5261_FW_ENTER_EXPRESS, RTS5261_FW_ENTER_EXPRESS);
+	rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
+		RTS5261_MCU_CLOCK_GATING, RTS5261_MCU_CLOCK_GATING);
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
index b47959f48ccd..db249e8707f3 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -658,6 +658,10 @@
 #define   PM_WAKE_EN			0x01
 #define PM_CTRL4			0xFF47
 
+/* FW config info register */
+#define RTS5261_FW_CFG_INFO0		0xFF50
+#define   RTS5261_FW_EXPRESS_TEST_MASK	(0x01 << 0)
+#define   RTS5261_FW_EA_MODE_MASK	(0x01 << 5)
 #define RTS5261_FW_CFG0			0xFF54
 #define   RTS5261_FW_ENTER_EXPRESS	(0x01 << 0)
 
-- 
2.17.1

