From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/13] mmc: It is not an error for the card to be removed while suspended
Date: Mon, 22 Sep 2014 13:17:34 +0300
Message-ID: <1411381064-1703-4-git-send-email-adrian.hunter@intel.com>
References: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33216 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577AbaIVKT2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 06:19:28 -0400
In-Reply-To: <1411381064-1703-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

A removable card can be removed while it is runtime suspended.
Do not print an error message.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 drivers/mmc/core/sd.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ce11d89..1d827eb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1804,7 +1804,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 		return 0;
 
 	err = _mmc_resume(host);
-	if (err)
+	if (err && (err != -ENOMEDIUM || (host->caps & MMC_CAP_NONREMOVABLE)))
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2591388..28089b3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1178,7 +1178,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 		return 0;
 
 	err = _mmc_sd_resume(host);
-	if (err)
+	if (err && (err != -ENOMEDIUM || (host->caps & MMC_CAP_NONREMOVABLE)))
 		pr_err("%s: error %d doing aggessive resume\n",
 			mmc_hostname(host), err);
 
-- 
1.8.3.2

