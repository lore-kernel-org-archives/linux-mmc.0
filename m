From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update codes relevant to dw-mmc controller
Date: Thu, 05 Mar 2015 14:59:09 +0900
Message-ID: <54F7F0AD.5080903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13624 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbbCEF7L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 00:59:11 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NKQ001WF5YMSH30@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Mar 2015 14:59:10 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, addy ke <addy.ke@rock-chips.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Alim Akhtar <alim.akhtar@samsung.com>

Dear, Ulf.

I didn't find that your-tree is rebased to v4.0-rc2.
This pull-request is based on your next branch(v4.0-rc1).
If i have to rebase this work for v4.0-rc2, let me know, plz.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git tags/v4.0-2-for-ulf

for you to fetch changes up to 7aa3dc1a9ed5f38fa491016cff8cbec383bac805:

  mmc: dw_mmc: Don't crash if we get an interrupt before slot has initted (2015-03-04 23:39:23 +0900)

----------------------------------------------------------------
Main feature:
- Support HS400 mode for designware controller.

----------------------------------------------------------------
Doug Anderson (5):
      mmc: dw_mmc: Make sure we only adjust the clock when power is on
      mmc: dw_mmc: Give a good reset after we give power
      mmc: dw_mmc: Don't start commands while busy
      mmc: dw_mmc: Only enable CD after setup and only if needed
      mmc: dw_mmc: Don't crash if we get an interrupt before slot has initted

Seungwon Jeon (1):
      mmc: dw_mmc: exynos: Support eMMC's HS400 mode

addy ke (2):
      mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME capability
      mmc: dw_mmc: fix mmc_test by not sending abort for DRTO/EBE errors

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
 drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
 drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |    8 +
 drivers/mmc/host/dw_mmc.c                          |  142 ++++++++++++---
 drivers/mmc/host/dw_mmc.h                          |    2 +
 6 files changed, 309 insertions(+), 54 deletions(-)
