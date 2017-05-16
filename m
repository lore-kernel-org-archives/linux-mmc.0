From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 1/5] mmc: cavium-octeon: Fix interrupt enable code
Date: Tue, 16 May 2017 11:36:51 +0200
Message-ID: <20170516093655.17746-2-jglauber@cavium.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33292 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbdEPJhW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 05:37:22 -0400
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

From: David Daney <david.daney@cavium.com>

OCTEON SoCs with CIU3 do not have interrupt masking local to the MMC
bus interface.  Unfortunately, some even have a diagnostic register at
the same address of the enable register, which causes the interrupts
to fire immediately if stored to, thus breaking the driver.  The proper
action on these SoCs is not to touch this register.

Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
Signed-off-by: David Daney <david.daney@cavium.com>
[jglauber@cavium.com: removed point after subject line]
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 772d090..d698d66 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -108,7 +108,7 @@ static void octeon_mmc_release_bus(struct cvm_mmc_host *host)
 static void octeon_mmc_int_enable(struct cvm_mmc_host *host, u64 val)
 {
 	writeq(val, host->base + MIO_EMM_INT(host));
-	if (!host->dma_active || (host->dma_active && !host->has_ciu3))
+	if (!host->has_ciu3)
 		writeq(val, host->base + MIO_EMM_INT_EN(host));
 }
 
-- 
2.9.0.rc0.21.g7777322

