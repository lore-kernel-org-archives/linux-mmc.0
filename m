From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 00/11] mmc: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:25 +0900
Message-ID: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbcBAMHj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:39 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V01IXVB0P3Z80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:37 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

This patchset is related to remove the MMC_DATA_STREAM.
It's not set to MMC_DATS_STREAM anywhere.
This flag had been used with CDM11 and CMD20.
But CMD11/CMD20 have become obsolete.
To reduce the confusion, removed the unnecessary flag.

Changelog V2:
	- Fixed commit message.
	- Added Robert's Acked-by for pxamci host controller.

Jaehoon Chung (11):
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
 11 files changed, 9 insertions(+), 46 deletions(-)

-- 
1.9.1

