Return-Path: <SRS0=NXY1=EJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011AC388F2
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19DE2080C
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Nov 2020 09:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgKCJyu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Nov 2020 04:54:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39269 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgKCJyt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2020 04:54:49 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A39seWpB015332, This message is accepted by code: ctloc85258
Received: from RSEXMBS01.realsil.com.cn ([172.29.17.195])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A39seWpB015332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 3 Nov 2020 17:54:40 +0800
Received: from localhost (172.29.40.150) by RSEXMBS01.realsil.com.cn
 (172.29.17.195) with Microsoft SMTP Server id 15.1.2044.4; Tue, 3 Nov 2020
 17:54:40 +0800
From:   <rui_feng@realsil.com.cn>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ulf.hansson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 2/8] misc: rtsx: Fix OCP function for RTS5261
Date:   Tue, 3 Nov 2020 17:54:38 +0800
Message-ID: <1604397278-2815-1-git-send-email-rui_feng@realsil.com.cn>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.29.40.150]
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rui Feng <rui_feng@realsil.com.cn>

This patch fix the bug that when there is over current but
reader can't enable OCP.

Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
---
 drivers/misc/cardreader/rts5261.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 536c90d4fd76..531bbaed7a12 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -272,6 +272,9 @@ static void rts5261_enable_ocp(struct rtsx_pcr *pcr)
 	u8 val = 0;
 
 	val = SD_OCP_INT_EN | SD_DETECT_EN;
+	rtsx_pci_write_register(pcr, RTS5261_LDO1_CFG0,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN,
+			RTS5261_LDO1_OCP_EN | RTS5261_LDO1_OCP_LMT_EN);
 	rtsx_pci_write_register(pcr, REG_OCPCTL, 0xFF, val);
 
 }
@@ -340,7 +343,7 @@ static void rts5261_clear_ocpstat(struct rtsx_pcr *pcr)
 
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, val);
 
-	udelay(10);
+	udelay(1000);
 	rtsx_pci_write_register(pcr, REG_OCPCTL, mask, 0);
 
 }
@@ -353,9 +356,9 @@ static void rts5261_process_ocp(struct rtsx_pcr *pcr)
 	rtsx_pci_get_ocpstat(pcr, &pcr->ocp_stat);
 
 	if (pcr->ocp_stat & (SD_OC_NOW | SD_OC_EVER)) {
+		rts5261_clear_ocpstat(pcr);
 		rts5261_card_power_off(pcr, RTSX_SD_CARD);
 		rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, 0);
-		rts5261_clear_ocpstat(pcr);
 		pcr->ocp_stat = 0;
 	}
 
@@ -513,6 +516,7 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 		rtsx_pci_write_register(pcr, PETXCFG,
 				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
 
+	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
 			FORCE_PM_CONTROL | FORCE_PM_VALUE, FORCE_PM_CONTROL);
-- 
2.17.1

