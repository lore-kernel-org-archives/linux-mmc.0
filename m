From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/7] mmc: dw_mmc: minor code cleanup
Date: Tue, 21 Jan 2014 19:16:53 +0900
Message-ID: <52DE4915.3080009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:65482 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaAUKQa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 05:16:30 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZQ00KSEXVHR110@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 21 Jan 2014 19:16:29 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

This patch-set is minor code cleanup.

Jaehoon Chung (7):
  mmc: core add the property for hs200
  mmc: dw_mmc: use the mmc_of_parse() instead of local parser
  mmc: dw_mmc: replace the bus_hz checking point
  mmc: dw_mmc: remove unused member variable.
  mmc: dw-mmc: fix minor coding style.
  mmc: dw_mmc: remove the unnecessary function.
  mmc: dw_mmc: remove the dw_mci_of_cd_gpio()

 drivers/mmc/core/host.c    |    4 ++
 drivers/mmc/host/dw_mmc.c  |  139 +++++---------------------------------------
 include/linux/mmc/dw_mmc.h |   14 -----
 3 files changed, 19 insertions(+), 138 deletions(-)

-- 
1.7.9.5
