From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 0/4] mmc: sdhci-pltfm: DT related enhancements
Date: Tue, 12 Mar 2013 12:25:57 +0800
Message-ID: <CADz5_gKjN8P_Qq4fVQHxVD1tH-mRLELBrPiq6sifNy-mxn8FtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:65437 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab3CLEZ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:25:57 -0400
Received: by mail-ob0-f181.google.com with SMTP id ni5so4074813obc.26
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 21:25:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

This patchset aim to enhance DT related code in sdhci-pltfm.c by below patches:
[PATCH v3 1/4] mmc: sdhci-pltfm: add calling mmc_of_parse in
sdhci_pltfm_register
[PATCH 2/4] mmc: sdhci-pltfm: avoid indentation in sdhci_get_of_property
[PATCH v2 3/4] mmc: sdhci-pltfm: add function in sdhci_ops to parse dt property
[PATCH 4/4] mmc: sdhci-pltfm: remove host specific dt property parse code

Changelog:
Split code for different purposes into different patches.

Kevin Liu (4):
 mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
 mmc: sdhci-pltfm: avoid indentation in sdhci_get_of_property
 mmc: sdhci-pltfm: add function in sdhci_ops to parse dt property
 mmc: sdhci-pltfm: remove host specific dt property parse code

 drivers/mmc/host/sdhci-of-esdhc.c |   19 ++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c    |   51 +++++++++++++++++--------------------
 drivers/mmc/host/sdhci.h          |    1 +
 3 files changed, 44 insertions(+), 27 deletions(-)
