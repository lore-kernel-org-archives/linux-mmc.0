From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v3 0/8] mmc: dw_mmc: minor code cleanup
Date: Mon, 03 Feb 2014 20:15:34 +0900
Message-ID: <52EF7A56.2060707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9422 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbaBCLPh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Feb 2014 06:15:37 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0F001B339YP080@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 03 Feb 2014 20:15:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>

This patch-set is minor code cleanup.

Change-log V3:
	- Maintained original code for non-removable checking.
	- Add patch (mmc: dw_mmc: fix the checking whether card is present or not)

Change-log V2:
	- Add the new patch(mmc: core use the broken-cd for non-removable card
	- Change the name of hs200 property.
	- Based on latest mmc-next.

Jaehoon Chung (8):
  mmc: core: add the property for hs200
  mmc: dw_mmc: use the mmc_of_parse() instead of localparse
  mmc: dw_mmc: replace the bus_hz checking point
  mmc: dw_mmc: remove unused member variable.
  mmc: dw_mmc: fix minor coding style.
  mmc: dw_mmc: remove the unnecessary function.
  mmc: dw_mmc: remove the dw_mci_of_cd_gpio()
  mmc: dw_mmc: fix the checking whether card is present or not

 Documentation/devicetree/bindings/mmc/mmc.txt      |    2 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    5 -
 drivers/mmc/core/host.c                            |    4 +
 drivers/mmc/host/dw_mmc.c                          |  147 +++-----------------
 include/linux/mmc/dw_mmc.h                         |   14 --
 5 files changed, 26 insertions(+), 146 deletions(-)

-- 
1.7.9.5
