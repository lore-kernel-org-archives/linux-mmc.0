From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update codes relevant to dw-mmc controller
Date: Mon, 30 Mar 2015 09:44:44 +0900
Message-ID: <55189C7C.50201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:59215 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbC3ApC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Mar 2015 20:45:02 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM000A6X22LR0C0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 30 Mar 2015 09:44:45 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, 'Chris Ball' <chris@printf.net>

Dear, Ulf.

Sorry for updating too late..
ASAP, I will request pull for patches of dw-mmc controller at next time.
If needs anything, let me know, plz.

The following changes since commit 40de191e55585db80793e1c01d051fb539042d15:

  mmc: core: Enable runtime PM management of host devices (2015-03-27 14:57:50 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-for-ulf

for you to fetch changes up to 21db9218155ad2cb75cf0111b07da6cce7452d30:

  mmc: dw_mmc: Don't try to enable the CD until we're sure we're not deferring (2015-03-30 01:29:23 +0900)

----------------------------------------------------------------
Main update:
- Add the cmd11 timer to detect a timeout.
- Fixes: bcafaf5470f0 ("mmc: dw_mmc: Only enable CD after setup and only if needed"

----------------------------------------------------------------
Doug Anderson (2):
      mmc: dw_mmc: Add a timeout for sending CMD11
      mmc: dw_mmc: Don't try to enable the CD until we're sure we're not deferring

Jaehoon Chung (1):
      mmc: dw_mmc: enable card read threshold when mode is HS400

 drivers/mmc/host/dw_mmc.c  |   33 ++++++++++++++++++++++++++++++---
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 32 insertions(+), 3 deletions(-)
