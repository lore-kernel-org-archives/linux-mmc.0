From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 0/8] mmc: dw_mmc: minor code cleanup
Date: Tue, 28 Jan 2014 17:24:51 +0900
Message-ID: <52E76953.7090308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:23737 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822AbaA1IYW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 03:24:22 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N03004KARCLD7D0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Jan 2014 17:24:21 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

This patch-set is minor code cleanup.

Change-log V2:
	- Add the new patch(mmc: core use the broken-cd for non-removable card
	- Change the name of hs200 property.
	- Based on latest mmc-next.

Jaehoon Chung (8):
  mmc: core add the property for hs200
  mmc: dw_mmc: use the mmc_of_parse() instead of local parser
  mmc: dw_mmc: replace the bus_hz checking point
  mmc: dw_mmc: remove unused member variable.
  mmc: dw-mmc: fix minor coding style.
  mmc: dw_mmc: remove the unnecessary function.
  mmc: dw_mmc: remove the dw_mci_of_cd_gpio()
  mmc: core: use the broken-cd for non-removable card

 Documentation/devicetree/bindings/mmc/mmc.txt |    2 +
 drivers/mmc/core/core.c                       |    4 +-
 drivers/mmc/core/host.c                       |   10 +-
 drivers/mmc/host/dw_mmc.c                     |  160 ++++---------------------
 include/linux/mmc/dw_mmc.h                    |   14 ---
 5 files changed, 37 insertions(+), 153 deletions(-)

-- 
1.7.9.5
