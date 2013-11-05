From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/3] mmc: update bus speed mode
Date: Tue, 05 Nov 2013 22:27:00 +0900
Message-ID: <003301ceda2a$b573a660$205af320$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56497 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab3KEN1D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 08:27:03 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVS00DUULD07B80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Nov 2013 22:27:01 +0900 (KST)
In-reply-to: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

This series contains the change for selection of bus speed mode.
Previous implementation is a little complicated and some sequence
is duplicated. And specially, HS400 mode eMMC5.0 is introduced this time.

Seungwon Jeon (3):
  mmc: rework selection of bus speed mode
  mmc: correct some exclusive card state to clear
  mmc: add support for hs400 mode of eMMC5.0

 drivers/mmc/core/bus.c   |    3 +-
 drivers/mmc/core/core.c  |    1 -
 drivers/mmc/core/mmc.c   |  694 ++++++++++++++++++++++++++++++----------------
 drivers/mmc/core/sd.c    |    5 +-
 drivers/mmc/core/sdio.c  |    5 +-
 include/linux/mmc/card.h |   51 +++-
 include/linux/mmc/host.h |   12 +-
 include/linux/mmc/mmc.h  |   12 +-
 8 files changed, 522 insertions(+), 261 deletions(-)


Thanks,
Seungwon Jeon

