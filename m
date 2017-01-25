From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/6] mmc: core: Extend mmc_of_parse() to check for mmc-ddr-3_3v
Date: Wed, 25 Jan 2017 16:12:23 +0100
Message-ID: <1485357143-23280-7-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33434 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdAYPMn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:43 -0500
Received: by mail-lf0-f44.google.com with SMTP id x1so43804546lff.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:42 -0800 (PST)
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

When mmc_of_parse() finds the binding, it sets the mmc cap,
MMC_CAP_3_3V_DDR, which informs the core whether eMMC DDR at 3.3V I/O is
supported by the mmc host.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 98f25ff..8f75a84 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -301,6 +301,8 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_property_read_bool(np, "wakeup-source") ||
 	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_property_read_bool(np, "mmc-ddr-3_3v"))
+		host->caps |= MMC_CAP_3_3V_DDR;
 	if (of_property_read_bool(np, "mmc-ddr-1_8v"))
 		host->caps |= MMC_CAP_1_8V_DDR;
 	if (of_property_read_bool(np, "mmc-ddr-1_2v"))
-- 
1.9.1

