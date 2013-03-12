From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v3 1/4] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Tue, 12 Mar 2013 12:30:14 +0800
Message-ID: <CADz5_gK+d4fq9DJC7Joif_NT2s9JBXSonjOfR8fPezOZh61KNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:35168 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3CLEaO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:30:14 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so5322314oag.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 21:30:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>

commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
device-tree binding parser centrally. So just call it with
sdhci_get_of_property together in sdhci_pltfm_register.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c
b/drivers/mmc/host/sdhci-pltfm.c index e605509..a536e55 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -212,6 +212,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);

+	mmc_of_parse(host->mmc);
 	sdhci_get_of_property(pdev);

 	ret = sdhci_add_host(host);
--
1.7.9.5
