From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 05/18] mmc: mmc_spi: Export OF module alias information
Date: Thu, 20 Aug 2015 09:07:18 +0200
Message-ID: <1440054451-1223-6-git-send-email-javier@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabian Frederick <fabf@skynet.be>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

The SPI core always reports the MODALIAS uevent as "spi:<modalias>"
regardless of the mechanism that was used to register the device
(i.e: OF or board code) and the table that is used later to match
the driver with the device (i.e: SPI id table or OF match table).

So drivers needs to export the SPI id table and this be built into
the module or udev won't have the necessary information to autoload
the needed driver module when the device is added.

But this means that OF-only drivers needs to have both OF and SPI id
tables that have to be kept in sync and also the dev node compatible
manufacturer prefix is stripped when reporting the MODALIAS. Which can
lead to issues if two vendors use the same SPI device name for example.

To avoid the above, the SPI core behavior may be changed in the future
to not require an SPI device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table even when
is unused now to prevent breaking module loading when the core changes.

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
