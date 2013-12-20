From: Abbas Raza <abbas_raza@mentor.com>
Subject: [PATCH 2/2] mmc: lock: don't perform lock/unlock commands when in DDR mode
Date: Fri, 20 Dec 2013 05:43:55 +0500
Message-ID: <1387500235-10590-2-git-send-email-abbas_raza@mentor.com>
References: <1387500235-10590-1-git-send-email-abbas_raza@mentor.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:43817 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3LTAoG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 19:44:06 -0500
In-Reply-To: <1387500235-10590-1-git-send-email-abbas_raza@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Abbas Raza <Abbas_Raza@mentor.com>, Al Cooper <alcooperx@gmail.com>, Chris Ball <cjb@laptop.org>

From: Abbas Raza <Abbas_Raza@mentor.com>

According to JEDEC Standard No. 84-A441:
The card lock/unlock command (CMD42) can only be performed when the
card operates in single data rate mode. CMD42 is an illegal command in
dual data rate mode.

So if the card is in DDR mode, don't perform lock/unlock commands.
Otherwise following errors will be seen:

echo setpw > /sys/class/mmc_host/mmc2/mmc2\:0001/lock
-sh: echo: write error: Connection timed out

Timeout occurs because SET_BLOCK_LEN (CMD16) fails in dual data rate mode as
mentioned in JEDEC Standard No. 84-A441:

The following commands: bus testing (CMD19, CMD14), lock-unlock (CMD42),
set block-length (CMD16) and stream transfer (CMD11,CMD20) are not allowed
once the card is configured to operate in dual data rate mode and shall not
be executed but regarded as illegal commands.

Cc: Al Cooper <alcooperx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
---
 drivers/mmc/core/mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 24d2010..f34d237 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -664,6 +664,12 @@ ssize_t mmc_lock_store(struct device *dev, struct device_attribute *att,
 	struct mmc_password password;
 
 	mmc_claim_host(card->host);
+
+	if (mmc_card_ddr_mode(card)) {
+		dev_warn(dev, "Illegal operation in DDR mode\n");
+		goto out;
+	}
+
 	if (!mmc_card_lockable(card))
 		goto out;
 	for (x = 0; x < ARRAY_SIZE(lock_cmds); x++) {
-- 
1.8.3.2

