From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 08/15] mmc: mmc: Comment that callers need to hold re-tuning if the card is put to sleep
Date: Thu, 29 Jan 2015 11:00:23 +0200
Message-ID: <1422522030-17793-9-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43633 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758415AbbA2JCr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:02:47 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
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
index 1fc48a2..d4156e9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1494,6 +1494,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+/* If necessary, callers must hold re-tuning */
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
-- 
1.9.1

