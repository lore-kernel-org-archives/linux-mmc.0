From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 2/10] mmc: meson-gx: make two functions return void
Date: Sat, 4 Mar 2017 13:20:44 +0100
Message-ID: <86e82616-1d0c-58eb-528d-705062442df4@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35265 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id z63so4629805wmg.2
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:15 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The return value of meson_mmc_request_done and meson_mmc_read_resp
isn't used, so make both functions return void.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- added acked-by
v3:
- no changes
v4:
- no changes
v5:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 07a7399c..b99461ff 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -426,7 +426,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			__func__, orig, val);
 }
 
-static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
+static void meson_mmc_request_done(struct mmc_host *mmc,
+				   struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
 
@@ -435,8 +436,6 @@ static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	mmc_request_done(host->mmc, mrq);
-
-	return 0;
 }
 
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
@@ -554,7 +553,7 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		meson_mmc_start_cmd(mmc, mrq->cmd);
 }
 
-static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
+static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
 
@@ -566,8 +565,6 @@ static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 	} else if (cmd->flags & MMC_RSP_PRESENT) {
 		cmd->resp[0] = readl(host->regs + SD_EMMC_CMD_RSP);
 	}
-
-	return 0;
 }
 
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
-- 
2.12.0


