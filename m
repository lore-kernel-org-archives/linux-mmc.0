From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch v1] mmc: sd: update sd_bus_speed when sd card speed switch fails
Date: Mon, 14 Nov 2016 18:33:49 +0800
Message-ID: <1479119629-31821-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:23520
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751750AbcKNKvA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Nov 2016 05:51:00 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: pandy.gao@nxp.com, frank.li@nxp.com, fugang.duan@nxp.com

In sd_set_bus_speed_mode(), sd card speed is switched to sd_bus_speed.
However, the switch process may fail. When it happens, sd card is in
default speed mode, which is SDR12 as described in Spec3.0.

In such case, the sd_bus_speed should be updated according to status[16].

Signed-off-by: Gao Pan <pandy.gao@nxp.com>
Reviewed-by: Fugang Duan <B38611@freescale.com>
---
 drivers/mmc/core/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 73c762a..ac456ec 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -471,9 +471,11 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 	if (err)
 		return err;
 
-	if ((status[16] & 0xF) != card->sd_bus_speed)
+	if ((status[16] & 0xF) != card->sd_bus_speed) {
+		card->sd_bus_speed = status[16] & 0xF;
 		pr_warn("%s: Problem setting bus speed mode!\n",
 			mmc_hostname(card->host));
+	}
 	else {
 		mmc_set_timing(card->host, timing);
 		mmc_set_clock(card->host, card->sw_caps.uhs_max_dtr);
-- 
1.9.1

