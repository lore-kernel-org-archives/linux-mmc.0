From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 15/15] mmc: core: Don't print reset warning if reset is not supported
Date: Thu, 29 Jan 2015 11:00:30 +0200
Message-ID: <1422522030-17793-16-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24640 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbbA2JDG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:03:06 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Check the error code for EOPNOTSUPP and do not print
reset warning in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 392a150..d439bf0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2368,7 +2368,8 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->reset(host);
 	mmc_bus_put(host);
 
-	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
+	if (ret != -EOPNOTSUPP)
+		pr_warn("%s: tried to reset card\n", mmc_hostname(host));
 
 	return ret;
 }
-- 
1.9.1

