From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/13] mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
Date: Fri,  5 Dec 2014 19:41:08 +0200
Message-ID: <1417801271-15575-11-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60360 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbaLERna (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:30 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Currently "mmc sleep" is only used before power off and
is not paired with waking up.  If that ever changed,
re-tuning might need to be held, so add a comment for that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c712ba7..7a913e6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1520,6 +1520,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+/* If necessary, callers must hold re-tuning */
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
-- 
1.9.1

