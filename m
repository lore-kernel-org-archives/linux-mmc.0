From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] mmc: core: Add MMC_CAP_RUNTIME_RESUME to resume at runtime_resume
Date: Fri, 11 Oct 2013 14:28:18 +0200
Message-ID: <1381494498-16699-5-git-send-email-ulf.hansson@linaro.org>
References: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:42732 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728Ab3JKM2w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Oct 2013 08:28:52 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so3292775lab.41
        for <linux-mmc@vger.kernel.org>; Fri, 11 Oct 2013 05:28:51 -0700 (PDT)
In-Reply-To: <1381494498-16699-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Colin Cross <ccross@android.com>, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

In some environments it is to prefer to postpone the resume of the card
device until runtime_resume is being carried out, since it will mean a
signficant decrease of the total system resume time.

The reason of the decreased resume time is simply because of the actual
re-initalization of the card, which typically takes hundreds of
milliseconds, is performed outside the resume sequence and wont thus
affect it.

For removable card, the detect work tries to re-detect the card to make
sure it is still present, as a part of that sequence the card will also
be runtime_resumed and thus also fully resumed.

For a non-removable card, typically a mmc blk request will trigger a
runtime_resume and thus fully resume the card. This also means the
first request will likely suffer from an inital latency since the
re-initialization of the card needs to be performed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c   |   12 +++++++-----
 drivers/mmc/core/sd.c    |   12 +++++++-----
 include/linux/mmc/host.h |    1 +
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1e29dbc..9825119 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1577,11 +1577,13 @@ static int mmc_shutdown(struct mmc_host *host)
  */
 static int mmc_resume(struct mmc_host *host)
 {
-	int err;
+	int err = 0;
 
-	err = _mmc_resume(host);
-	pm_runtime_set_active(&host->card->dev);
-	pm_runtime_mark_last_busy(&host->card->dev);
+	if (!(host->caps & MMC_CAP_RUNTIME_RESUME)) {
+		err = _mmc_resume(host);
+		pm_runtime_set_active(&host->card->dev);
+		pm_runtime_mark_last_busy(&host->card->dev);
+	}
 	pm_runtime_enable(&host->card->dev);
 
 	return err;
@@ -1612,7 +1614,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
 {
 	int err;
 
-	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
+	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
 		return 0;
 
 	err = _mmc_resume(host);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 57940a8..5052d06 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1137,11 +1137,13 @@ out:
  */
 static int mmc_sd_resume(struct mmc_host *host)
 {
-	int err;
+	int err = 0;
 
-	err = _mmc_sd_resume(host);
-	pm_runtime_set_active(&host->card->dev);
-	pm_runtime_mark_last_busy(&host->card->dev);
+	if (!(host->caps & MMC_CAP_RUNTIME_RESUME)) {
+		err = _mmc_sd_resume(host);
+		pm_runtime_set_active(&host->card->dev);
+		pm_runtime_mark_last_busy(&host->card->dev);
+	}
 	pm_runtime_enable(&host->card->dev);
 
 	return err;
@@ -1172,7 +1174,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 {
 	int err;
 
-	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
+	if (!(host->caps & (MMC_CAP_AGGRESSIVE_PM | MMC_CAP_RUNTIME_RESUME)))
 		return 0;
 
 	err = _mmc_sd_resume(host);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3b0c33a..a9f7c96 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -254,6 +254,7 @@ struct mmc_host {
 #define MMC_CAP_UHS_SDR50	(1 << 17)	/* Host supports UHS SDR50 mode */
 #define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
 #define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
+#define MMC_CAP_RUNTIME_RESUME	(1 << 20)	/* Resume at runtime_resume. */
 #define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
 #define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
 #define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
-- 
1.7.9.5

