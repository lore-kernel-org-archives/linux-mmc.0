From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 3/5] regulator: Support driver probe deferral
Date: Fri, 07 Oct 2011 10:05:25 +0500
Message-ID: <1317962127-29003-4-git-send-email-manjugk@ti.com>
References: <1317962127-29003-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Greg Kroah-Hartman <greg@kroah.com>, Dilan Lee <dilee@nvidia.com>, Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org


From: Mark Brown <broonie@opensource.wolfsonmicro.com>

If we fail to locate a requested regulator return -EPROBE_DEFER. If drivers
pass this error code through to their caller (which they really should)
then this will ensure that the probe is retried later when further devices
become available.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
[manjugk@ti.com: changed error value from EAGAIN to EPROBE_DEFER]
Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Liam Girdwood <lrg@ti.com>
---
Cc: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <greg@kroah.com>
Cc: Dilan Lee <dilee@nvidia.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>

 drivers/regulator/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d8e6a42..95dfd21 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1153,7 +1153,7 @@ static struct regulator *_regulator_get(struct device *dev, const char *id,
 {
 	struct regulator_dev *rdev;
 	struct regulator_map *map;
-	struct regulator *regulator = ERR_PTR(-ENODEV);
+	struct regulator *regulator = ERR_PTR(-EPROBE_DEFER);
 	const char *devname = NULL;
 	int ret;
 
@@ -2668,7 +2668,7 @@ struct regulator_dev *regulator_register(struct regulator_desc *regulator_desc,
 		if (!found) {
 			dev_err(dev, "Failed to find supply %s\n",
 				init_data->supply_regulator);
-			ret = -ENODEV;
+			ret = -EPROBE_DEFER;
 			goto scrub;
 		}
 
-- 
1.7.4.1

