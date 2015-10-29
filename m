From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Update dw-mmc controller
Date: Thu, 29 Oct 2015 10:46:09 +0900
Message-ID: <56317A61.9050709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38829 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbJ2BqL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2015 21:46:11 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NWY02BADKWXZ910@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 29 Oct 2015 10:46:09 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Jaehoon Chung <jh80.chung@samsung.com>

Dear, Ulf.

Here are dw-mmc patches.
Could you pull these patches into your repository?
If there is any problem, let me know, plz. Thanks!

Best Regards,
Jaehoon Chung

The following changes since commit 1c6e58d83615678875bf52747f8841c49291dfcf:

  mmc: pwrseq: Use highest priority for eMMC restart handler (2015-10-27 11:11:06 +0100)

are available in the git repository at:

  https://github.com/jh80chung/dw-mmc.git for-ulf

for you to fetch changes up to 1505969f5972b0c2827a6ab83e5424ff3a465c08:

  mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode (2015-10-28 22:51:13 +0900)

----------------------------------------------------------------
Dan Carpenter (1):
      mmc: dw_mmc: NULL dereference in error message

Jaehoon Chung (2):
      mmc: dw_mmc: fix the CardThreshold boundary at CardThrCtl register
      mmc: dw_mmc: fix the wrong setting for UHS-DDR50 mode

 drivers/mmc/host/dw_mmc.c | 5 ++---
 drivers/mmc/host/dw_mmc.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)
