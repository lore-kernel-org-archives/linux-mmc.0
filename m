From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [RFC PATCH 0/1] mmc: Support-FFU-for-eMMC-v5.0
Date: Sun, 9 Feb 2014 09:07:12 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE63F49606B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:41826
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612AbaBIJHQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 9 Feb 2014 04:07:16 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'cjb@laptop.org'" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Grant Grundler <grundler@chromium.org>

Add Support to Field Firmware Update (FFU) for eMMC v5.0 and up devices.
 
  The code implemented according to  JEDEC eMMC spec - JESD84-B50.pdf
  http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc
  
  The FFU code in driver should be called by the IOCTL interface.
  
  FFU code is divided to two logical parts:
  
  1. FFU Download firmware - transfer FW Image data to the eMMC device
  2. FFU install - Complete new FW installation. Implemented according to MODE_OPERATION_CODES field in EXT_CSD register:
     a. Host sets FFU_INSTALL
   or
     b. Host set MODE_CONFIG to normal and send card_init

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

 drivers/mmc/card/Kconfig  |    8 +
 drivers/mmc/card/Makefile |    1 +
 drivers/mmc/card/block.c  |   12 +
 drivers/mmc/card/ffu.c    |  605 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/ffu.h   |   63 +++++
 include/linux/mmc/mmc.h   |    9 +
 6 files changed, 698 insertions(+), 0 deletions(-)  create mode 100644 drivers/mmc/card/ffu.c  create mode 100644 include/linux/mmc/ffu.h

--
1.7.5.4


