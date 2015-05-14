From: Petri Gynther <pgynther@google.com>
Subject: [PATCH] mmc: sdhci: fix DRIVER_TYPE_D handling in sdhci_do_set_ios()
Date: Wed, 13 May 2015 21:55:00 -0700 (PDT)
Message-ID: <20150514045500.D88EC220492@puck.mtv.corp.google.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f74.google.com ([209.85.218.74]:33604 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372AbbENEzD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 00:55:03 -0400
Received: by oiax69 with SMTP id x69so3735005oia.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2015 21:55:01 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

sdhci_do_set_ios() doesn't currently program SDHCI_HOST_CONTROL2
register correctly when ios->drv_type == MMC_SET_DRIVER_TYPE_D.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/mmc/host/sdhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..fe6094d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1564,6 +1564,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
 			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_C)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
+			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_D)
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_D;
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 		} else {
-- 
2.2.0.rc0.207.ga3a616c

