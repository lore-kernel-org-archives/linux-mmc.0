From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 0/5] Add the dw-mmc patches
Date: Tue, 28 Aug 2012 16:55:40 +0900
Message-ID: <503C797C.7060501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54159 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab2H1Hzp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 03:55:45 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9G00D2LGN3DU60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:43 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9G00HF0GOUGT20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:43 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

These patches added some feature for dw-mmc.
Maybe specific portion of these patches should conflicted with the Thomas's patches.
(If Thomas's patch is applied, i will fix the latest kernel.)

Changelog v2:
	- add the fix the present flags for card detect.
	- applied with Will and Suengwon's comments

Jaehoon Chung (5):
  mmc: dw-mmc: ensure that the card is not busy when changing clock
  mmc: dw-mmc: add the platdata related with clock
  mmc: dw-mmc: add the header file for exynos specific code.
  mmc: dw-mmc: add the use_hold_reg in CMD register
  mmc: dw-mmc: fix the present flags for card detect

 drivers/mmc/host/dw_mmc.c         |   73 +++++++++++++++++++++++++++++++++----
 drivers/mmc/host/dw_mmc.h         |    2 +
 include/linux/mmc/dw_mmc.h        |   11 ++++++
 include/linux/mmc/exynos-dw_mmc.h |   61 +++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/mmc/exynos-dw_mmc.h

-- 
1.7.4.1
