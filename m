From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 06/15] mmc: core: Hold re-tuning during erase commands
Date: Tue, 10 Mar 2015 14:43:01 +0200
Message-ID: <1425991390-4983-7-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbbCJMpZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:25 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during erase commands to prevent
it from conflicting with the sequence of commands.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 01b9edf..a73dc1b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1975,6 +1975,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	unsigned long timeout;
 	int err;
 
+	mmc_retune_hold(card->host);
+
 	/*
 	 * qty is used to calculate the erase timeout which depends on how many
 	 * erase groups (or allocation units in SD terminology) are affected.
@@ -2078,6 +2080,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
 		 (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
 out:
+	mmc_retune_release(card->host);
 	return err;
 }
 
-- 
1.9.1

