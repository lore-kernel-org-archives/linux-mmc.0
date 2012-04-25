From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 0/2] mmc: core: fix the HS200 mode
Date: Wed, 25 Apr 2012 16:17:10 +0900
Message-ID: <004a01cd22b3$6e343ce0$4a9cb6a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:65425 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab2DYHRM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 03:17:12 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M30009T7XKI0J10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Apr 2012 16:17:11 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M30006TBXKM3C90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Apr 2012 16:17:10 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Includes fixes for eMMC related with HS200.

Changes in v2:
    - PATCH 1/2: Combine both the if conditions (from Subhash Jadavani)

Seungwon Jeon (2):
      mmc: core: fix the decision of mmc card-type
      mmc: core: fix the signalling 1.8V for HS200

 drivers/mmc/core/mmc.c   |   93 +++++++++++++++++++--------------------------
 include/linux/mmc/card.h |    4 ++
 include/linux/mmc/mmc.h  |   60 -----------------------------
 3 files changed, 43 insertions(+), 114 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


