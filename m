From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/2] mmc: core: fix the HS200 mode
Date: Mon, 23 Apr 2012 18:10:59 +0900
Message-ID: <002e01cd2131$0010af60$00320e20$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64693 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab2DWJOd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 05:14:33 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2X00DT0DHDZMI0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Apr 2012 18:11:00 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M2X00FGODIBIKV0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Apr 2012 18:11:00 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Includes fixes for eMMC related with HS200.

Seungwon Jeon (2):
      mmc: core: fix the decision of mmc card-type
      mmc: core: fix the signaling 1.8V for HS200

 drivers/mmc/core/mmc.c   |   97 ++++++++++++++++++++-------------------------
 include/linux/mmc/card.h |    4 ++
 include/linux/mmc/mmc.h  |   60 ----------------------------
 3 files changed, 47 insertions(+), 114 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


