From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 5/5] mmc: cavium: Fix probing race with regulator
Date: Tue, 16 May 2017 11:36:55 +0200
Message-ID: <20170516093655.17746-6-jglauber@cavium.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33446 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbdEPJhb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2017 05:37:31 -0400
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

If the regulator probing is not yet finished this driver
might catch a -EPROBE_DEFER. Returning after this condition
did not remove the created platform device. On a repeated
call to the probe function the of_platform_device_create
fails.

Calling of_platform_device_destroy after EPROBE_DEFER resolves
this bug.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/mmc/host/cavium-thunderx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
index fe3d772..257535e 100644
--- a/drivers/mmc/host/cavium-thunderx.c
+++ b/drivers/mmc/host/cavium-thunderx.c
@@ -137,8 +137,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
 				continue;
 
 			ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
-			if (ret)
+			if (ret) {
+				of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
 				goto error;
+			}
 		}
 		i++;
 	}
-- 
2.9.0.rc0.21.g7777322

