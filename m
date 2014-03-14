From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v3 0/5]  update selection of bus speed mode for eMMC
Date: Fri, 14 Mar 2014 21:16:08 +0900
Message-ID: <003a01cf3f7f$2e170210$8a450630$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44769 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbaCNMQJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 08:16:09 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2F009FFE2WNK10@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Mar 2014 21:16:08 +0900 (KST)
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
 drivers/mmc/core/mmc.c     |  681 +++++++++++++++++++++++++++-----------------
 drivers/mmc/core/sd.c      |   16 +-
 drivers/mmc/core/sd.h      |    1 -
 drivers/mmc/core/sdio.c    |    8 +-
 include/linux/mmc/card.h   |   31 +--
 include/linux/mmc/host.h   |   42 +++-
 include/linux/mmc/mmc.h    |   23 ++-
 10 files changed, 497 insertions(+), 322 deletions(-)

Thanks,
Sw-j

