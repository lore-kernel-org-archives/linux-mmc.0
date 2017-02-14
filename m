From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 06/18] mmc: meson-gx: simplify bounce buffer setting in
 meson_mmc_start_cmd
Date: Tue, 14 Feb 2017 21:06:26 +0100
Message-ID: <10457b8c-401b-d473-0a24-30dfacb4eb48@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35378 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754595AbdBNUHn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:43 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so5219448wmu.2
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:37 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

If xfer_bytes is zero we can configure the chip to use the bounce
buffer as well because it won't get used anyway.
And we don't have to reset bit CMD_CFG_DATA_NUM because cmd_cfg
was zero-initialized and this bit isn't set.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c7bf0e12..423b4b17 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -505,15 +505,7 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
 			cmd_cfg &= ~CMD_CFG_DATA_WR;
 		}
 
-		if (xfer_bytes > 0) {
-			cmd_cfg &= ~CMD_CFG_DATA_NUM;
-			cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
-		} else {
-			/* write data to data_addr */
-			cmd_cfg |= CMD_CFG_DATA_NUM;
-			cmd_data = 0;
-		}
-
+		cmd_data = host->bounce_dma_addr & CMD_DATA_MASK;
 		cmd_cfg_timeout = 12;
 	} else {
 		cmd_cfg &= ~CMD_CFG_DATA_IO;
-- 
2.11.1


