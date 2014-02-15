From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND 0/5]  update selection of bus speed mode for eMMC
Date: Sat, 15 Feb 2014 23:18:18 +0900
Message-ID: <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53341 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaBOOSU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 09:18:20 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N11009DQJQIB900@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 15 Feb 2014 23:18:18 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

This series contains the change for selection of bus speed mode.
Previous implementation is complicated and some sequence is duplicated.
And specially, HS400 mode eMMC5.0 is introduced this time.

- Continued/Updated since "[PATCH 0/3] mmc: update bus speed mode" series.
  (Applied some comments from Ulf Hansson, Jackey Shen.)
- Tested at EXYNOS SOC.

Seungwon Jeon (5):
  mmc: drop the speed mode of card's state
  mmc: identify available device type to select
  mmc: step power class after final selection of bus mode
  mmc: rework selection of bus speed mode
  mmc: add support for HS400 mode of eMMC5.0

 drivers/mmc/core/bus.c     |   10 +-
 drivers/mmc/core/core.c    |    3 +-
 drivers/mmc/core/debugfs.c |    5 +-
 drivers/mmc/core/mmc.c     |  690 ++++++++++++++++++++++++++++----------------
 drivers/mmc/core/sd.c      |   16 +-
 drivers/mmc/core/sd.h      |    1 -
 drivers/mmc/core/sdio.c    |    8 +-
 include/linux/mmc/card.h   |   32 +--
 include/linux/mmc/host.h   |   42 +++-
 include/linux/mmc/mmc.h    |   23 ++-
 10 files changed, 529 insertions(+), 301 deletions(-)


