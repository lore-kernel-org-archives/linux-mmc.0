From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/5] mmc: sdhci: several bug fixes
Date: Tue, 29 Jan 2013 16:21:04 +0800
Message-ID: <1359447669-20089-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46073 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753190Ab3A2IUL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 03:20:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>


This patchset aim to fix several sdhci bugs.
All the patches have been verified on sdhci-pxav3 platforms.
This patchset based on previous patch:
[PATCH v10 00/12] mmc: sdhci: fixes and enhancements

Introduction for the patches:

[PATCH 1/5] mmc: sdhci: fix transfer mode setting bug for cmds w/o
Without this patch, timeout error will occur during emmc suspend/resume
if it support sleep/awake.

[PATCH 2/5] mmc: sdhci: add function to get retunig timer count
Current code didn't follow the host spec and missed this case.

[PATCH 3/5] mmc: sdhci: correct voltage support caps when regulator
Current code have logic mistake although not leading to error.

[PATCH 4/5] mmc: sdhci: fix the bug that emmc DDR mode can't work by
[PATCH 5/5] mmc: sdhci: remove set_uhs_signaling function
Current default code in sdhci.c can't work for emmc DDR mode since
1.8v signal bit is not set. Only sdhci-pxav3.c add a callback function
set_uhs_signaling to workaround this. But this operation should be added
to sdhci.c by default as SD host spec require it clearly. Then the callback
function can be removed.

Kevin Liu (5):
 [PATCH 1/5] mmc: sdhci: fix transfer mode setting bug for cmds w/o
 [PATCH 2/5] mmc: sdhci: add function to get retunig timer count
 [PATCH 3/5] mmc: sdhci: correct voltage support caps when regulator
 [PATCH 4/5] mmc: sdhci: fix the bug that emmc DDR mode can't work by
 [PATCH 5/5] mmc: sdhci: remove set_uhs_signaling function

 drivers/mmc/host/sdhci-pxav3.c |   39 --------------------
 drivers/mmc/host/sdhci.c       |   77 ++++++++++++++++++++++++----------------
 drivers/mmc/host/sdhci.h       |    2 +-
 3 files changed, 48 insertions(+), 70 deletions(-)

