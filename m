From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 00/12] mmc: remove the MMC_DATA_STREAM flag
Date: Fri, 29 Jan 2016 13:05:59 +0900
Message-ID: <1454040371-31625-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44354 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbcA2EGT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 23:06:19 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1P02CB34QH27C0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Jan 2016 13:06:17 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, Jaehoon Chung <jh80.chung@samsung.com>

This patchset is related to remove the MMC_DATA_STREAM.
It's not set to MMC_DATS_STREAM anywhere.
This flag had been used with CDM11 and CMD20.
But CMD11/CMD20 have become obsolete.
To reduce the confusion, removed the unnecessary flag.

Jaehoon Chung (12):
  mmc: core: use the defined function to check whether card is removable
  mmc: atmel-mci: remove the MMC_DATA_STREAM flag
  mmc: bfin_sdh: remove the MMC_DATA_STREAM flag
  mmc: davinci_mmc: remove the MMC_DATA_STREAM flag
  mmc: dw_mmc: remove the MMC_DATA_STREAM flag
  mmc: jz4740_mmc: remove the MMC_DATA_STREAM flag
  mmc: mxcmmc: remove the MMC_DATA_STREAM flag
  mmc: pxamci: remove the MMC_DATA_STREAM flag
  mmc: s3cmci: remove the MMC_DATA_STREAM flag
  mmc: sunxi-mmc: remove the MMC_DATA_STREAM flag
  mmc: core: remove the MMC_DATA_STREAM flag
  mmc: block: don't use the OR operation for flag of data

 drivers/mmc/card/block.c       |  6 +++---
 drivers/mmc/core/core.c        |  9 ++++-----
 drivers/mmc/host/atmel-mci.c   |  9 ++-------
 drivers/mmc/host/bfin_sdh.c    |  3 ---
 drivers/mmc/host/davinci_mmc.c | 15 +++------------
 drivers/mmc/host/dw_mmc.c      |  2 --
 drivers/mmc/host/jz4740_mmc.c  |  2 --
 drivers/mmc/host/mxcmmc.c      |  3 ---
 drivers/mmc/host/pxamci.c      |  6 ------
 drivers/mmc/host/s3cmci.c      |  3 +--
 drivers/mmc/host/sunxi-mmc.c   |  5 -----
 include/linux/mmc/core.h       |  1 -
 12 files changed, 13 insertions(+), 51 deletions(-)

-- 
1.9.1

