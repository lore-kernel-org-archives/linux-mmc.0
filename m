Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900AAC43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 03:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE562467A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 03:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPDTh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:19:37 -0500
Received: from inva020.nxp.com ([92.121.34.13]:58834 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfLPDTh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Dec 2019 22:19:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 194B71A179D;
        Mon, 16 Dec 2019 04:19:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 824261A057A;
        Mon, 16 Dec 2019 04:19:33 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F35D84028F;
        Mon, 16 Dec 2019 11:19:29 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH] mmc: sdhci-of-esdhc: fix P2020 errata handling
Date:   Mon, 16 Dec 2019 11:18:42 +0800
Message-Id: <20191216031842.40068-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Two previous patches introduced below quirks for P2020 platforms.
- SDHCI_QUIRK_RESET_AFTER_REQUEST
- SDHCI_QUIRK_BROKEN_TIMEOUT_VAL

The patches made a mistake to add them in quirks2 of sdhci_host
structure, while they were defined for quirks.
	host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
	host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

This patch is to fix them.
	host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

Fixes: 05cb6b2a66fa ("mmc: sdhci-of-esdhc: add erratum eSDHC-A001 and A-008358 support")
Fixes: a46e42712596 ("mmc: sdhci-of-esdhc: add erratum eSDHC5 support")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7f87a90..4ca640e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1300,8 +1300,8 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 
 	if (of_find_compatible_node(NULL, NULL, "fsl,p2020-esdhc")) {
-		host->quirks2 |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
-		host->quirks2 |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+		host->quirks |= SDHCI_QUIRK_RESET_AFTER_REQUEST;
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 	}
 
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
-- 
2.7.4

