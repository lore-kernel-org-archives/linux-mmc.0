From: Roger Tseng <rogerable@realtek.com>
Subject: [PATCH 0/3] rtsx: patchset for supporting new model RTS5227
Date: Mon, 4 Feb 2013 15:45:56 +0800
Message-ID: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:49892 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab3BDHsv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Feb 2013 02:48:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, wei_wang@realsil.com.cn, Roger Tseng <rogerable@realtek.com>

The patchset makes necessary changes in mfd and mmc tree for supporting RTS5227
card reader.

Roger Tseng (3):
  MMC: rtsx: remove driving adjustment
  mfd: rtsx: implement driving adjustment to device-dependent callbacks
  mfd: rtsx: support RTS5227

 drivers/mfd/Makefile              |   2 +-
 drivers/mfd/rtl8411.c             |  16 ++-
 drivers/mfd/rts5209.c             |   8 ++
 drivers/mfd/rts5227.c             | 234 ++++++++++++++++++++++++++++++++++++++
 drivers/mfd/rts5229.c             |   8 ++
 drivers/mfd/rtsx_pcr.c            |   5 +
 drivers/mfd/rtsx_pcr.h            |   1 +
 drivers/mmc/host/rtsx_pci_sdmmc.c |   5 -
 include/linux/mfd/rtsx_pci.h      |   5 +
 9 files changed, 275 insertions(+), 9 deletions(-)
 create mode 100644 drivers/mfd/rts5227.c

-- 
1.7.12.1

