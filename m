From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Fri, 05 Feb 2016 11:41:04 +0900
Message-ID: <56B40BC0.7040301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59015 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbcBEClP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 21:41:15 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O21033I5ZGGSV90@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Feb 2016 11:41:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>

Dear, Ulf.

Could you pull these patches into your repository (next branch)?

Best Regards,
Jaehoon Chung

The following changes since commit b22c960a4f2da77f4abedfa56c6b6ac14ada0656:

  mmc: core: report tuning command execution failure reason (2016-02-04 11:48:36 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 03c35ab249f965923f570d9771eac57113162b31:

  mmc: dw_mmc: fix num_slots setting (2016-02-05 00:53:50 +0900)

----------------------------------------------------------------
Jaehoon Chung (1):
      mmc: dw_mmc: remove the prepare_command hook

Shawn Lin (6):
      mmc: dw_mmc: add hw_reset support
      mmc: dw_mmc: remove struct block_settings
      mmc: dw_mmc: remove DW_MCI_QUIRK_BROKEN_CARD_DETECTION quirk
      mmc: dw_mmc: fix err handle of dw_mci_probe
      mmc: dw_mmc: remove repetitive clear interrupt
      mmc: dw_mmc: fix num_slots setting

 drivers/mmc/host/dw_mmc-exynos.c   | 31 ++++--------
 drivers/mmc/host/dw_mmc-pltfm.c    | 19 +-------
 drivers/mmc/host/dw_mmc-rockchip.c |  7 ---
 drivers/mmc/host/dw_mmc.c          | 99 +++++++++++++++++++++-----------------
 drivers/mmc/host/dw_mmc.h          |  6 ++-
 include/linux/mmc/dw_mmc.h         | 12 +----
 6 files changed, 72 insertions(+), 102 deletions(-)
