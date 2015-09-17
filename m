From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 2/3] mmc: moxart: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 23:49:59 +0200
Message-ID: <20150917214959.GA8028@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36177 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbIQVuC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 17:50:02 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonas Jensen <jonas.jensen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/mmc/host/moxart-mmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 006f186..79905ce 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -711,6 +711,7 @@ static const struct of_device_id moxart_mmc_match[] = {
 	{ .compatible = "faraday,ftsdc010" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, moxart_mmc_match);
 
 static struct platform_driver moxart_mmc_driver = {
 	.probe      = moxart_probe,
-- 
2.4.6

