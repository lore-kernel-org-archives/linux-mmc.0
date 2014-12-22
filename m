From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v3 0/3] mmc: dw_mmc: update host driver with minor fixes
Date: Mon, 22 Dec 2014 17:42:01 +0530
Message-ID: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15445 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaLVMTh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Dec 2014 07:19:37 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NGZ0041AGWNUX10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 22 Dec 2014 21:19:35 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, linux-arm-kernel@lists.infradead.org

This series is part of [1] which are send by Seungwon jeon few months back.
when he attempted to add HS400 support for exynos dw_mmc host controller.
Since then these patches are just sitting idle.
This is my attempt to land some of the changes which are generic, and performance
booter on dw_mmc host controller.

These patches are already ACKed by Jaehoon Chung.

[1] http://www.spinics.net/lists/linux-samsung-soc/msg27903.html

Changes in v3:
      None, just a rebase on ulf's next branch.


Seungwon Jeon (3):
  mmc: dw_mmc: fix the max_blk_count in IDMAC
  mmc: dw_mmc: exynos: don't use if clock isn't available
  mmc: dw_mmc: exynos: move definitions to header file

 drivers/mmc/host/dw_mmc-exynos.c |   59 +++++++++-----------------------------
 drivers/mmc/host/dw_mmc-exynos.h |   56 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        |    4 +--
 3 files changed, 71 insertions(+), 48 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h

-- 
1.7.9.5

