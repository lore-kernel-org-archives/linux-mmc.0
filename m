Return-Path: <SRS0=YBQu=BQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6893C4743A
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64C22333C
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgHFIX7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:23:59 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47116 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgHFIX7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Aug 2020 04:23:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE0F11A094E;
        Thu,  6 Aug 2020 10:23:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF3A01A0909;
        Thu,  6 Aug 2020 10:23:54 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8FA78402E5;
        Thu,  6 Aug 2020 10:23:50 +0200 (CEST)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, mka@chromium.org,
        dianders@chromium.org
Subject: [PATCH] mmc: sdio: change to use system_freezable_wq for sdio_irq_work
Date:   Thu,  6 Aug 2020 16:19:04 +0800
Message-Id: <1596701944-31965-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Change to use system_freezable_wq because it can make sure the queue
becomes frozen when userspace becomes frozen during system PM.

Find this issue on i.MX7D-sdb board with broadcom sdio wifi.
When system resume, sometimes this wifi meet the tuning fail issue.
All tuning command get command timeout error. This is because
sdio_irq_work on system_wq was executed before the broadcom
wifi driver resume. Due to broadcom wifi driver set the wifi in
Sleep sate in system suspend, need to set the wifi to Wake state
first. So need to make sure wifi driver resume first, then do the
sdio_irq_work.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/sdio.c     | 2 +-
 drivers/mmc/core/sdio_irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 26cabd53ddc5..269ae63d09eb 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1015,7 +1015,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		if (!(host->caps2 & MMC_CAP2_SDIO_IRQ_NOTHREAD))
 			wake_up_process(host->sdio_irq_thread);
 		else if (host->caps & MMC_CAP_SDIO_IRQ)
-			queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
+			queue_delayed_work(system_freezable_wq, &host->sdio_irq_work, 0);
 	}
 
 out:
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 900871073bd7..9d7ec48bd963 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -132,7 +132,7 @@ void sdio_irq_work(struct work_struct *work)
 void sdio_signal_irq(struct mmc_host *host)
 {
 	host->sdio_irq_pending = true;
-	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
+	queue_delayed_work(system_freezable_wq, &host->sdio_irq_work, 0);
 }
 EXPORT_SYMBOL_GPL(sdio_signal_irq);
 
-- 
2.17.1

