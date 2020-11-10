Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B59C5517A
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 07:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06AF206B6
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgKJHWz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 02:22:55 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59466 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgKJHWz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Nov 2020 02:22:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 19C551A0277;
        Tue, 10 Nov 2020 08:22:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0F44A1A00E9;
        Tue, 10 Nov 2020 08:22:52 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EACF7402B7;
        Tue, 10 Nov 2020 08:22:48 +0100 (CET)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org
Cc:     Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-esdhc: handle pulse width detection erratum for more SoCs
Date:   Tue, 10 Nov 2020 15:13:14 +0800
Message-Id: <20201110071314.3868-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Apply erratum workaround of unreliable pulse width detection to
more affected platforms (LX2160A Rev2.0 and LS1028A Rev1.0).

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index bb09445..ab5ab96 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1324,6 +1324,8 @@ static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
 
 static struct soc_device_attribute soc_unreliable_pulse_detection[] = {
 	{ .family = "QorIQ LX2160A", .revision = "1.0", },
+	{ .family = "QorIQ LX2160A", .revision = "2.0", },
+	{ .family = "QorIQ LS1028A", .revision = "1.0", },
 	{ },
 };
 
-- 
2.7.4

