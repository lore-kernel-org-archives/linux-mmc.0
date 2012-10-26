From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [PATCH] mmc: core: debugfs: Add signal_voltage to ios dump
Date: Fri, 26 Oct 2012 11:31:55 +0200
Message-ID: <1351243915-30190-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:33277 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755980Ab2JZJc5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 05:32:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
 drivers/mmc/core/debugfs.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index d96c643..35c2f85 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -144,6 +144,22 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	}
 	seq_printf(s, "timing spec:\t%u (%s)\n", ios->timing, str);
 
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		str = "3.30 V";
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		str = "1.80 V";
+		break;
+	case MMC_SIGNAL_VOLTAGE_120:
+		str = "1.20 V";
+		break;
+	default:
+		str = "invalid";
+		break;
+	}
+	seq_printf(s, "signal voltage:\t%u (%s)\n", ios->chip_select, str);
+
 	return 0;
 }
 
-- 
1.7.10

