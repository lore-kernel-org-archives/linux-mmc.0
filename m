From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Mon, 18 May 2015 12:44:17 +0900
Message-ID: <55596011.7030308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55186 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbERDoT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 May 2015 23:44:19 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NOJ00DQJ11TZBB0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 May 2015 12:44:17 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>

Dear, Ulf.

Could you pull these patches for mmc-next?

Best Regards,
Jaehoon Chung

The following changes since commit d689a660983cf600bd73e5f79650785471f3c13a:

  mmc: cast unsigned int to typeof(sector_t) to avoid unexpected error (2015-05-11 12:16:38 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-next-for-ulf

for you to fetch changes up to 33865962d87357cd39e446fc89e5509557483668:

  mmc: dw_mmc: rockchip: Fix modalias to make module auto-loading work (2015-05-18 05:41:28 +0900)

----------------------------------------------------------------
- Support the hi6200
- Fix modailis to make module auto-loading work
- Use core to handle absent write protect line

----------------------------------------------------------------
Lars-Peter Clausen (1):
      mmc: dw_mmc: Use core to handle absent write protect line

Zhangfei Gao (6):
      Document: dw_mmc-k3: add document of hi6220 mmc
      mmc: dw_mmc: add switch_voltage
      mmc: dw_mmc: k3: support hi6220
      mmc: dw_mmc: k3: Fix modalias to make module auto-loading work
      mmc: dw_mmc: exynos: Fix modalias to make module auto-loading work
      mmc: dw_mmc: rockchip: Fix modalias to make module auto-loading work

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |  28 ++++++
 drivers/mmc/host/dw_mmc-exynos.c                   |   2 +-
 drivers/mmc/host/dw_mmc-k3.c                       | 105 ++++++++++++++++++++-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   2 +-
 drivers/mmc/host/dw_mmc.c                          |  57 +++++------
 drivers/mmc/host/dw_mmc.h                          |   5 +-
 include/linux/mmc/dw_mmc.h                         |   6 --
 7 files changed, 155 insertions(+), 50 deletions(-)
