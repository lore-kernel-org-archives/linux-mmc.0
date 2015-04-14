From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 08/15] mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
Date: Tue, 14 Apr 2015 16:12:19 +0300
Message-ID: <1429017146-15981-9-git-send-email-adrian.hunter@intel.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65351 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbbDNNO5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Apr 2015 09:14:57 -0400
In-Reply-To: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Currently "mmc sleep" is only used before power off and
is not paired with waking up.  If that ever changed,
re-tuning might need to be held, so add a comment for that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c84131e..53a9cb3 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1504,6 +1504,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+/* If necessary, callers must hold re-tuning */
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
-- 
1.9.1

