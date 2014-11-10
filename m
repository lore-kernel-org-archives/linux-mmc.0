From: Avi Shchislowski <avi.shchislowski@sandisk.com>
Subject: [PATCH 0/3] mmc: Support FFU for eMMC v5.0
Date: Mon, 10 Nov 2014 19:13:27 +0200
Message-ID: <1415639607-32711-1-git-send-email-avi.shchislowski@sandisk.com>
References: <n>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0067.outbound.protection.outlook.com ([157.56.110.67]:9184
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752641AbaKJRNk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Nov 2014 12:13:40 -0500
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: avi.shchislowski@sandisk.com, cjb@laptop.org, linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, gwendal@google.com, Alex Lemberg <alex.lemberg@sandisk.com>

he Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
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
  mmc: Support FFU for eMMC v5.0
  mmc: Support FFU for eMMC v5.0
  mmc: Support FFU for eMMC v5.0

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
 10 files changed, 690 insertions(+), 86 deletions(-)
 create mode 100644 drivers/mmc/core/mmc_ffu.c

-- 
1.7.9.5

