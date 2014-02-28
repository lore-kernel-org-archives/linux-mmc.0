From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/6] mmc: sdhci-bcm-kona: fix build errors when built-in
Date: Fri, 28 Feb 2014 21:32:24 +0000
Message-ID: <E1WJV2e-000429-1D@rmk-PC.arm.linux.org.uk>
References: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60164 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752299AbaB1Vc1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 16:32:27 -0500
In-Reply-To: <20140228212936.GA21483@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Markus Mayer <markus.mayer@linaro.org>, Christian Daudt <csd@broadcom.com>, Matt Porter <matt.porter@linaro.org>

`sdhci_bcm_kona_remove' referenced in section `.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o

Fixes: 058feb53666f ("mmc: sdhci-bcm-kona: make linker-section warning go away")
Cc: Markus Mayer <markus.mayer@linaro.org>
Cc: Christian Daudt <csd@broadcom.com>
Cc: Matt Porter <matt.porter@linaro.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 7a190fe4dff1..e5565aa5ed36 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -314,7 +314,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
+static int sdhci_bcm_kona_remove(struct platform_device *pdev)
 {
 	return sdhci_pltfm_unregister(pdev);
 }
-- 
1.8.3.1

