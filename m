From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Fri, 24 Aug 2012 09:23:06 +0900
Message-ID: <5036C96A.7070300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61027 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2HXAXY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 20:23:24 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9800FEYH2FGE40@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 09:23:23 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9800AWYH2YCS10@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 09:23:23 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

eMMC card revision have increased more faster than before.
We need to prepare the next eMMC revision(eMMCx.0).
Its revision is 0x7. (eMMC4.5 is 0x6 - can get the information at ext_csd register)

Jaehoon Chung (2):
  mmc: core: prepare the next version of eMMC card
  mmc: core: add the quirk for broken revision

 drivers/mmc/core/mmc.c     |   15 ++++++++++-----
 include/linux/mmc/card.h   |    1 +
 include/linux/mmc/host.h   |    1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

-- 
1.7.4.1
