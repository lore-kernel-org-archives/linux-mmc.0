From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v4 0/5]  update selection of bus speed mode for eMMC
Date: Wed, 26 Mar 2014 19:59:49 +0900
Message-ID: <000001cf48e2$81c6ec60$8554c520$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49620 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaCZK7w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Mar 2014 06:59:52 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N31004Z9IJQQH00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 26 Mar 2014 19:59:50 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

This series contains the change for selection of bus speed mode.
Previous implementation is complicated and some sequence is duplicated.
And specially, HS400 mode eMMC5.0 is introduced this time.
This patch-set has been tested in Exynos SoC.

Note: 
This patch-set depends on "[PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC".

Changes in v4:
	(5/5)Reverting to HS mode is included in mmc_select_hs400() using __mmc_switch().

Changes in v3:
 	Removed the function to check DDR type(mmc_snoop_ddr).
 	Rebased with the latest branch.

Seungwon Jeon (5):
  mmc: drop the speed mode of card's state
  mmc: identify available device type to select
  mmc: step power class after final selection of bus mode
  mmc: rework selection of bus speed mode
  mmc: add support for HS400 mode of eMMC5.0

 drivers/mmc/core/bus.c     |    9 +-
 drivers/mmc/core/core.c    |    3 +-
 drivers/mmc/core/debugfs.c |    5 +-
 drivers/mmc/core/mmc.c     |  666 ++++++++++++++++++++++++++------------------
 drivers/mmc/core/sd.c      |   16 +-
 drivers/mmc/core/sd.h      |    1 -
 drivers/mmc/core/sdio.c    |    8 +-
 include/linux/mmc/card.h   |   31 +--
 include/linux/mmc/host.h   |   42 +++-
 include/linux/mmc/mmc.h    |   23 ++-
 10 files changed, 482 insertions(+), 322 deletions(-)

Thanks,
sw-j

