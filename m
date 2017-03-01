From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mmc: core: Fix access to HS400-ES devices
Date: Wed,  1 Mar 2017 14:11:47 -0800
Message-ID: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Anssi Hannula <anssi.hannula@bitwise.fi>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-mmc@vger.kernel.org

HS400-ES devices fail to initialize with the following error messages.

mmc1: power class selection to bus width 8 ddr 0 failed
mmc1: error -110 whilst initialising MMC card

This was seen on Samsung Chromebook Plus. Code analysis points to
commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
high-speed mode"), which attempts to set the bus width for all but
HS200 devices unconditionally. However, for HS400-ES, the bus width
is already selected.

Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Fixes: 3d4ef329757c ("mmc: core: fix multi-bit bus width ...")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7fd722868875..b502601df228 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1730,7 +1730,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_select_hs400(card);
 		if (err)
 			goto free_card;
-	} else {
+	} else if (!mmc_card_hs400es(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (err > 0 && mmc_card_hs(card)) {
-- 
2.7.4
