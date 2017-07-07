From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: mmc: fix switch to 1V8 for hs400es mode
Date: Fri,  7 Jul 2017 17:08:55 +0800
Message-ID: <1499418535-10161-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:44632
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751927AbdGGJCd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 7 Jul 2017 05:02:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, shawn.lin@rock-chips.com
Cc: stable@vger.kernel.org, dianders@chromium.org, linux-mmc@vger.kernel.org, haibo.chen@nxp.com

Change the default err value to -EINVAL, otherwise signal voltage
will not change to 1V8 if card or controller only support 1V8 for
HS400ES mode.

Fixes: commit 1720d3545b77 ("mmc: core: switch to 1V8 or 1V2 for hs400es mode")
Cc: <stable@vger.kernel.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 92c6167..336a950 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1289,7 +1289,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 static int mmc_select_hs400es(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	int err = 0;
+	int err = -EINVAL;
 	u8 val;
 
 	if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
-- 
1.9.1

