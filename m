From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [PATCH 0/3]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 6 Nov 2014 15:41:54 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64F6AFCDA@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0094.outbound.protection.outlook.com ([157.56.110.94]:44640
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751295AbaKFQPK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Nov 2014 11:15:10 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "'cjb@laptop.org'" <cjb@laptop.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Gwendal Grignou <gwendal@google.com>

The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
 JESD84-B50.pdf)
   
 http://www.jedec.org/standards-documents/technology-focus-areas/flash-
 memory-ssds-ufs-emmc/e-mmc
 
 *New ioctl has been add:
 * [Alex Lemberg] "MMC_FFU_INVOKE - transfer the new Firmware data from user spac[Alex Lemberg]space
 	to the eMMC deivce and install the new image[Alex Lemberg] firmware.
* This solution allows to:
- Complete eMMC 5.0 FFU procedure as an atomic operation, without being interrupted by other IO requests
- Not limited Firmware data size. Using Multiple Write operations.
- Support of both EXT_CSD_MODE_OPERATION_CODES modes [Alex Lemberg]
* The solution is using "udev" device manager to transfer FW data from user space to eMMC driver [Alex Lemberg]
* Pre-existing functions from mmc_test were used in this solution.

Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

Avi Shchislowski (3):
  mmc: add eMMC5.0 ffu ext_csd fields
  mmc: Support FFU for eMMC v5.0 1/2
  mmc: Support FFU for eMMC v5.0 2/2

 drivers/mmc/card/Kconfig    |    8 +
 drivers/mmc/card/block.c    |    5 +
 drivers/mmc/card/mmc_test.c |   97 +--------
 drivers/mmc/core/Makefile   |    1 +
 drivers/mmc/core/core.c     |  128 ++++++++++++
 drivers/mmc/core/mmc.c      |    9 +
 drivers/mmc/core/mmc_ffu.c  |  487 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h    |    2 +
 include/linux/mmc/core.h    |   30 +++
 include/linux/mmc/mmc.h     |    9 +
 10 files changed, 690 insertions(+), 86 deletions(-)  create mode 100644 drivers/mmc/core/mmc_ffu.c

