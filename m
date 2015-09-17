From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 1/3] mmc: mmc_spi: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 23:49:28 +0200
Message-ID: <20150917214928.GA8019@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34241 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbIQVtb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2015 17:49:31 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabian Frederick <fabf@skynet.be>, Stephen Warren <swarren@nvidia.com>, linux-mmc@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/mmc/host/mmc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index ae19d83..8ee11f4 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1511,6 +1511,7 @@ static const struct of_device_id mmc_spi_of_match_table[] = {
 	{ .compatible = "mmc-spi-slot", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, mmc_spi_of_match_table);
 
 static struct spi_driver mmc_spi_driver = {
 	.driver = {
-- 
2.4.6

