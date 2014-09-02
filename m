From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2] mmc: pxamci: prepare and unprepare the clocks
Date: Tue,  2 Sep 2014 11:23:55 +0200
Message-ID: <1409649835-13778-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:21392 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbaIBJYP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:24:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>

Add the clock prepare and unprepare call to the driver set_ios calls
phase. This will remove a warning once the PXA architecture is migrated
to the clock infrastructure.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 32fe113..96406e8 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -474,7 +474,7 @@ static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		unsigned int clk = rate / ios->clock;
 
 		if (host->clkrt == CLKRT_OFF)
-			clk_enable(host->clk);
+			clk_prepare_enable(host->clk);
 
 		if (ios->clock == 26000000) {
 			/* to support 26MHz */
@@ -501,7 +501,7 @@ static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		pxamci_stop_clock(host);
 		if (host->clkrt != CLKRT_OFF) {
 			host->clkrt = CLKRT_OFF;
-			clk_disable(host->clk);
+			clk_disable_unprepare(host->clk);
 		}
 	}
 
-- 
1.9.1

