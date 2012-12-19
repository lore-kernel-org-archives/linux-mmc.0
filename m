From: Kevin Liu <kliu5@marvell.com>
Subject: mmc: sdhci: add wakeup support
Date: Wed, 19 Dec 2012 19:56:53 +0800
Message-ID: <1355918216-28213-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:49591 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852Ab2LSL50 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 06:57:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha


This patchset add the support for sdhci host to wakeup system from suspend.
Specifically, sdio card interrupt and sd card insert/removal can
wake up host system.
The first patch aim to fix a irq bug while the other two aim to enable
the wakeup function.

Kevin Liu (3):
 mmc: sdhci: disable interrupt before free_irq
 mmc: sdhci: add wake up support
 mmc: sdhci-pxav3: add wake up support

 drivers/mmc/host/sdhci-pxav3.c          |    7 ++++
 drivers/mmc/host/sdhci.c                |   61 ++++++++++++++++++++++---------
 include/linux/platform_data/pxa_sdhci.h |    2 +
 3 files changed, 53 insertions(+), 17 deletions(-)
