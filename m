From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/3] mmc: core/sdhci: enhance card detect code
Date: Wed,  6 Mar 2013 11:28:59 +0800
Message-ID: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34479 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751215Ab3CFD2W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Mar 2013 22:28:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>


Patch 1 enhanced card removal judgement code to resolve the missing
removal event issue when card is removed slowly.
Patch 2 added callback function get_cd accordingly in sdhci.c.
Patch 3 update some card detect related code in sdhci.c and used
patch 2.

patch 1 and 2 are same as previous version except adding 
Reviewed-by/Acked-by/Tested-by.
patch 3 is added to this patchset in this version.

Kevin Liu (3)
 [PATCH v8 1/3] mmc: core: enhance card removal judgement for slow
 [PATCH v4 2/3] mmc: sdhci: add function get_cd
 [PATCH v3 3/3] mmc: sdhci: update check code for cd-broken or

 drivers/mmc/core/core.c  |   13 ++++++++++++
 drivers/mmc/host/sdhci.c |   51 ++++++++++++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 17 deletions(-)

