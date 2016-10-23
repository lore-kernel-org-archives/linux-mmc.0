From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Mon, 24 Oct 2016 07:52:07 +0900
Message-ID: <010f8179-56e4-88d2-1a6f-1c477a1d3f4a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34294 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754205AbcJWWwJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Oct 2016 18:52:09 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OFI00IT0VITDRB0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 24 Oct 2016 07:52:07 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

Dear Ulf,

Could you pull these patches into your mmc-next?

The following changes since commit 2a688788ba1dd1dc905c24bf5b617aefdff4a68b:

  mmc: core: Don't use ->card_busy() and CMD13 in combination when polling (2016-10-21 10:18:07 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 0a9bd53611e862d2a5e2f68513b2677b13b7b379:

  mmc: dw_mmc: remove system PM callback (2016-10-24 07:13:07 +0900)

----------------------------------------------------------------
Shawn Lin (9):
      mmc: dw_mmc: add runtime PM callback
      mmc: dw_mmc-rockchip: add runtime PM support
      mmc: core: expose the capability of gpio card detect
      mmc: dw_mmc: disable biu clk if possible
      mmc: dw_mmc-k3: deploy runtime PM facilities
      mmc: dw_mmc-exynos: deploy runtime PM facilities
      mmc: dw_mmc-pci: deploy runtime PM facilities
      mmc: dw_mmc-pltfm: deploy runtime PM facilities
      mmc: dw_mmc: remove system PM callback

 drivers/mmc/core/slot-gpio.c       |  8 +++++++
 drivers/mmc/host/dw_mmc-exynos.c   | 24 +++++++++-----------
 drivers/mmc/host/dw_mmc-k3.c       | 39 ++++++++------------------------
 drivers/mmc/host/dw_mmc-pci.c      | 29 ++++++++----------------
 drivers/mmc/host/dw_mmc-pltfm.c    | 28 +++++++----------------
 drivers/mmc/host/dw_mmc-rockchip.c | 42 +++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.c          | 46 +++++++++++++++++++++++++-------------
 drivers/mmc/host/dw_mmc.h          |  6 ++---
 include/linux/mmc/slot-gpio.h      |  1 +
 9 files changed, 117 insertions(+), 106 deletions(-)

Best Regards,
Jaehoon Chung
