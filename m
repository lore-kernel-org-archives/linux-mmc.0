From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RESEND PATCH] mmc: mmc_spi: Export OF module alias information
Date: Wed, 16 Sep 2015 11:12:07 +0200
Message-ID: <1442394727-13963-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabian Frederick <fabf@skynet.be>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Drivers needs to export the OF id table and this be built into
the module or udev won't have the necessary information to autoload
the driver module when the device is registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/mmc/host/mmc_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index ae19d83bb9de..8ee11f4120fc 100644
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
2.4.3
