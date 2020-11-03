Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82C8C388F2
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F382223BD
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgKCJyz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:54:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39276 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCJyy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:54:54 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39skozF015340, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39skozF015340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:54:47 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:54:46 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 3/8] misc: rtsx: Fix aspm for RTS5261
Date:   Tue, 3 Nov 2020 17:54:45 +0800
Message-ID: <1604397285-2850-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch fix the bug that LDO is off when aspm is enabled.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 10 +++++++++-
 drivers/misc/cardreader/rts5261.h |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 531bbaed7a12..3e30e542ef1a 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -530,22 +530,30 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 
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
 					   PCI_EXP_LNKCTL_ASPMC, 0);
+	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
 	pcr->aspm_enabled = enable;
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index 80179353bc46..cb98abb7c935 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -12,7 +12,8 @@
 
 /*New add*/
 #define rts5261_vendor_setting_valid(reg)	((reg) & 0x010000)
-#define rts5261_reg_to_aspm(reg)		(((reg) >> 28) ^ 0x03)
+#define rts5261_reg_to_aspm(reg) \
+	(((~(reg) >> 28) & 0x02) | (((reg) >> 28) & 0x01))
 #define rts5261_reg_check_reverse_socket(reg)	((reg) & 0x04)
 #define rts5261_reg_to_card_drive_sel(reg)	((((reg) >> 6) & 0x01) << 6)
 #define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) ^ 0x03)
-- 
2.17.1

