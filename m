From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 06/15] mmc: core: Hold re-tuning during erase commands
Date: Fri, 27 Mar 2015 22:57:34 +0200
Message-ID: <1427489863-9050-7-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbbC0U77 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 16:59:59 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Hold re-tuning during erase commands to prevent
it from conflicting with the sequence of commands.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 16881c8..d4e3248 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1993,6 +1993,8 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	unsigned long timeout;
 	int err;
 
+	mmc_retune_hold(card->host);
+
 	/*
 	 * qty is used to calculate the erase timeout which depends on how many
 	 * erase groups (or allocation units in SD terminology) are affected.
@@ -2096,6 +2098,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 	} while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
 		 (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
 out:
+	mmc_retune_release(card->host);
 	return err;
 }
 
-- 
1.9.1

