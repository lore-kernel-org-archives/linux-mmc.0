From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V6 15/15] mmc: core: Don't print reset warning if reset is not supported
Date: Mon, 20 Apr 2015 15:09:56 +0300
Message-ID: <1429531796-21987-16-git-send-email-adrian.hunter@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27511 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbbDTMM6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 08:12:58 -0400
In-Reply-To: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Check the error code for EOPNOTSUPP and do not print
reset warning in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7aae0ff..0b25e70 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2365,7 +2365,8 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->reset(host);
 	mmc_bus_put(host);
 
-	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
+	if (ret != -EOPNOTSUPP)
+		pr_warn("%s: tried to reset card\n", mmc_hostname(host));
 
 	return ret;
 }
-- 
1.9.1

