From: Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: [PATCH 0/3] mmc: FFU for eMMC v5.0
Date: Thu, 13 Nov 2014 18:28:55 +0200
Message-ID: <1415896135-27114-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0080.outbound.protection.outlook.com ([157.56.111.80]:53568
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932888AbaKMQ3M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Nov 2014 11:29:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, chris@printf.net, Alex.Lemberg@sandisk.com, Avi Shchislowski <avi.shchislowski@sandisk.com>, Alex Lemberg <alex.lemberg@sandisk.com>

 The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
 JESD84-B50.pdf)
   
 http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc

 
 
 * This solution allows to:
  - Complete eMMC 5.0 FFU procedure as an atomic operation, without being interrupted by other IO requests
  - Not limited Firmware data size. Using Multiple Write operations.
  - Support of both EXT_CSD_MODE_OPERATION_CODES modes
 * The solution is using "udev" device manager to transfer FW data from user space to eMMC driver
 * Pre-existing functions from mmc_test were used in this solution.

 *New ioctl has been add:
  -transfer the new Firmware data from user space
   to the eMMC deivce and install the newfirmware.
 
Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>


Avi Shchislowski (3):
  mmc: Add eMMC5.0 ffu ext_csd field
  mmc: move some mmc_test.c function to core.c
  mmc: Support FFU for eMMC v5.0

 drivers/mmc/card/Kconfig    |    8 +
 drivers/mmc/card/block.c    |    5 +
 drivers/mmc/card/mmc_test.c |   97 +--------
 drivers/mmc/core/Makefile   |    1 +
 drivers/mmc/core/core.c     |  128 ++++++++++++
 drivers/mmc/core/mmc.c      |    3 +
 drivers/mmc/core/mmc_ffu.c  |  487 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h    |    1 +
 include/linux/mmc/core.h    |   30 +++
 include/linux/mmc/mmc.h     |    8 +
 10 files changed, 682 insertions(+), 86 deletions(-)
 create mode 100644 drivers/mmc/core/mmc_ffu.c

-- 
1.7.9.5

