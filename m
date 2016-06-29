From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Wed, 29 Jun 2016 10:42:55 +0900
Message-ID: <5773279F.1080003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37790 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcF2Bm6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2016 21:42:58 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9I02E8CFFJ0G50@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Jun 2016 10:42:55 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, jerome.forissier@linaro.org, "sw0312.kim@samsung.com" <sw0312.kim@samsung.com>, Doug Anderson <dianders@chromium.org>, ben.dooks@codethink.co.uk, Jae hoon Chung <jh80.chung@gmail.com>

Dear Ulf,

Could you pull these patches into your repository (next branch)?

Best Regards,
Jaehoon Chung

The following changes since commit 466780648db4aed7722de91e9d9749c6c596=
9327:

  mmc: sh_mmcif: Use a 10s timeout in the error recovery path (2016-06-=
27 11:19:29 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 545585efee538cac5202b415a3d0c12b4556e96f=
:

  mmc: dw_mmc: fix unmap sg twice when finding data err (2016-06-29 10:=
39:05 +0900)

----------------------------------------------------------------
Ben Dooks (1):
      mmc: dw_mmc: fix 32bit little-endian access of des1 field

Doug Anderson (2):
      mmc: dw_mmc: Consider HLE errors to be data and command errors
      mmc: dw_mmc: Wait for data transfer after response errors.

Jaehoon Chung (4):
      mmc: dw_mmc: exynos: fix the NULL pointer dereference error
      mmc: dw_mmc: remove the quirks flags
      mmc: dw_mmc: add the card write threshold for HS400 mode
      mmc: dw_mmc: prevent to set the wrong value

J=C3=A9r=C3=B4me Forissier (1):
      mmc: dw_mmc: k3: add MMC_CAP_CMD23

Seung-Woo Kim (1):
      mmc: dw_mmc: remove UBSAN warning in dw_mci_setup_bus()

Shawn Lin (3):
      mmc: dw_mmc: remove redundant of set_bit and clear_bit
      mmc: dw_mmc: check card present before starting request
      mmc: dw_mmc: fix unmap sg twice when finding data err

 drivers/mmc/host/dw_mmc-exynos.c   |   2 +-
 drivers/mmc/host/dw_mmc-k3.c       |   7 ++
 drivers/mmc/host/dw_mmc-rockchip.c |   3 -
 drivers/mmc/host/dw_mmc.c          | 157 ++++++++++++++++++++++-------=
--------
 drivers/mmc/host/dw_mmc.h          |  10 +--
 include/linux/mmc/dw_mmc.h         |   9 ---
 6 files changed, 108 insertions(+), 80 deletions(-)
