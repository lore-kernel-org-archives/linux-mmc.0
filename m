From: Petri Gynther <pgynther@google.com>
Subject: [PATCH v2] mmc: sdhci: fix driver type B and D handling in sdhci_do_set_ios()
Date: Wed, 20 May 2015 14:35:00 -0700 (PDT)
Message-ID: <20150520213501.15A7322078C@puck.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f202.google.com ([209.85.213.202]:33301 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbETVfD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2015 17:35:03 -0400
Received: by igdh15 with SMTP id h15so3849117igd.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2015 14:35:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

sdhci_do_set_ios() doesn't currently program SDHCI_HOST_CONTROL2
register correctly when host->preset_enabled == false.

Add code to handle the missing cases MMC_SET_DRIVER_TYPE_B and
MMC_SET_DRIVER_TYPE_D.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..5d32a00 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1562,8 +1562,17 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			ctrl_2 &= ~SDHCI_CTRL_DRV_TYPE_MASK;
 			if (ios->drv_type == MMC_SET_DRIVER_TYPE_A)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
+			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_B)
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;
 			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_C)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
+			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_D)
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_D;
+			else {
+				pr_warn("%s: invalid driver type, default to "
+					"driver type B\n", mmc_hostname(mmc));
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;
+			}
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		} else {
-- 
2.2.0.rc0.207.ga3a616c

