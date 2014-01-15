From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/5]  update selection of bus speed mode for eMMC
Date: Wed, 15 Jan 2014 23:13:36 +0900
Message-ID: <002601cf11fb$fae8fbb0$f0baf310$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57313 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaAOONh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:13:37 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZG007XG4UOXE50@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 15 Jan 2014 23:13:36 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>
Cc: linux-mmc@vger.kernel.org

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


