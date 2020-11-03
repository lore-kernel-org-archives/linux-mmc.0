Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50BEC4742C
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAB421556
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgKCJzZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:55:25 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39322 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgKCJzY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:55:24 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39tD5n9015391, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39tD5n9015391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:55:14 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:55:13 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 7/8] misc: rtsx: Add hardware auto power off for RTS5261
Date:   Tue, 3 Nov 2020 17:55:12 +0800
Message-ID: <1604397312-2991-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch enable hardware auto power off when card is removed.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 9 +++++++++
 include/linux/rtsx_pci.h          | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 0ef6b3e04a8d..2ada973a0f33 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -176,6 +176,8 @@ static int rts5261_card_power_on(struct rtsx_pcr *pcr, int card)
 	if (option->ocp_en)
 		rtsx_pci_enable_ocp(pcr);
 
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0,
+		CFG_SD_POW_AUTO_PD, CFG_SD_POW_AUTO_PD);
 
 	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG1,
 			RTS5261_LDO1_TUNE_MASK, RTS5261_LDO1_33);
@@ -303,6 +305,8 @@ static int rts5261_card_power_off(struct rtsx_pcr *pcr, int card)
 	err = rtsx_pci_write_register(pcr, RTS5261_LDO1233318_POW_CTL,
 				RTS5261_LDO_POWERON_MASK, 0);
 
+	rtsx_pci_write_register(pcr, REG_CRC_DUMMY_0,
+		CFG_SD_POW_AUTO_PD, 0);
 	if (pcr->option.ocp_en)
 		rtsx_pci_disable_ocp(pcr);
 
@@ -475,6 +479,7 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
+	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -489,6 +494,10 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 			AUX_CLK_ACTIVE_SEL_MASK, MAC_CKSW_DONE);
 	rtsx_pci_write_register(pcr, L1SUB_CONFIG3, 0xFF, 0);
 
+	if (is_version_higher_than(pcr, PID_5261, IC_VER_B)) {
+		val = rtsx_pci_readl(pcr, RTSX_DUM_REG);
+		rtsx_pci_writel(pcr, RTSX_DUM_REG, val | 0x1);
+	}
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG4,
 			RTS5261_AUX_CLK_16M_EN, 0);
 
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index db249e8707f3..fcaadc7c9df1 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -82,6 +82,7 @@
 #define   MS_OC_INT_EN			(1 << 23)
 #define   SD_OC_INT_EN			(1 << 22)
 
+#define RTSX_DUM_REG			0x1C
 
 /*
  * macros for easy use
@@ -1272,6 +1273,8 @@ struct rtsx_pcr {
 #define PCI_PID(pcr)			((pcr)->pci->device)
 #define is_version(pcr, pid, ver)				\
 	(CHK_PCI_PID(pcr, pid) && (pcr)->ic_version == (ver))
+#define is_version_higher_than(pcr, pid, ver)			\
+	(CHK_PCI_PID(pcr, pid) && (pcr)->ic_version > (ver))
 #define pcr_dbg(pcr, fmt, arg...)				\
 	dev_dbg(&(pcr)->pci->dev, fmt, ##arg)
 
-- 
2.17.1

