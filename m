From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 07/14] mmc: mmc: Hold re-tuning in mmc_sleep()
Date: Thu,  7 May 2015 13:10:18 +0300
Message-ID: <1430993425-2777-8-git-send-email-adrian.hunter@intel.com>
References: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29829 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912AbbEGKMz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 06:12:55 -0400
In-Reply-To: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

The sleep command is issued after deselecting the
card, but re-tuning won't work on a deselected card
so re-tuning must be held.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f36c76f..fd41b28 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/mmc.h>
 
 #include "core.h"
+#include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -1511,9 +1512,12 @@ static int mmc_sleep(struct mmc_host *host)
 	unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
 	int err;
 
+	/* Re-tuning can't be done once the card is deselected */
+	mmc_retune_hold(host);
+
 	err = mmc_deselect_cards(host);
 	if (err)
-		return err;
+		goto out_release;
 
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
@@ -1534,7 +1538,7 @@ static int mmc_sleep(struct mmc_host *host)
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
-		return err;
+		goto out_release;
 
 	/*
 	 * If the host does not wait while the card signals busy, then we will
@@ -1545,6 +1549,8 @@ static int mmc_sleep(struct mmc_host *host)
 	if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
 		mmc_delay(timeout_ms);
 
+out_release:
+	mmc_retune_release(host);
 	return err;
 }
 
-- 
1.9.1

