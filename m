From: <wei_wang@realsil.com.cn>
Subject: [PATCH 0/3] Fix sd3.0 issues for Realtek card reader
Date: Wed, 21 Aug 2013 09:46:24 +0800
Message-ID: <cover.1377049122.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:55451 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3HUBqt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2013 21:46:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, rogerable@realtek.com, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

Wei WANG (3):
  mfd:mmc:rtsx: Change default tx phase
  mmc:rtsx:Clear SD_CLK toggle enable bit if switching voltage fail
  mmc:memstick:rtsx: Modify copyright comments

 drivers/memstick/host/rtsx_pci_ms.c |    3 +-
 drivers/mfd/rtl8411.c               |    4 ++
 drivers/mfd/rts5209.c               |    2 +
 drivers/mfd/rts5227.c               |    2 +
 drivers/mfd/rts5229.c               |    2 +
 drivers/mfd/rts5249.c               |    2 +
 drivers/mmc/host/rtsx_pci_sdmmc.c   |   70 +++++++++++++++++++++++++----------
 include/linux/mfd/rtsx_pci.h        |   15 ++++++++
 8 files changed, 79 insertions(+), 21 deletions(-)

-- 
1.7.9.5

