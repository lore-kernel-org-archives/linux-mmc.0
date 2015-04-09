From: Jaehoon Chung <jh80.chung@gmail.com>
Subject: [GIT PULL] Update codes relevant to dw-mmc controller for mmc-next
Date: Thu, 09 Apr 2015 10:01:15 +0900
Message-ID: <5525CF5B.9030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27638 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbbDIBBS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 21:01:18 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NMI00GXALI3NW80@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 09 Apr 2015 10:01:16 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, 'Chris Ball' <chris@printf.net>

The following changes since commit f5c5179b9a8ab8e3255f78e233d94ea54f23f832:

  mmc: core: Convert the error field in struct mmc_command|data into an int (2015-04-08 12:10:20 +0200)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-for-ulf

for you to fetch changes up to 4836d36be8b291827aceeceda4fbe3f8e5f3ad13:

  mmc: dw_mmc: Add locking around cmd11 timer (2015-04-08 23:13:03 +0900)

----------------------------------------------------------------
Main update:
- Modify the dw-mmc IO accessors
- Update codes to prevent the malfunction for cmd11 timer 

----------------------------------------------------------------
Ben Dooks (3):
      mmc: dw_mmc: make IO accessors endian agnostic
      mmc: dw_mmc: change idmac descriptor files to __le32
      mmc: dw_mmc: fix fifo ordering in big endian

Doug Anderson (3):
      mmc: dw_mmc: Increase cmd11 timeout to 500ms
      mmc: dw_mmc: Add a return in an unexpected cmd11 timeout
      mmc: dw_mmc: Add locking around cmd11 timer

 drivers/mmc/host/dw_mmc.c  |  126 ++++++++++++++++++++++++--------------------
 drivers/mmc/host/dw_mmc.h  |   26 ++++++---
 include/linux/mmc/dw_mmc.h |    4 +-
 3 files changed, 91 insertions(+), 65 deletions(-)
