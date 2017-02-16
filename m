From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 4/9] mmc: meson-gx: remove unneeded variable in
 meson_mmc_clk_init
Date: Thu, 16 Feb 2017 20:41:30 +0100
Message-ID: <2bb20447-d932-0ffe-e976-ca16d28154dd@gmail.com>
References: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33621 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933121AbdBPTnH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2017 14:43:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so4689974wmv.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Feb 2017 11:43:07 -0800 (PST)
In-Reply-To: <7d5263e2-9325-dedb-a5f6-954c4a09e977@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Because the DT requires a fixed number of mux parent clocks,
variable mux_parent_count can be replaced with constant
MUX_CLK_NUM_PARENTS, so remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- adjusted commit message
- added acked-by
---
 drivers/mmc/host/meson-gx-mmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index b9de3d47..ea2db3ce 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -242,7 +242,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	char clk_name[32];
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
-	unsigned int mux_parent_count = 0;
 	const char *clk_div_parents[1];
 	u32 clk_reg, cfg;
 
@@ -261,7 +260,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 		}
 
 		mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
-		mux_parent_count++;
 	}
 
 	/* create the mux */
@@ -270,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.ops = &clk_mux_ops;
 	init.flags = 0;
 	init.parent_names = mux_parent_names;
-	init.num_parents = mux_parent_count;
+	init.num_parents = MUX_CLK_NUM_PARENTS;
 
 	host->mux.reg = host->regs + SD_EMMC_CLOCK;
 	host->mux.shift = CLK_SRC_SHIFT;
-- 
2.11.1


