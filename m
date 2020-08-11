Return-Path: <SRS0=iZb8=BV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32994C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 08:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18431206C3
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Aug 2020 08:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgHKIml (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:42:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46332 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgHKIml (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 11 Aug 2020 04:42:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 575252007D2;
        Tue, 11 Aug 2020 10:42:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AE6720022E;
        Tue, 11 Aug 2020 10:42:35 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9DCB340243;
        Tue, 11 Aug 2020 10:42:30 +0200 (CEST)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: [PATCH v2] mmc: host: sdhci-esdhc-imx: reset usdhc before sending tuning command for manual tuning method
Date:   Tue, 11 Aug 2020 16:37:37 +0800
Message-Id: <1597135057-22272-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

According to IC suggestion, everytime before sending the tuning command,
need to reset the usdhc, so to reset the tuning circuit, to let every
tuning command work well for the manual tuning method. For standard
tuning method, IC already add the reset operation in the hardware logic.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a76b4513fbec..cf335c661cc7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -987,10 +987,20 @@ static int usdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
 {
 	u32 reg;
+	u8 sw_rst;
+	int ret;
 
 	/* FIXME: delay a bit for card to be ready for next tuning due to errors */
 	mdelay(1);
 
+	/* IC suggest to reset USDHC before every tuning command */
+	esdhc_clrset_le(host, 0xff, SDHCI_RESET_ALL, SDHCI_SOFTWARE_RESET);
+	ret = readb_poll_timeout(host->ioaddr + SDHCI_SOFTWARE_RESET, sw_rst,
+				!(sw_rst & SDHCI_RESET_ALL), 10, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+		"warning! RESET_ALL never complete before sending tuning command\n");
+
 	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
 	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
 			ESDHC_MIX_CTRL_FBCLK_SEL;
-- 
2.17.1

