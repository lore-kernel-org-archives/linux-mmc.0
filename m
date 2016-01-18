From: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Subject: [PATCH] mmc: debugfs: correct wrong voltage value
Date: Mon, 18 Jan 2016 10:35:19 +0100
Message-ID: <1453109719-53079-1-git-send-email-pawelx.wodkowski@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57366 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbcARJpO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jan 2016 04:45:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

Correct the wrong voltage value shown in debugfs for mmc/sd/sdio.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
---
 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index bdfce774d848..6239ec3220a8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -170,7 +170,7 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 		str = "invalid";
 		break;
 	}
-	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
+	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->signal_voltage, str);
 
 	switch (ios->drv_type) {
 	case MMC_SET_DRIVER_TYPE_A:
-- 
1.9.1

