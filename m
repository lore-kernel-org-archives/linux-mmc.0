From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 13/18] mmc: meson-gx: remove unneeded meson_mmc_clk_set in
 meson_mmc_clk_init
Date: Tue, 14 Feb 2017 21:06:57 +0100
Message-ID: <f891a0bd-62f3-8104-5658-5e8fb2d9e070@gmail.com>
References: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33911 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753839AbdBNUHs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2017 15:07:48 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so5236471wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2017 12:07:48 -0800 (PST)
In-Reply-To: <420b75a9-b8c2-b3d7-ae60-3ed8a5a18ead@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

I don't think this clk_disable_unprepare is right here. We do this
in meson_mmc_remove what should be sufficient.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 74ceda75..39904fb5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -315,11 +315,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	/* Get the nearest minimum clock to 400KHz */
 	host->mmc->f_min = clk_round_rate(host->cfg_div_clk, 400000);
 
-	ret = meson_mmc_clk_set(host, host->mmc->f_min);
-	if (!ret)
-		clk_disable_unprepare(host->cfg_div_clk);
-
-	return ret;
+	return meson_mmc_clk_set(host, host->mmc->f_min);
 }
 
 static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
2.11.1


