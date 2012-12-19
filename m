From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 0/2] mmc: sdio: enhance irq handling during suspend/resume
Date: Wed, 19 Dec 2012 20:12:08 +0800
Message-ID: <1355919130-28702-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:46155 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258Ab2LSMMm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 07:12:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha


This patchset aim to enhance sdio irq handling during suspend/resume so as to
wakeup host system with sdio card interrupt.

Kevin Liu (2):
 mmc: sdio: defer sdio irq handling when host suspended
 mmc: sdio: handle interrupt corner case during suspend

 drivers/mmc/core/sdio.c       |   59 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/sdio_irq.c   |    5 +++
 include/linux/mmc/host.h      |    5 +++
 include/linux/mmc/sdio_func.h |    6 ++++
 4 files changed, 73 insertions(+), 2 deletions(-)
