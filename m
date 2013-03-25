From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/4] mmc: sdhci-pxav3: misc enhancements
Date: Mon, 25 Mar 2013 17:42:55 +0800
Message-ID: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47261 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754996Ab3CYJmI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 05:42:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>


This patchset aim to enhance sdhci-pxav3 with below patches (please get
detailed info in patch commmit message):
[PATCH RESEND 1/4] mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
[PATCH RESEND 2/4] mmc: sdhci-pxav3: remove cd-broken quirk for permanently
[PATCH RESEND 3/4] mmc: sdhci-pxav3: enhance device tree parser code
[PATCH RESEND v5 4/4] mmc: sdhci-pxav3: controller should use SDCLK for

Kevin Liu (4):
 mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
 mmc: sdhci-pxav3: remove cd-broken quirk for permanently
 mmc: sdhci-pxav3: enhance device tree parser code
 mmc: sdhci-pxav3: controller should use SDCLK for

 drivers/mmc/host/sdhci-pxav3.c |   47 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)
