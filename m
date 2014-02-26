From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] mmc: sdhci-bcm-kona: fix build errors when built-in
Date: Wed, 26 Feb 2014 11:42:13 +0000
Message-ID: <E1WIcsP-0003s2-1q@rmk-PC.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51361 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752187AbaBZLmS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2014 06:42:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Markus Mayer <markus.mayer@linaro.org>, Christian Daudt <csd@broadcom.com>, Matt Porter <matt.porter@linaro.org>

`sdhci_bcm_kona_remove' referenced in section `.data' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o

Fixes: 058feb53666f ("mmc: sdhci-bcm-kona: make linker-section warning go away")
Cc: Markus Mayer <markus.mayer@linaro.org>
Cc: Christian Daudt <csd@broadcom.com>
Cc: Matt Porter <matt.porter@linaro.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Spotted in nightly build testing, this really should not have happened.
The commit which caused it does more damage than good by changing more
than it should have to fix the warning it reports to have fixed, by
turning it into a build error instead.  Please be more careful in
future when making such changes to fully understand what the section
mismatch errors mean and more importantly, exactly what they're referring
to.  Thanks.

 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 20096aaf14b4..e05c39e6292f 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -318,7 +318,7 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
+static int sdhci_bcm_kona_remove(struct platform_device *pdev)
 {
 	return sdhci_pltfm_unregister(pdev);
 }
-- 
1.8.3.1

