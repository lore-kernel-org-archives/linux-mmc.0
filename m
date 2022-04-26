Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F59C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiDZJyY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 05:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347569AbiDZJxi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 05:53:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72672981A;
        Tue, 26 Apr 2022 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650964242; x=1682500242;
  h=from:to:cc:subject:date:message-id;
  bh=+p40Cvh2hhSxVfAPCJZpYYJuBDaizdr/QFl0LujIiyQ=;
  b=y1OMGka4EBLJIHT6oDWaoQuh1qamXXwi234qTk3eLdV9AldtHw5OuLsV
   yL7Pni4OYSLMgsUsFkFVWZCR8e/dAKv0H57S8bcHgFEWzaPvxU1fv4N1c
   R/ihdMUEgf/B1XGyORS6x720HNeFoXNVm9DgPg7y6t6K1TFjtnYYGKn28
   Q=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 02:10:42 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 02:10:40 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg02-blr.qualcomm.com with ESMTP; 26 Apr 2022 14:40:28 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id B262D3AE1; Tue, 26 Apr 2022 14:40:27 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     ulf.hansson@linaro.org, u.kleine-koenig@pengutronix.de,
        YehezkelShB@gmail.com, rmk+kernel@armlinux.org.uk,
        t.scherer@eckelmann.de, s.shtylyov@omp.ru, sensor1010@163.com,
        sartgarg@codeaurora.org, hns@goldelico.com,
        uic_kamasali@quicinc.com, quic_spathi@quicinc.com,
        tiantao6@hisilicon.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kamasali <quic_kamasali@quicinc.com>
Subject: [PATCH V1] mmc: sdhci-msm: Add wakeup functionality support for sdio cards
Date:   Tue, 26 Apr 2022 14:40:25 +0530
Message-Id: <1650964225-6705-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sarthak Garg <sartgarg@codeaurora.org>

This adds external GPIO wakeup support to sdhci-msm driver
for sdio cards.

Also enables clk gating only in system Suspend/Resume for SDIO card.

Also add the below fixes from 4.9 kernel :

c363224b: Fix wakeup functionality for SDIO
61fc5bf6: Remove flag MMC_PM_WAKE_SDIO_IRQ in mmc_resume_host
a7a2a82e: Set sdio_pending_processing default state to false.

Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/bus.c  | 7 +++++++
 drivers/mmc/core/sdio.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60af..a475fe1 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -364,6 +364,13 @@ int mmc_add_card(struct mmc_card *card)
 #endif
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
+	if (mmc_card_sdio(card)) {
+		ret = device_init_wakeup(&card->dev, true);
+		if (ret)
+			pr_err("%s: %s: failed to init wakeup: %d\n",
+				mmc_hostname(card->host), __func__, ret);
+	}
+
 	device_enable_async_suspend(&card->dev);
 
 	ret = device_add(&card->dev);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799ac..9502318 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1096,6 +1096,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	mmc_release_host(host);
 
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
+	host->pm_flags &= ~MMC_PM_WAKE_SDIO_IRQ;
 	return err;
 }
 
-- 
2.7.4

