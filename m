From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 3/3] mmc: omap: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 23:50:25 +0200
Message-ID: <20150917215025.GA8079@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34866 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbbIQVu2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 17:50:28 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/mmc/host/omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b763b11..b9958a1 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1490,6 +1490,7 @@ static const struct of_device_id mmc_omap_match[] = {
 	{ .compatible = "ti,omap2420-mmc", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, mmc_omap_match);
 #endif
 
 static struct platform_driver mmc_omap_driver = {
-- 
2.4.6

