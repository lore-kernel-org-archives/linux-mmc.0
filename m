From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] mmc: debugfs: implement ios show for SDR12 and SDR25
Date: Tue, 22 Sep 2015 09:19:55 +0800
Message-ID: <1442884795-11493-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442884713-11193-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch add MMC_TIMING_UHS_SDR12 and MMC_TIMING_UHS_SDR25
for mmc_ios_show to show the ios->timing if mmc card runs under
these two mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index b2ab936..31155e8 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -126,6 +126,12 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	case MMC_TIMING_SD_HS:
 		str = "sd high-speed";
 		break;
+	case MMC_TIMING_UHS_SDR12:
+		str = "mmc uhs SDR12";
+		break;
+	case MMC_TIMING_UHS_SDR25:
+		str = "mmc uhs SDR25";
+		break;
 	case MMC_TIMING_UHS_SDR50:
 		str = "sd uhs SDR50";
 		break;
-- 
2.3.7
