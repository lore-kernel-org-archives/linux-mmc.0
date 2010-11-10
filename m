From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (1/5)] mmc: sdhci-pltfm calls the sdhci_alloc_host with pdev->dev
Date: Wed, 10 Nov 2010 16:28:05 +0100
Message-ID: <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:39010 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756620Ab0KJP22 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:28 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2008699
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:26 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DED335419
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:25 +0000 (GMT)
In-Reply-To: <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

ST targets use the sdhci-pltfm driver but there are some
problems when re-insert the driver on our platforms.
Within sdhci-pltfm d.d. the pdata->init invokes own
platform function to claim some resource (based on devres):
see the example code below:

static int mmc_pad_resources(struct sdhci_host *sdhci)
{
    if (!devm_stm_pad_claim(sdhci->mmc->parent, &stx7105_mmc_pad_config,
                            dev_name(sdhci->mmc->parent)))
              return -ENODEV;
     return 0;
}

static struct sdhci_pltfm_data stx7105_mmc_platform_data = {
                .init = mmc_pad_resources,
                .quirks = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
};

static struct platform_device stx7105_mmc_device = {
                .name = "sdhci",
                .id = 0,
[snip]
                .dev = {
                      .platform_data = &stx7105_mmc_platform_data,
                }
};

void __init stx7105_configure_mmc(void)
{
 ...
        platform_device_register(&stx7105_mmc_device);
}

As soon as the sdhci-pltfm is removed from the system
the sdhci resources previously allocate are not released
and the probe fails when re-insert the module.

The platform driver calls the sdhci_alloc_host passing as device pointer
the parent.
Note: parent name is "platform" and dev name is "sdhci.0".
IMO it makes sense to pass the pdev->dev pointer instead of the parent.

In the end, this also fixes the problem described above and I can insert/remove
the sdhci-pltfm driver several times without failures.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Reviewed-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 78a8f7a..4e881a5 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -65,11 +65,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 
-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
-	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
-
+	host = sdhci_alloc_host(&pdev->dev, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto err;
-- 
1.5.5.6

