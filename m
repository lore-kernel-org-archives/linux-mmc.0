Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F1C10DCE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 02:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B9206BE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 02:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgCPCwv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:52:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38530 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgCPCwv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Mar 2020 22:52:51 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02G2qeMr008854, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02G2qeMr008854
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 10:52:40 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 16 Mar 2020 10:52:39 +0800
Received: from localhost (172.22.88.222) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 16 Mar
 2020 10:52:39 +0800
From:   <ricky_wu@realtek.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     Ricky Wu <ricky_wu@realtek.com>
Subject: [PATCH] mmc: rtsx: Fixed TX/RX register and optimized TX parameter
Date:   Mon, 16 Mar 2020 10:52:32 +0800
Message-ID: <20200316025232.1167-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

Fixed sd_change_phase TX/RX register
Optimized rts522a rts524a rts525a rts5260 rts5261 TX initial parameter

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5227.c |  2 +-
 drivers/misc/cardreader/rts5249.c |  2 ++
 drivers/misc/cardreader/rts5260.c |  2 +-
 drivers/misc/cardreader/rts5261.c |  2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c | 13 ++++++++-----
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 4feed296a327..423fecc19fc4 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -394,7 +394,7 @@ static const struct pcr_ops rts522a_pcr_ops = {
 void rts522a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5227_init_params(pcr);
-
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 20, 11);
 	pcr->reg_pm_ctrl3 = RTS522A_PM_CTRL3;
 
 	pcr->option.ocp_en = 1;
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index db936e4d6e56..1a81cda948c1 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -618,6 +618,7 @@ static const struct pcr_ops rts524a_pcr_ops = {
 void rts524a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5249_init_params(pcr);
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
 	pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
 	pcr->option.ltr_l1off_snooze_sspwrgate =
 		LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
@@ -733,6 +734,7 @@ static const struct pcr_ops rts525a_pcr_ops = {
 void rts525a_init_params(struct rtsx_pcr *pcr)
 {
 	rts5249_init_params(pcr);
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(25, 29, 11);
 	pcr->option.ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
 	pcr->option.ltr_l1off_snooze_sspwrgate =
 		LTR_L1OFF_SNOOZE_SSPWRGATE_5250_DEF;
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 4214f02a17fd..711054ebad74 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -662,7 +662,7 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
-	pcr->tx_initial_phase = SET_CLOCK_PHASE(1, 29, 16);
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 29, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
 	pcr->ic_version = rts5260_get_ic_version(pcr);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index bc4967a6efa1..78c3b1d424c3 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -764,7 +764,7 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	pcr->sd30_drive_sel_1v8 = CFG_DRIVER_TYPE_B;
 	pcr->sd30_drive_sel_3v3 = CFG_DRIVER_TYPE_B;
 	pcr->aspm_en = ASPM_L1_EN;
-	pcr->tx_initial_phase = SET_CLOCK_PHASE(20, 27, 16);
+	pcr->tx_initial_phase = SET_CLOCK_PHASE(27, 27, 11);
 	pcr->rx_initial_phase = SET_CLOCK_PHASE(24, 6, 5);
 
 	pcr->ic_version = rts5261_get_ic_version(pcr);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index bd50935dc37d..11087976ab19 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -606,19 +606,22 @@ static int sd_change_phase(struct realtek_pci_sdmmc *host,
 		u8 sample_point, bool rx)
 {
 	struct rtsx_pcr *pcr = host->pcr;
-
+	u16 SD_VP_CTL = 0;
 	dev_dbg(sdmmc_dev(host), "%s(%s): sample_point = %d\n",
 			__func__, rx ? "RX" : "TX", sample_point);
 
 	rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, CHANGE_CLK);
-	if (rx)
+	if (rx) {
+		SD_VP_CTL = SD_VPRX_CTL;
 		rtsx_pci_write_register(pcr, SD_VPRX_CTL,
 			PHASE_SELECT_MASK, sample_point);
-	else
+	} else {
+		SD_VP_CTL = SD_VPTX_CTL;
 		rtsx_pci_write_register(pcr, SD_VPTX_CTL,
 			PHASE_SELECT_MASK, sample_point);
-	rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET, 0);
-	rtsx_pci_write_register(pcr, SD_VPCLK0_CTL, PHASE_NOT_RESET,
+	}
+	rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET, 0);
+	rtsx_pci_write_register(pcr, SD_VP_CTL, PHASE_NOT_RESET,
 				PHASE_NOT_RESET);
 	rtsx_pci_write_register(pcr, CLK_CTL, CHANGE_CLK, 0);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
-- 
2.17.1

