From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: sdhi: remove obsolete support for sh7372
Date: Tue, 26 Apr 2016 22:29:10 +0200
Message-ID: <1461702550-6773-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

There is no support for this platform in the kernel anymore.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index e51d7b01d39a3b..0118d9621bebd0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -77,7 +77,6 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
-	{ .compatible = "renesas,sdhi-sh7372" },
 	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
-- 
2.7.0
