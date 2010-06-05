From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] s5pc110: SDHCI-s3c can override host capabilities
Date: Sat, 05 Jun 2010 11:40:53 +0900
Message-ID: <20100605024053.GA23419@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:46081 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab0FEClA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2010 22:41:00 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L3I00IHXSSAKU@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 11:40:58 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3I00J0PSSAU0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 05 Jun 2010 11:40:58 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org, ben-linux@fluff.org

Each board can override the default sdhci host capabilities.
Some board has broken features by hardwares and support 8-bit bandwidth.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/plat-samsung/dev-hsmmc.c b/arch/arm/plat-samsung/dev-hsmmc.c
index 4c05b39..d0887da 100644
--- a/arch/arm/plat-samsung/dev-hsmmc.c
+++ b/arch/arm/plat-samsung/dev-hsmmc.c
@@ -65,4 +65,6 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc1.c b/arch/arm/plat-samsung/dev-hsmmc1.c
index e49bc4c..e45a82e 100644
--- a/arch/arm/plat-samsung/dev-hsmmc1.c
+++ b/arch/arm/plat-samsung/dev-hsmmc1.c
@@ -65,4 +65,6 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
diff --git a/arch/arm/plat-samsung/dev-hsmmc2.c b/arch/arm/plat-samsung/dev-hsmmc2.c
index 824580b..5ee3b89 100644
--- a/arch/arm/plat-samsung/dev-hsmmc2.c
+++ b/arch/arm/plat-samsung/dev-hsmmc2.c
@@ -66,4 +66,6 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 		set->cfg_gpio = pd->cfg_gpio;
 	if (pd->cfg_card)
 		set->cfg_card = pd->cfg_card;
+	if (pd->host_caps)
+		set->host_caps = pd->host_caps;
 }
