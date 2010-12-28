From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH] [RFC] mmc: perform SDIO reset on power restore of host
Date: Tue, 28 Dec 2010 12:25:23 +0100
Message-ID: <1293535523-19191-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:36123 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753083Ab0L1LZ3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Dec 2010 06:25:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Arnd Hannemann <arnd@arndnet.de>

On some boards card power is hard wired to the slot
and active regardless of host controller state.
When runtime PM suspends such a host, certain cards
may keep their current configuration (e.g. bus width),
now when runtime PM resumes the host, communication
with the card will fail.
This was observed on AP4EVB with tmio_mmc and a b43 based
SDIO card:
http://marc.info/?l=linux-mmc&m=128854536521274&w=2

This patch, fixes the problem by resetting the SDIO
card on power restore.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/core/core.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 31ae07a..21cdee6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1617,8 +1617,13 @@ int mmc_power_restore_host(struct mmc_host *host)
 	}
 
 	mmc_power_up(host);
-	ret = host->bus_ops->power_restore(host);
 
+	mmc_claim_host(host);
+	sdio_reset(host);
+	mmc_go_idle(host);
+	mmc_release_host(host);
+
+	ret = host->bus_ops->power_restore(host);
 	mmc_bus_put(host);
 
 	return ret;
-- 
1.7.2.3

