From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 15/15] mmc: core: Don't print reset warning if reset is not supported
Date: Fri, 27 Mar 2015 22:57:43 +0200
Message-ID: <1427489863-9050-16-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14154 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572AbbC0VAT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 17:00:19 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
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
index f8ae793..595be30 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2363,7 +2363,8 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->reset(host);
 	mmc_bus_put(host);
 
-	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
+	if (ret != -EOPNOTSUPP)
+		pr_warn("%s: tried to reset card\n", mmc_hostname(host));
 
 	return ret;
 }
-- 
1.9.1

