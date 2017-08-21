From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 01/16] mmc: meson-gx: fix mux mask definition
Date: Mon, 21 Aug 2017 18:02:46 +0200
Message-ID: <20170821160301.21899-2-jbrunet@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:38187 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbdHUQDH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 12:03:07 -0400
Received: by mail-wr0-f171.google.com with SMTP id p8so39037054wrf.5
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 09:03:06 -0700 (PDT)
In-Reply-To: <20170821160301.21899-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

CCF generic mux will shift the mask using the value defined in shift
Define the mask accordingly

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index de962c2d5e00..4217287923d4 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -366,7 +366,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.num_parents = MUX_CLK_NUM_PARENTS;
 	host->mux.reg = host->regs + SD_EMMC_CLOCK;
 	host->mux.shift = __bf_shf(CLK_SRC_MASK);
-	host->mux.mask = CLK_SRC_MASK;
+	host->mux.mask = CLK_SRC_MASK >> host->mux.shift;
 	host->mux.flags = 0;
 	host->mux.table = NULL;
 	host->mux.hw.init = &init;
-- 
2.9.5

