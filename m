From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/4] Cleanup setup_clock callback from dw_mmc
Date: Thu, 28 Jan 2016 09:30:16 +0800
Message-ID: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:57189 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935959AbcA1BfB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 20:35:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>


Hello Jeahoon

Currently dw_mmc is a little too queen-size. As we had cleanup
prepare_command callback some days before, there are also some
ones deserve to remove. Also we should avoid add new quirks or
callbacks into dw_mmc in order to avoid the dilemma sdhci meets
now.

This patchset remove setup_clock callback. Obviously, adding a
callback just for one-time-used clk stuff makes no sense. We combine
what setup_clock does before into init callback. For exynos platfrom,
it needs call init hook after resume, so we add new argument in init
hook to indicate whether it needs do clk stuff or not.



Shawn Lin (4):
  mmc: dw_mmc-rockchip: remove setup_clock for rockchip
  mmc: dw_mmc: add setup_clk for init hook
  mmc: dw_mmc-exynos: remove dw_mci_exynos_setup_clock
  mmc: dw_mmc: remove setup_clock callback

 drivers/mmc/host/dw_mmc-exynos.c   | 15 ++++-----------
 drivers/mmc/host/dw_mmc-rockchip.c | 14 +++++---------
 drivers/mmc/host/dw_mmc.c          | 11 +----------
 drivers/mmc/host/dw_mmc.h          |  3 +--
 4 files changed, 11 insertions(+), 32 deletions(-)

-- 
2.3.7


