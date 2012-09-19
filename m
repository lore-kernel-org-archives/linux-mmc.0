From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dt: Support "broken-cd" property in sdhci-pltfm
Date: Wed, 19 Sep 2012 04:29:22 -0400
Message-ID: <m3haquh0v1.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54951 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab2ISI25 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 04:28:57 -0400
Received: from 173-166-109-250-newengland.hfc.comcastbusiness.net ([173.166.109.250] helo=pullcord.laptop.org)
	by void.printf.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1TEFeS-0008Iq-Bq
	for linux-mmc@vger.kernel.org; Wed, 19 Sep 2012 09:28:56 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

As (currently) used by sdhci-pxav3.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d9a4ef4..65551a9 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -75,6 +75,9 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (sdhci_of_wp_inverted(np))
 			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
+		if (of_get_property(np, "broken-cd", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
