Return-Path: <SRS0=jIX3=EI=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C178C00A89
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13AB221FF
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Nov 2020 07:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgKBH0j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Nov 2020 02:26:39 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35052 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgKBH0j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 2 Nov 2020 02:26:39 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B5F511A13F2;
        Mon,  2 Nov 2020 08:26:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE0FF1A1424;
        Mon,  2 Nov 2020 08:26:35 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DB9334029C;
        Mon,  2 Nov 2020 08:26:32 +0100 (CET)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: export sd3_bus_mode to user space
Date:   Mon,  2 Nov 2020 15:17:15 +0800
Message-Id: <20201102071715.18057-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There was no way for user to know what UHS-I modes the SD card
supporting. We might not know, even the highest speed mode
failed to use and fell back to a lower speed mode.

This patch is to export sd3_bus_mode to user space to check.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/core/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f054c4..13409c2 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -689,6 +689,7 @@ MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
+MMC_DEV_ATTR(sd3_bus_mode, "0x%08x\n", card->sw_caps.sd3_bus_mode);
 
 
 static ssize_t mmc_dsr_show(struct device *dev,
@@ -753,6 +754,7 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_ocr.attr,
 	&dev_attr_rca.attr,
 	&dev_attr_dsr.attr,
+	&dev_attr_sd3_bus_mode.attr,
 	NULL,
 };
 
-- 
2.7.4

