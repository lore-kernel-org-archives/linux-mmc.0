From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2] mmc: sdhci-pxav3: set_uhs_signaling is initialized twice differently
Date: Fri, 15 Aug 2014 13:55:42 +0100
Message-ID: <1408107342-20318-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58547 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaHOMzr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Aug 2014 08:55:47 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so797110wiv.11
        for <linux-mmc@vger.kernel.org>; Fri, 15 Aug 2014 05:55:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, zhangfei.gao@marvell.com, prakity@marvell.com, rmk+kernel@arm.linux.org.uk
Cc: peter.griffin@linaro.org, patches@linaro.org, lee.jones@linaro.org

.set_uhs_signaling field is currently initialised twice once to the
arch specific callback pxav3_set_uhs_signaling, and also to the generic
sdhci_set_uhs_signaling callback.

This means that uhs is currently broken for this platform currently, as pxav3
has some special constriants which means it can't use the generic callback.

This happened in
commit 96d7b78cfc2f ("mmc: sdhci: convert sdhci_set_uhs_signaling() into a library function")
commit a702c8abb2a9 ("mmc: host: split up sdhci-pxa, create sdhci-pxav3.c")'

Fix this and hopefully prevent it happening in the future by ensuring named
initialisers always follow the declaration order in the structure definition.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 6f842fb..3f350ea 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -229,7 +229,6 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = pxav3_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
-- 
1.9.1

