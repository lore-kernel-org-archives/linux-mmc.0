From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 08/15] mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
Date: Tue, 10 Mar 2015 14:43:03 +0200
Message-ID: <1425991390-4983-9-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbbCJMpb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:31 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
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
index 1d41e85..813b02a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1496,6 +1496,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+/* If necessary, callers must hold re-tuning */
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
-- 
1.9.1

