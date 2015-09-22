From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] mmc: debugfs: implement ios show for driver type
Date: Tue, 22 Sep 2015 09:20:08 +0800
Message-ID: <1442884808-11652-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:39245 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757537AbbIVBcV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2015 21:32:21 -0400
In-Reply-To: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch add ios->drv_type for mmc_ios_show to show the
card's driver type.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/debugfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 31155e8..5243e5f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -172,6 +172,25 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	}
 	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
 
+	switch (ios->drv_type) {
+	case MMC_SET_DRIVER_TYPE_A:
+		str = "driver type A";
+		break;
+	case MMC_SET_DRIVER_TYPE_B:
+		str = "driver type B";
+		break;
+	case MMC_SET_DRIVER_TYPE_C:
+		str = "driver type C";
+		break;
+	case MMC_SET_DRIVER_TYPE_D:
+		str = "driver type D";
+		break;
+	default:
+		str = "invalid";
+		break;
+	}
+	seq_printf(s, "driver type:\t%u (%s)\n", ios->drv_type, str);
+
 	return 0;
 }
 
-- 
2.3.7


