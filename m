From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 6/6] mmc: sh_mobile_sdhi: simplify code for voltage switching
Date: Wed,  6 Apr 2016 11:25:34 +0200
Message-ID: <1459934734-3613-7-git-send-email-wsa@the-dreams.de>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

A last minute fix applied by Ulf made room for some simplification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 51d8dbd5b06a3e..b85b87eb55009f 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -237,11 +237,7 @@ static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (ret)
 		return ret;
 
-	ret = pinctrl_select_state(priv->pinctrl, pin_state);
-	if (ret)
-		return ret;
-
-	return 0;
+	return pinctrl_select_state(priv->pinctrl, pin_state);
 }
 
 static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
-- 
2.7.0

