Return-Path: <SRS0=2cKM=B5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C6AC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1023206DA
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHSLZB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:25:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44568 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHSLZA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Aug 2020 07:25:00 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E845C1A03BC;
        Wed, 19 Aug 2020 13:24:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C0D561A03FA;
        Wed, 19 Aug 2020 13:24:54 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 074BA402C3;
        Wed, 19 Aug 2020 13:24:49 +0200 (CEST)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, mka@chromium.org,
        huyue2@yulong.com, dianders@chromium.org, pali@kernel.org
Subject: [PATCH v2] mmc: sdio: add a delay to call sdio_irq_work when sdio bus resume
Date:   Wed, 19 Aug 2020 19:19:19 +0800
Message-Id: <1597835959-22402-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Find this issue on i.MX7D-sdb board with broadcom sdio wifi.
When system resume, sometimes this wifi meet the tuning fail issue.
All tuning command get command timeout error. This is because
sdio_irq_work on system_wq was executed before the broadcom
wifi driver resume. Due to broadcom wifi driver set the wifi in
Sleep sate in system suspend, need to set the wifi to Wake state
first. So need to make sure wifi driver resume first, then do the
sdio_irq_work.

Fixes: 51133850bce2 ("mmc: core: Fixup processing of SDIO IRQs during system suspend/resume")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 7b40553d3934..101632617f69 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1047,7 +1047,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
+			queue_delayed_work(system_wq, &host->sdio_irq_work, 1);
 	}
 
 out:
-- 
2.17.1

