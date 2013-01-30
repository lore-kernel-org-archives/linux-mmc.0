From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/7] mmc: sdhci: misc code enhancement
Date: Wed, 30 Jan 2013 16:59:41 +0800
Message-ID: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51897 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752180Ab3A3I65 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 03:58:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>


This patchset aim to do several misc code enhancements for sdhci.c
This patchset based on previous patchset:
[PATCH v10 00/12] mmc: sdhci: fixes and enhancements

Introduction for the patches:

[PATCH 1/7] mmc: sdhci: avoid redundant loops in sdhci_irq for card
[PATCH 3/7] mmc: sdhci: remove redundant clock disable/enable in set
[PATCH 4/7] mmc: sdhci: remove check for CONFIG_REGULATOR

Above 3 patches removed redundant code/logic in current code.

[PATCH 2/7] mmc: sdhci: UHS-I should be disabled if vqmmc 1.8v check

Above patch add the handling for error return.

[PATCH 5/7] mmc: sdhci: enhance preset value function

Above patch enhance several points for preset value. Please see the patch comments.

[PATCH 6/7] mmc: sdhci: add regulator notifier for vqmmc
[PATCH 7/7] mmc: sdhci-pxav3: add regulator notifier for vqmmc

Above 2 patches provide platform a method to do some private task when vqmmc voltage change.

Kevin Liu (7):
 [PATCH 1/7] mmc: sdhci: avoid redundant loops in sdhci_irq for card
 [PATCH 2/7] mmc: sdhci: UHS-I should be disabled if vqmmc 1.8v check
 [PATCH 3/7] mmc: sdhci: remove redundant clock disable/enable in set
 [PATCH 4/7] mmc: sdhci: remove check for CONFIG_REGULATOR
 [PATCH 5/7] mmc: sdhci: enhance preset value function
 [PATCH 6/7] mmc: sdhci: add regulator notifier for vqmmc
 [PATCH 7/7] mmc: sdhci-pxav3: add regulator notifier for vqmmc

 drivers/mmc/core/sd.c                   |   17 ---
 drivers/mmc/host/sdhci-pxav3.c          |    2 +
 drivers/mmc/host/sdhci.c                |  172 ++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h                |   12 +++
 include/linux/mmc/host.h                |    1 -
 include/linux/mmc/sdhci.h               |    2 +
 include/linux/platform_data/pxa_sdhci.h |    2 +
 7 files changed, 128 insertions(+), 80 deletions(-)

