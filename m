From: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Subject: [PATCH v2] mmc: Add a restriction to mmc debugfs clock setting.
Date: Thu, 21 Jan 2016 13:57:51 +0100
Message-ID: <1453381071-47571-1-git-send-email-pawelx.wodkowski@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60675 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965066AbcAUND6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jan 2016 08:03:58 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, Yuan Juntao <juntaox.yuan@intel.com>

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

Clock frequency values written to an mmc host should not be less than
the minimum clock frequency which the mmc host supports.

Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>

---

Changes in v2:
- Allow setting zero frequency. 

 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 154aced0b91b..705586dcd9fa 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
 	struct mmc_host *host = data;
 
 	/* We need this check due to input value is u64 */
-	if (val > host->f_max)
+	if (val != 0 && (val > host->f_max || val < host->f_min))
 		return -EINVAL;
 
 	mmc_claim_host(host);
-- 
1.9.1

