From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH] mmc: mmc_spi: Use module_spi_driver
Date: Mon, 27 Aug 2012 11:53:42 +0530
Message-ID: <1346048622-2024-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55914 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab2H0G0G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Aug 2012 02:26:06 -0400
Received: by dady13 with SMTP id y13so2320559dad.19
        for <linux-mmc@vger.kernel.org>; Sun, 26 Aug 2012 23:26:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

module_spi_driver makes the code simpler by eliminating
module_init and module_exit calls.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/mmc_spi.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 273306c..a600eab 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1532,20 +1532,7 @@ static struct spi_driver mmc_spi_driver = {
 	.remove =	__devexit_p(mmc_spi_remove),
 };
 
-
-static int __init mmc_spi_init(void)
-{
-	return spi_register_driver(&mmc_spi_driver);
-}
-module_init(mmc_spi_init);
-
-
-static void __exit mmc_spi_exit(void)
-{
-	spi_unregister_driver(&mmc_spi_driver);
-}
-module_exit(mmc_spi_exit);
-
+module_spi_driver(mmc_spi_driver);
 
 MODULE_AUTHOR("Mike Lavender, David Brownell, "
 		"Hans-Peter Nilsson, Jan Nikitenko");
-- 
1.7.4.1

