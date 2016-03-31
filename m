From: Naveen Kumar Parna <naveenkumar.parna@gmail.com>
Subject: [PATCH] mmc: core: Fix bug on signal voltage switch failure
Date: Thu, 31 Mar 2016 19:47:11 +0530
Message-ID: <1459433831-4162-1-git-send-email-naveenkumar.parna@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33928 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbcCaOR3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Mar 2016 10:17:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, chris@printf.net
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Naveen Kumar Parna <naveenkumar.parna@gmail.com>

When switching SD and SDIO cards from 3.3V to 1.8V signal level fails, a bug in sdhci_set_power() will trigger.
To fix the kernel crash during recovery from signal voltage switch failure, OCR should be reset to avail voltage mask before power-cycle the card.

Signed-off-by: Naveen Kumar Parna <naveenkumar.parna@gmail.com>
---
 drivers/mmc/core/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f26a5f1..e7eb427 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1477,6 +1477,8 @@ power_cycle:
 	if (err) {
 		pr_debug("%s: Signal voltage switch failed, "
 			"power cycling card\n", mmc_hostname(host));
+		/* Reset OCR mask */
+		ocr =  host->ocr_avail;
 		mmc_power_cycle(host, ocr);
 	}
 
-- 
1.9.1

