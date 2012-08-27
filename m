From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: core: Quieten "could not set regulator OCR" error.
Date: Mon, 27 Aug 2012 19:33:45 -0400
Message-ID: <87a9xfyko6.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33043 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab2H0Xds (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:33:48 -0400
Received: from c-76-24-28-220.hsd1.ma.comcast.net ([76.24.28.220] helo=octavius.laptop.org)
	by void.printf.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <cjb@laptop.org>)
	id 1T68oV-00034y-9D
	for linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 00:33:47 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Some distributions build with CONFIG_REGULATOR_DUMMY=y -- this makes
regulator setup succeed harmlessly, but then trying to set the voltage
on the dummy regulator will fail as below:

[ 6.413866] sdhci-pci 0000:03:00.0: SDHCI controller found [1180:e822]
(rev 0)
[ 6.414081] _regulator_get: 0000:03:00.0 supply vmmc not found, using
dummy regulator
[ 6.415252] mmc0: SDHCI controller on PCI [0000:03:00.0] using DMA
[ 6.415294] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
[ 6.444241] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
[ 6.473648] sdhci-pci 0000:03:00.0: could not set regulator OCR (-22)
[..]

Since this isn't an error in this case, move the error to pr_debug().
Reference: https://bugs.archlinux.org/task/29008

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 835c9f0..30d9357 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1017,8 +1017,9 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	}
 
 	if (result)
-		dev_err(mmc_dev(mmc),
-			"could not set regulator OCR (%d)\n", result);
+		pr_debug("%s: could not set regulator OCR (%d)\n",
+			 mmc_hostname(mmc), result);
+
 	return result;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_set_ocr);
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
