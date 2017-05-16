From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/5] mmc: cavium-octeon: Use proper GPIO name for power control
Date: Tue, 16 May 2017 11:36:52 +0200
Message-ID: <20170516093655.17746-3-jglauber@cavium.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

From: David Daney <david.daney@cavium.com>

The devm_gpiod_get_optional() function appends a "-gpios" to the
string passed to it, so if we want to find the "power-gpios" signal,
we must pass "power" to this function.

Fixes: 01d95843335c ("mmc: cavium: Add MMC support for Octeon SOCs.")
Signed-off-by: David Daney <david.daney@cavium.com>
[jglauber@cavium.com: removed point after subject line]
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-octeon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index d698d66..cbb5663 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -267,7 +267,7 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	}
 
 	host->global_pwr_gpiod = devm_gpiod_get_optional(&pdev->dev,
-							 "power-gpios",
+							 "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(host->global_pwr_gpiod)) {
 		dev_err(&pdev->dev, "Invalid power GPIO\n");
-- 
2.9.0.rc0.21.g7777322
