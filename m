From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 4/10] mmc: meson-gx: remove unneeded variable in
 meson_mmc_clk_init
Date: Sat, 4 Mar 2017 13:22:57 +0100
Message-ID: <2fd2f059-df21-dc55-48b8-debb923ebf37@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34493 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so16254061wrc.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:18 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
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
v3:
- no changes
v4:
- no changes
v5:
- no changes
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
2.12.0


