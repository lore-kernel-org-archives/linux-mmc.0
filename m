From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/4] mmc: dw_mmc: some fiex for host driver
Date: Sun, 20 May 2012 13:27:09 +0900
Message-ID: <003101cd3640$d1f76270$75e62750$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38531 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab2ETE1L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 May 2012 00:27:11 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M4B00GRL0D9GD70@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 20 May 2012 13:27:09 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M4B00G2Z0D9O620@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Sun, 20 May 2012 13:27:09 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

This patch-set includes fixes for the Synopsys DesignWare MMC driver

Seungwon Jeon (4):
      mmc: dw_mmc: fix the transmission handling in IDMAC
      mmc: dw_mmc: fix the IDMAC sw reset
      mmc: dw_mmc: fix the wrong sequence
      mmc: dw_mmc: correct the calculation for CLKDIV

drivers/mmc/host/dw_mmc.c |   31 +++++++++++++++++--------------
1 files changed, 17 insertions(+), 14 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


