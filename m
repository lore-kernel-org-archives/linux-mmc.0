Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580FC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11622206E9
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408308AbgDOJJP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:09:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38336 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408295AbgDOJJN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 05:09:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 72C0D1A07FD;
        Wed, 15 Apr 2020 11:09:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 671241A07D6;
        Wed, 15 Apr 2020 11:09:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 796EA402B4;
        Wed, 15 Apr 2020 17:09:05 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH] mmc: sdhci: add spin lock for sdhci_set_default_irqs in sdhci_init
Date:   Wed, 15 Apr 2020 17:00:55 +0800
Message-Id: <1586941255-9237-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When use one SDIO wifi which enable the runtime PM feature on i.MX6SX,
we meet system hang. This hang happened during the usdhc runtime resume,
in sdhci_init(), when call the sdhci_set_default_irqs. One interrupt
(SDHCI_INT_CARD_INT) triggered just after the host->ier update and before
the write of register SDHCI_SIGNAL_ENABLE. So in sdhci_irq, it will skip
the call of sdio_signal_irq() because current host->ier do not set the
SDHCI_INT_CARD_INT. So this SDIO wifi interrupt always keep triggered,
let the system stuck in irq handle, can't response any other thread.

This patch add spin lock for the sdhci_set_default_irqs to fix this issue.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..79b6324a500c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -317,6 +317,7 @@ static void sdhci_config_dma(struct sdhci_host *host)
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
+	unsigned long flags;
 
 	if (soft)
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
@@ -326,7 +327,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	if (host->v4_mode)
 		sdhci_do_enable_v4_mode(host);
 
+	spin_lock_irqsave(&host->lock, flags);
 	sdhci_set_default_irqs(host);
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	host->cqe_on = false;
 
-- 
2.17.1

