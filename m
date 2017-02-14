From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 08/18] mmc: meson-gx: make two functions return void
Date: Tue, 14 Feb 2017 21:06:35 +0100
Message-ID: <65a6f6a8-b650-81e9-2b3c-85d3dc89b9ba@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36692 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752992AbdBNUIB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:08:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so5221816wmd.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:50 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

The return value of meson_mmc_request_done and meson_mmc_read_resp
isn't used, so make both functions return void.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index f3963538..a67c811e 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -421,7 +421,8 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			__func__, orig, val);
 }
 
-static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
+static void meson_mmc_request_done(struct mmc_host *mmc,
+				   struct mmc_request *mrq)
 {
 	struct meson_host *host = mmc_priv(mmc);
 
@@ -430,8 +431,6 @@ static int meson_mmc_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 	mmc_request_done(host->mmc, mrq);
-
-	return 0;
 }
 
 static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
@@ -537,7 +536,7 @@ static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	meson_mmc_start_cmd(mmc, mrq->cmd);
 }
 
-static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
+static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct meson_host *host = mmc_priv(mmc);
 
@@ -549,8 +548,6 @@ static int meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
 	} else if (cmd->flags & MMC_RSP_PRESENT) {
 		cmd->resp[0] = readl(host->regs + SD_EMMC_CMD_RSP);
 	}
-
-	return 0;
 }
 
 static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
-- 
2.11.1


