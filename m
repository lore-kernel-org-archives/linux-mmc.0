From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 08/13] mmc: core: Hold re-tuning during erase commands
Date: Fri,  5 Dec 2014 19:41:06 +0200
Message-ID: <1417801271-15575-9-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60360 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaLERnX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:23 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during erase commands to prevent
it from conflicting with the sequence of commands.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2c10fb9..3da5fa8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1956,6 +1956,10 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	unsigned long timeout;
 	int err;
 
+	err = mmc_retune_and_hold(card->host);
+	if (err)
+		return err;
+
 	/*
 	 * qty is used to calculate the erase timeout which depends on how many
 	 * erase groups (or allocation units in SD terminology) are affected.
@@ -2059,6 +2063,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
 		 (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
 out:
+	mmc_retune_release(card->host);
 	return err;
 }
 
-- 
1.9.1

