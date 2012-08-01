From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/3] mmc: dw_mmc: some fixes for error handling
Date: Wed, 01 Aug 2012 09:29:58 +0900
Message-ID: <006201cd6f7c$c9c06730$5d413590$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52109 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2HAAaE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jul 2012 20:30:04 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M8100CAAW1XEL60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:01 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M8100M0TW1ZRD90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:01 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

This patch-set includes fixes for the Synopsys DesignWare MMC driver

Seungwon Jeon (3):
      mmc: dw_mmc: amend using error interrupt status
      mmc: dw_mmc: correct mishandling error interrupt
      mmc: dw_mmc: fix error handling in PIO mode

drivers/mmc/host/dw_mmc.c |   44 ++++++++------------------------------------
1 files changed, 8 insertions(+), 36 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


