From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v5 7/10] mmc: meson-gx: remove unneeded devm_kstrdup in
 meson_mmc_clk_init
Date: Sat, 4 Mar 2017 13:26:24 +0100
Message-ID: <a2189677-3f90-b054-6f4d-4b6fc2d97a8c@gmail.com>
References: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34245 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdCDMi5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 07:38:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id m70so6820389wma.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 Mar 2017 04:38:22 -0800 (PST)
In-Reply-To: <a76c3483-2c86-85c1-446e-f2522bd28aa8@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

CLK core does a deep copy of init.name, therefore it's fully ok to
provide a local variable.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Kevin Hilman <khilman@baylibre.com>
---
v2:
- fixed commit message
- added acked-by
v3:
- no changes
v4:
- no changes
v5:
- no changes
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 002e4aac..684cc088 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -281,7 +281,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 
 	/* create the divider */
 	snprintf(clk_name, sizeof(clk_name), "%s#div", dev_name(host->dev));
-	init.name = devm_kstrdup(host->dev, clk_name, GFP_KERNEL);
+	init.name = clk_name;
 	init.ops = &clk_divider_ops;
 	init.flags = CLK_SET_RATE_PARENT;
 	clk_div_parents[0] = __clk_get_name(host->mux_clk);
-- 
2.12.0


