From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/4] mmc: dw_mmc: cleanup codes
Date: Fri, 05 Sep 2014 14:14:56 +0900
Message-ID: <1409894100-4713-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45765 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbaIEFPG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Sep 2014 01:15:06 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NBE00IJ7X95GLC0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Sep 2014 14:15:05 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

This patch-set fixed the wrong variable type and remove the unused codes.

Jaehoon Chung (4):
  mmc: dw_mmc: modify the variable type
  mmc: dw_mmc: remove the blk-settings structure
  mmc: dw_mmc: remove the unused quirk.
  mmc: dw_mmc: fixed wrong condtion checking.

 drivers/mmc/host/dw_mmc-exynos.c |    5 ++---
 drivers/mmc/host/dw_mmc.c        |   15 ++++-----------
 drivers/mmc/host/dw_mmc.h        |    4 ++--
 include/linux/mmc/dw_mmc.h       |   15 ++-------------
 4 files changed, 10 insertions(+), 29 deletions(-)

-- 
1.7.9.5

