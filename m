Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17FDC2D0A3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F36D223BD
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCJzC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:55:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39287 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKCJzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:55:01 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39srgiF015344, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39srgiF015344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:54:53 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:54:52 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 4/8] misc: rtsx: Fix PAD driving for RTS5261
Date:   Tue, 3 Nov 2020 17:54:51 +0800
Message-ID: <1604397291-2885-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch fix PAD driving for RTS5261

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 15 ++++++---------
 drivers/misc/cardreader/rts5261.h |  6 ++----
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 3e30e542ef1a..b299e472e87b 100644
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
 
@@ -71,9 +71,6 @@ static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		return;
 	}
 
-	pcr->card_drive_sel &= 0x3F;
-	pcr->card_drive_sel |= rts5261_reg_to_card_drive_sel(reg);
-
 	if (rts5261_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
 
@@ -761,8 +758,8 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 
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
index cb98abb7c935..2e47c798607b 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -15,10 +15,8 @@
 #define rts5261_reg_to_aspm(reg) \
 	(((~(reg) >> 28) & 0x02) | (((reg) >> 28) & 0x01))
 #define rts5261_reg_check_reverse_socket(reg)	((reg) & 0x04)
-#define rts5261_reg_to_card_drive_sel(reg)	((((reg) >> 6) & 0x01) << 6)
-#define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) ^ 0x03)
-#define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) ^ 0x03)
-
+#define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) & 0x03)
+#define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) & 0x03)
 
 #define RTS5261_AUTOLOAD_CFG0		0xFF7B
 #define RTS5261_AUTOLOAD_CFG1		0xFF7C
-- 
2.17.1

