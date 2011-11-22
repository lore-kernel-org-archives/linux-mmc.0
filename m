From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: [PATCH] mmc: core: Fix deadlock when the CONFIG_MMC_UNSAFE_RESUME is not defined
Date: Tue, 22 Nov 2011 17:00:37 +0530
Message-ID: <1321961437-27130-1-git-send-email-sthumma@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:12298 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab1KVLav (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 06:30:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, cjb@laptop.org

mmc_suspend_host() tries to claim host during suspend
and release it only when the bus suspend operation is
compeleted. If CONFIG_MMC_UNSAFE_RESUME is defined and
the host is flagged as removable, mmc_suspend_host()
tries to remove the card. In this process, the file system
sync can get blocked trying to acquire host which is already
claimed by mmc_suspend_host() causing deadlock.

Fix this deadlock by releasing host before ->remove() is called.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
---
 drivers/mmc/core/core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 271efea..8adbadf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2338,6 +2338,7 @@ int mmc_suspend_host(struct mmc_host *host)
 				 * We simply "remove" the card in this case.
 				 * It will be redetected on resume.
 				 */
+				mmc_do_release_host(host);
 				if (host->bus_ops->remove)
 					host->bus_ops->remove(host);
 				mmc_claim_host(host);
@@ -2346,8 +2347,9 @@ int mmc_suspend_host(struct mmc_host *host)
 				mmc_release_host(host);
 				host->pm_flags = 0;
 				err = 0;
+			} else {
+				mmc_do_release_host(host);
 			}
-			mmc_do_release_host(host);
 		} else {
 			err = -EBUSY;
 		}
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

