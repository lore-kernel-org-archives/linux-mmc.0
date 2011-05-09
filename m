From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH] mmc: clear MMC_PM_KEEP_POWER flag on resume
Date: Mon,  9 May 2011 11:32:31 +0300
Message-ID: <1304929951-30326-1-git-send-email-eliad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39718 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959Ab1EIIcX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 04:32:23 -0400
Received: by wya21 with SMTP id 21so3686469wya.19
        for <linux-mmc@vger.kernel.org>; Mon, 09 May 2011 01:32:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Since the MMC_PM_KEEP_POWER flag should be set on each suspend,
it should also cleared on each resume.

Upon resuming, we have to know if power was kept
(for re-initialization, etc.), so clear it just after resuming.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
 drivers/mmc/core/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c2350e4..99941eb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1789,6 +1789,7 @@ int mmc_resume_host(struct mmc_host *host)
 			err = 0;
 		}
 	}
+	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	mmc_bus_put(host);
 
 	return err;
-- 
1.7.0.4

