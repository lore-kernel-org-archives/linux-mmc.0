From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: pxamci: fix the device-tree probe deferral path
Date: Wed,  3 Feb 2016 23:19:52 +0100
Message-ID: <1454537992-15839-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-mmc@vger.kernel.org

When the gpio driver is probed after the mmc one, the read/write gpio
and card detection one return -EPROBE_DEFER. Unfortunately, the memory
region remains requested, and upon the next probe, the probe will fail
anyway with -EBUSY.

Fix this by releasing the memory resource upon probe failure.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 28a057fae0a1..405ec339a1b8 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -657,7 +657,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (!r || irq < 0)
 		return -ENXIO;
 
-	r = request_mem_region(r->start, SZ_4K, DRIVER_NAME);
+	r = devm_request_mem_region(&pdev->dev, r->start, SZ_4K, DRIVER_NAME);
 	if (!r)
 		return -EBUSY;
 
@@ -840,7 +840,6 @@ out:
 	}
 	if (mmc)
 		mmc_free_host(mmc);
-	release_resource(r);
 	return ret;
 }
 
-- 
2.1.4
