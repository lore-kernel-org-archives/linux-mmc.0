Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432E8C2D0A3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3769223BD
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgKCJzN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:55:13 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39302 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgKCJzN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:55:13 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39t07j9015353, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39t07j9015353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:55:00 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:54:59 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 5/8] misc: rtsx: Check mmc support for RTS5261
Date:   Tue, 3 Nov 2020 17:54:58 +0800
Message-ID: <1604397298-2921-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch check mmc support when RTS5261 initialize,
and not support mmc default.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 8 ++++++++
 drivers/misc/cardreader/rts5261.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index b299e472e87b..ce65c5703453 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -67,10 +67,18 @@ static void rtsx5261_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	pcr_dbg(pcr, "Cfg 0x%x: 0x%x\n", PCR_SETTING_REG2, reg);
 
 	if (!rts5261_vendor_setting_valid(reg)) {
+		/* Not support MMC default */
+		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
 		pcr_dbg(pcr, "skip fetch vendor setting\n");
 		return;
 	}
 
+	if (!rts5261_reg_check_mmc_support(reg))
+		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
+
+	/* TO do: need to add rtd3 function */
+	pcr->rtd3_en = rts5261_reg_to_rtd3(reg);
+
 	if (rts5261_reg_check_reverse_socket(reg))
 		pcr->flags |= PCR_REVERSE_SOCKET;
 
diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
index 2e47c798607b..2344c560a637 100644
--- a/drivers/misc/cardreader/rts5261.h
+++ b/drivers/misc/cardreader/rts5261.h
@@ -17,6 +17,8 @@
 #define rts5261_reg_check_reverse_socket(reg)	((reg) & 0x04)
 #define rts5261_reg_to_sd30_drive_sel_1v8(reg)	(((reg) >> 22) & 0x03)
 #define rts5261_reg_to_sd30_drive_sel_3v3(reg)	(((reg) >> 16) & 0x03)
+#define rts5261_reg_to_rtd3(reg)		((reg) & 0x08)
+#define rts5261_reg_check_mmc_support(reg)	((reg) & 0x10)
 
 #define RTS5261_AUTOLOAD_CFG0		0xFF7B
 #define RTS5261_AUTOLOAD_CFG1		0xFF7C
-- 
2.17.1

