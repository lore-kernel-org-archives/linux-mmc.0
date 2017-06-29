From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update DWMMC controller
Date: Thu, 29 Jun 2017 20:18:36 +0900
Message-ID: <f1a21b88-ad29-74c8-d917-bc324069d267@samsung.com>
References: <CGME20170629111836epcas1p121e8e67839212fd967091905d647cc3b@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:39208 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdF2LSj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jun 2017 07:18:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf,

Could you pull these patches to mmc-next?
If there is a problem, let me know, plz. Sorry for late.


The following changes since commit 2fe35968feccaee61413edbe54bec66bc80a67a7:

  mmc: renesas-sdhi: improve checkpatch cleanness (2017-06-20 10:30:50 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to df596cbdcb63563ab259448b0dbe006eab3b2fd5:

  mmc: dw_mmc: remove the unnecessary slot variable (2017-06-29 20:15:44 +0900)

----------------------------------------------------------------
Jaehoon Chung (6):
      mmc: dw_mmc: deprecated the "num-slots" property
      mmc: dw_mmc: remove the loop about finding slots
      mmc: dw_mmc: change the array of slots
      mmc: dw_mmc: remove the 'id' arguments about functions relevant to slot
      mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
      mmc: dw_mmc: remove the unnecessary slot variable

Shawn Lin (2):
      dt-bindings: rockchip-dw-mshc: add optional rockchip, desired-num-phases
      mmc: dw_mmc-rockchip: parse rockchip, desired-num-phases from DT

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   4 +
 drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |  48 +++---
 drivers/mmc/host/dw_mmc.c                          | 165 +++++++--------------
 drivers/mmc/host/dw_mmc.h                          |   7 +-
 5 files changed, 91 insertions(+), 137 deletions(-)
