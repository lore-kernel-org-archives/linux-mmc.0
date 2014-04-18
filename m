From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: SDHCI DDR50 implies MMC DDR
Date: Fri, 18 Apr 2014 15:55:39 +0200
Message-ID: <20140418155539.5d43a9c8@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ZYPgCYlKaEjr4wQWybyE+HZ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:17102 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaDRNzh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Apr 2014 09:55:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>

--MP_/ZYPgCYlKaEjr4wQWybyE+HZ
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

shouldn't we add something like that do auto-detect MMC_CAP_1_8V_DDR on
sdhci controller ?


Matthieu
--MP_/ZYPgCYlKaEjr4wQWybyE+HZ
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-sdhci-UHS-DDR50-implies-MMC-DDR.patch"

>From f821501dada7041521fe80a5fe92bdc8b15f055b Mon Sep 17 00:00:00 2001
From: Matthieu CASTET <matthieu.castet@parrot.com>
Date: Fri, 18 Apr 2014 15:49:05 +0200
Subject: [PATCH] sdhci : UHS DDR50 implies MMC DDR

---
 drivers/mmc/host/sdhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a79fc4..2b7478e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2971,6 +2971,11 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
+	/* DDR50 implies MMC DDR at 1.8 or 3.3 */
+	if ((caps[1] & SDHCI_SUPPORT_DDR50) &&
+		!(host->quirks2 & SDHCI_QUIRK2_BROKEN_DDR50))
+		mmc->caps |= MMC_CAP_1_8V_DDR;
+
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
 	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
1.9.2


--MP_/ZYPgCYlKaEjr4wQWybyE+HZ--
