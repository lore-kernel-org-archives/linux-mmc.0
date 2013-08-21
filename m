From: "Christian Daudt" <csd@broadcom.com>
Subject: RE: [patch] mmc: sdhci-bcm-kona: '|' vs '&' typo
Date: Wed, 21 Aug 2013 14:30:11 +0000
Message-ID: <400A4C8D93A8FA4CAECDE394033FA86A2AD236D7@SJEXCHMB09.corp.ad.broadcom.com>
References: <20130821082423.GA5240@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20130821082423.GA5240@elgon.mountain>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Dan,
 Good catch. This fix is already in the "ARM: mmc: fix NONREMOVABLE test in sdhci-bcm-kona" patch that is part of the git pull request sent to armsoc yesterday:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/193422.html

 Thanks,
   Csd

-----Original Message-----
From: Dan Carpenter [mailto:dan.carpenter@oracle.com] 
Sent: Wednesday, August 21, 2013 1:24 AM
To: Chris Ball
Cc: Grant Likely; Rob Herring; Christian Daudt; Arnd Bergmann; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; kernel-janitors@vger.kernel.org
Subject: [patch] mmc: sdhci-bcm-kona: '|' vs '&' typo

The intent was to test if a flag was set.  In the current code the
conditions are always true.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff.  Untested.

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 87175f9..9ffac0b 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -263,7 +263,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
 		(mmc_gpio_get_cd(host->mmc) != -ENOSYS) ? 'Y' : 'N',
 		(mmc_gpio_get_ro(host->mmc) != -ENOSYS) ? 'Y' : 'N');
 
-	if (host->mmc->caps | MMC_CAP_NONREMOVABLE)
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
 	dev_dbg(dev, "is_8bit=%c\n",
@@ -282,7 +282,7 @@ static int __init sdhci_bcm_kona_probe(struct platform_device *pdev)
 	}
 
 	/* if device is eMMC, emulate card insert right here */
-	if (host->mmc->caps | MMC_CAP_NONREMOVABLE) {
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE) {
 		ret = sdhci_bcm_kona_sd_card_emulate(host, 1);
 		if (ret) {
 			dev_err(dev,


