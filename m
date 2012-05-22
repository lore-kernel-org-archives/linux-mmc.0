From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 0/4] mmc: dw_mmc: some fiex for hosw driver
Date: Tue, 22 May 2012 13:00:45 +0900
Message-ID: <006701cd37cf$76e576c0$64b06440$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17205 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab2EVEAr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 May 2012 00:00:47 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4E00I0WOH9OVF0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:00:45 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4E005T4OH960G0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 May 2012 13:00:45 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

This patch-set includes fixes for the Synopsys DesignWare MMC driver

Changes in v2:
        - fix the error handling(mmc: dw_mmc: fix the IDMAC sw reset)

Seungwon Jeon (4):
      mmc: dw_mmc: fix the transmission handling in IDMAC
      mmc: dw_mmc: fix the IDMAC sw reset
      mmc: dw_mmc: fix the wrong sequence
      mmc: dw_mmc: correct the calculation for CLKDIV

drivers/mmc/host/dw_mmc.c |   36 +++++++++++++++++++-----------------
1 files changed, 19 insertions(+), 17 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


