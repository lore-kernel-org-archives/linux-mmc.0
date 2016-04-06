From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Wed, 06 Apr 2016 10:56:45 +0900
Message-ID: <57046CDD.7090403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39666 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcDFB4u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 21:56:50 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O5603396W2M7Q80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 06 Apr 2016 10:56:46 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf.

Could you pull these patches into your repository (next branch)?

Best Regards,
Jaehoon Chung

The following changes since commit 49f6c1ea8c8e96d610f713741544ae6adc5499eb:

  Merge branch 'fixes' into next (2016-04-05 13:11:07 +0200)

are available in the git repository at:


  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to c5495422af70fa424424cbf2c689d12af2d4296d:

  mmc: dw_mmc: remove setup_clock callback (2016-04-06 08:19:50 +0900)

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: exynos: add the function for controlling SMU

Shawn Lin (8):
      mmc: dw_mmc-rockchip: remove dw_mci_rockchip_pmops
      mmc: dw_mmc-rockchip: fix failing to mount partition with "discard"
      mmc: dw_mmc: fix warning reported by kernel-doc
      mmc: dw_mmc: avoid using dmaengine_terminate_all
      mmc: dw_mmc: remove unused EVENT_XFER_ERROR
      mmc: dw_mmc-rockchip: remove setup_clock for rockchip
      mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
      mmc: dw_mmc: remove setup_clock callback

 drivers/mmc/host/dw_mmc-exynos.c   | 23 +++++++++++---------
 drivers/mmc/host/dw_mmc-rockchip.c | 43 +++++++++++++-------------------------
 drivers/mmc/host/dw_mmc.c          | 11 +---------
 drivers/mmc/host/dw_mmc.h          |  2 --
 include/linux/mmc/dw_mmc.h         | 12 +++++++++--
 5 files changed, 38 insertions(+), 53 deletions(-)
