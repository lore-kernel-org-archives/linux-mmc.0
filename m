From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: debugfs: implement ios show for SDR12 and SDR25
Date: Thu, 24 Sep 2015 08:13:43 +0800
Message-ID: <1443053623-13759-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39886 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbbIXAP7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 20:15:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch add MMC_TIMING_UHS_SDR12 and MMC_TIMING_UHS_SDR25
for mmc_ios_show to show the ios->timing if mmc card runs under
these two modes.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- replace "mmc uhs sdr12" with "sd uhs sdr12"
  replace "mmc uhs sdr25" with "sd uhs sdr25"

 drivers/mmc/core/debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 9adba8d..f4db93e 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -126,6 +126,12 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	case MMC_TIMING_SD_HS:
 		str = "sd high-speed";
 		break;
+	case MMC_TIMING_UHS_SDR12:
+		str = "sd uhs SDR12";
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		str = "sd uhs SDR25";
+		break;
 	case MMC_TIMING_UHS_SDR50:
 		str = "sd uhs SDR50";
 		break;
-- 
2.3.7


