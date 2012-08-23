From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/5] Add the dw-mmc patches
Date: Thu, 23 Aug 2012 20:31:48 +0900
Message-ID: <503614A4.4010403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22746 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101Ab2HWLcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 07:32:04 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9700L0VHD7CG20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:03 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9700JGCHDFWSB0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 20:32:03 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

These patches added some feature for dw-mmc.

Jaehoon Chung (5):
  mmc: dw-mmc: fixed the section mismatch in reference
  mmc: dw-mmc: ensure that the card is not busy when changing clock.
  mmc: dw-mmc: add the platdata related with clock
  mmc: dw-mmc: add the header file for exynos specific code.
  mmc: dw-mmc: add the use_hold_reg in CMD register

 drivers/mmc/host/dw_mmc-pltfm.c   |    4 +-
 drivers/mmc/host/dw_mmc.c         |   71 +++++++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h         |    2 +
 include/linux/mmc/dw_mmc.h        |   11 ++++++
 include/linux/mmc/exynos-dw_mmc.h |   55 ++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/mmc/exynos-dw_mmc.h

-- 
1.7.4.1
