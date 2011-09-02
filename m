From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH] mmc: core: add sd uhs string for mmc_ios_show
Date: Fri, 2 Sep 2011 16:06:08 +0800
Message-ID: <1314950768-7135-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:57007 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757875Ab1IBIGZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2011 04:06:25 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, Aaron Lu <aaron.lu@amd.com>

This is a minor fix. It makes mmc_ios_show print proper string when the
host's timing is one of the newly added UHS-I modes.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/core/debugfs.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 5acd707..96c603b 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -114,6 +114,15 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	case MMC_TIMING_SD_HS:
 		str = "sd high-speed";
 		break;
+	case MMC_TIMING_UHS_SDR50:
+		str = "sd uhs SDR50";
+		break;
+	case MMC_TIMING_UHS_SDR104:
+		str = "sd uhs SDR104";
+		break;
+	case MMC_TIMING_UHS_DDR50:
+		str = "sd uhs DDR50";
+		break;
 	default:
 		str = "invalid";
 		break;
-- 
1.7.4.4


