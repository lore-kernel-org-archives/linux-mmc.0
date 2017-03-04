From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 5/10] mmc: meson-gx: remove member parent_mux from struct
 meson_host
Date: Sat, 4 Mar 2017 13:24:09 +0100
Message-ID: <ae9a2173-7f57-a281-6ce8-dc1e03b72a92@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34500 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so16254202wrc.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:19 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Member mux_parent isn't used outside meson_mmc_clk_init. So remove it
and replace it with a local variable in meson_mmc_clk_init.

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
 drivers/mmc/host/meson-gx-mmc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index ea2db3ce..68e76fa8 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -130,7 +130,6 @@ struct meson_host {
 	struct clk *core_clk;
 	struct clk_mux mux;
 	struct clk *mux_clk;
-	struct clk *mux_parent[MUX_CLK_NUM_PARENTS];
 	unsigned long current_clock;
 
 	struct clk_divider cfg_div;
@@ -247,19 +246,18 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* get the mux parents */
 	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
+		struct clk *clk;
 		char name[16];
 
 		snprintf(name, sizeof(name), "clkin%d", i);
-		host->mux_parent[i] = devm_clk_get(host->dev, name);
-		if (IS_ERR(host->mux_parent[i])) {
-			ret = PTR_ERR(host->mux_parent[i]);
-			if (PTR_ERR(host->mux_parent[i]) != -EPROBE_DEFER)
+		clk = devm_clk_get(host->dev, name);
+		if (IS_ERR(clk)) {
+			if (clk != ERR_PTR(-EPROBE_DEFER))
 				dev_err(host->dev, "Missing clock %s\n", name);
-			host->mux_parent[i] = NULL;
-			return ret;
+			return PTR_ERR(clk);
 		}
 
-		mux_parent_names[i] = __clk_get_name(host->mux_parent[i]);
+		mux_parent_names[i] = __clk_get_name(clk);
 	}
 
 	/* create the mux */
-- 
2.12.0

