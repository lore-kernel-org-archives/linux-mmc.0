From: Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH] mmc: block: improve logging of handling emmc timeouts
Date: Wed,  4 May 2016 14:43:40 +0530
Message-ID: <1462353220-5196-1-git-send-email-amit.pundir@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Ken Sumrall <ksumrall@android.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Luca Porzio <lporzio@micron.com>, Android Kernel Team <kernel-team@android.com>, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Ken Sumrall <ksumrall@android.com>

Add some logging to make it clear just how the emmc timeout
was handled.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Luca Porzio <lporzio@micron.com>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Ken Sumrall <ksumrall@android.com>
[AmitP: cherry-picked this Android patch from aosp common kernel android-4.4]
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/mmc/card/block.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9c69e21..e737c81 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -948,18 +948,25 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
 			req->rq_disk->disk_name, "timed out", name, status);
 
 		/* If the status cmd initially failed, retry the r/w cmd */
-		if (!status_valid)
+		if (!status_valid) {
+			pr_err("%s: status not valid, retrying timeout\n",
+				req->rq_disk->disk_name);
 			return ERR_RETRY;
+		}
 
 		/*
 		 * If it was a r/w cmd crc error, or illegal command
 		 * (eg, issued in wrong state) then retry - we should
 		 * have corrected the state problem above.
 		 */
-		if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND))
+		if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND)) {
+			pr_err("%s: command error, retrying timeout\n",
+				req->rq_disk->disk_name);
 			return ERR_RETRY;
+		}
 
 		/* Otherwise abort the command */
+		pr_err("%s: not retrying timeout\n", req->rq_disk->disk_name);
 		return ERR_ABORT;
 
 	default:
-- 
2.7.4
