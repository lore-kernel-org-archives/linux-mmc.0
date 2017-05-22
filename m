From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 3/3] mmc: cavium: Fix probing race with regulator
Date: Mon, 22 May 2017 13:09:21 +0200
Message-ID: <20170522110921.15395-4-jglauber@cavium.com>
References: <20170522110921.15395-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522110921.15395-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>
List-Id: linux-mmc@vger.kernel.org

If the regulator probing is not yet finished this driver
might catch a -EPROBE_DEFER. Returning after this condition
did not remove the created platform device. On a repeated
call to the probe function the of_platform_device_create
fails.

Calling of_platform_device_destroy after EPROBE_DEFER resolves
this bug.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-octeon.c   | 11 ++++++++++-
 drivers/mmc/host/cavium-thunderx.c |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index cbb5663..951d2cd 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -288,11 +288,20 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "Error populating slots\n");
 			octeon_mmc_set_shared_power(host, 0);
-			return ret;
+			goto error;
 		}
 		i++;
 	}
 	return 0;
+
+error:
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
+		if (host->slot[i])
+			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i])
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+	}
+	return ret;
 }
 
 static int octeon_mmc_remove(struct platform_device *pdev)
diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index fe3d772..b9cc959 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -146,6 +146,12 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 	return 0;
 
 error:
+	for (i = 0; i < CAVIUM_MAX_MMC; i++) {
+		if (host->slot[i])
+			cvm_mmc_of_slot_remove(host->slot[i]);
+		if (host->slot_pdev[i])
+			of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
+	}
 	clk_disable_unprepare(host->clk);
 	return ret;
 }
-- 
2.9.0.rc0.21.g7777322
