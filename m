Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01223C32793
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Jan 2023 04:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjARE6D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Jan 2023 23:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjARE6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2023 23:58:01 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53483D927;
        Tue, 17 Jan 2023 20:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674017880;
  x=1705553880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LXVxts8stmRwC9zeoYq1CfmgBzo9W/O8CtI9UiNH5k8=;
  b=Fl4EQRB8mP0wHO5m8ft/aIOMBWc3ohvT5xBriDc70YOaG3rOIxQwozeR
   O77w6QGNnPMu7XBYVJ2qAeWz6/1S9hdy5mct3JOQYdiYalR5ZNAmbJTa5
   WWFcQdWOOfw8Nox/3dFMzv5vVUq4s3BEUwFqgfywxJ/2HbhAP/nigsWJM
   dlErAppn7beCDlM1cJshd/uONplQe4Gj+k4/t7RDz5A84FZe7Rlj3B+Ie
   AnWfy1mqknyM1grT/6W0l74HCyL4iDb3CmfFPZtC+Gi80SRZYiNCRIRG9
   LrhIoAA5UXv4MbDQt0Guu6qs//VbpEZ89swyzvhEveX3dPVpvbJ9Q8qHW
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: core: expose MMC_CAP_AGGRESSIVE_PM to DT
Date:   Wed, 18 Jan 2023 12:57:49 +0800
Message-ID: <20230118045749.3913296-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch expose the MMC_CAP_AGGRESSIVE_PM flag to DT which
allows the host to enable it from DT.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d17eda753b7e..1d98a301515d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -376,6 +376,8 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps |= MMC_CAP_HW_RESET;
 	if (device_property_read_bool(dev, "cap-sdio-irq"))
 		host->caps |= MMC_CAP_SDIO_IRQ;
+	if (device_property_read_bool(dev, "cap-aggressive-pm"))
+		host->caps |= MMC_CAP_AGGRESSIVE_PM;
 	if (device_property_read_bool(dev, "full-pwr-cycle"))
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
 	if (device_property_read_bool(dev, "full-pwr-cycle-in-suspend"))
-- 
2.30.2

