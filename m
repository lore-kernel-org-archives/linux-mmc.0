From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 1/3] mmc/sdhci-spear: No need to check 'pdev == NULL' in probe
Date: Tue, 27 Mar 2012 08:40:34 +0530
Message-ID: <841301f38cfc2d1170378306f1640d7653652505.1332817654.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:34022 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757255Ab2C0D1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 23:27:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, sr@denx.de, Viresh Kumar <viresh.kumar@st.com>

pdev is guaranteed to be valid in probe. And so check is not required to check
if it is non-NULL. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mmc/host/sdhci-spear.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 6dfa82e..15191c1 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -75,8 +75,6 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	struct spear_sdhci *sdhci;
 	int ret;
 
-	BUG_ON(pdev == NULL);
-
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
 		ret = -ENOMEM;
-- 
1.7.10.rc2.10.gb47606

