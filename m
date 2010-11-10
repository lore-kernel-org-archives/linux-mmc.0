From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH 5/5] mmc: sdhci-pltfm can wake up.
Date: Wed, 10 Nov 2010 16:28:09 +0100
Message-ID: <1289402889-14160-7-git-send-email-peppe.cavallaro@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-5-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-6-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:39641 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756604Ab0KJP2s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:48 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C436199
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:46 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 978565419
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:46 +0000 (GMT)
In-Reply-To: <1289402889-14160-6-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 4e881a5..6ea32e1 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -100,6 +100,8 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 			goto err_plat_init;
 	}
 
+	host->mmc->pm_flags = MMC_PM_KEEP_POWER;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_add_host;
-- 
1.5.5.6

