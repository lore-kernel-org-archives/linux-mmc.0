From: Derek Simkowiak <derek@webtuner.tv>
Subject: Re: [PATCH 0/3]mmc: Support-FFU-for-eMMC-v5.0
Date: Thu, 6 Nov 2014 11:12:03 -0800
Message-ID: <545BC803.1040206@webtuner.tv>
References: <FDD07FEB422EF948A392FDC201AEEAE64F6AFCDA@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [207.46.100.71] ([207.46.100.71]:52420 "EHLO
	na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751638AbaKFTnv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 6 Nov 2014 14:43:51 -0500
In-Reply-To: <FDD07FEB422EF948A392FDC201AEEAE64F6AFCDA@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "'cjb@laptop.org'" <cjb@laptop.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, Gwendal Grignou <gwendal@google.com>

Regarding v5.0: a while ago, Romain wrote a small eMMC 5.0 patch that 
Ulf ack'd:

http://comments.gmane.org/gmane.linux.kernel.mmc/23795

But this patch got lost and was never merged.  I wanted to re-submit on 
Romain's behalf but haven't been able to find the time.  Perhaps you 
could take this task?

I have verified that this patch is necessary for my Jedec 5.0 hardware.


Thanks,
Derek

On 11/06/2014 07:41 AM, Avi Shchislowski wrote:
> The Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
>   JESD84-B50.pdf)
>     
>   http://www.jedec.org/standards-documents/technology-focus-areas/flash-
>   memory-ssds-ufs-emmc/e-mmc
>   
>   *New ioctl has been add:
>   * [Alex Lemberg] "MMC_FFU_INVOKE - transfer the new Firmware data from user spac[Alex Lemberg]space
>   	to the eMMC deivce and install the new image[Alex Lemberg] firmware.
> * This solution allows to:
> - Complete eMMC 5.0 FFU procedure as an atomic operation, without being interrupted by other IO requests
> - Not limited Firmware data size. Using Multiple Write operations.
> - Support of both EXT_CSD_MODE_OPERATION_CODES modes [Alex Lemberg]
> * The solution is using "udev" device manager to transfer FW data from user space to eMMC driver [Alex Lemberg]
> * Pre-existing functions from mmc_test were used in this solution.
>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>
> Avi Shchislowski (3):
>    mmc: add eMMC5.0 ffu ext_csd fields
>    mmc: Support FFU for eMMC v5.0 1/2
>    mmc: Support FFU for eMMC v5.0 2/2
>
>   drivers/mmc/card/Kconfig    |    8 +
>   drivers/mmc/card/block.c    |    5 +
>   drivers/mmc/card/mmc_test.c |   97 +--------
>   drivers/mmc/core/Makefile   |    1 +
>   drivers/mmc/core/core.c     |  128 ++++++++++++
>   drivers/mmc/core/mmc.c      |    9 +
>   drivers/mmc/core/mmc_ffu.c  |  487 +++++++++++++++++++++++++++++++++++++++++++
>   include/linux/mmc/card.h    |    2 +
>   include/linux/mmc/core.h    |   30 +++
>   include/linux/mmc/mmc.h     |    9 +
>   10 files changed, 690 insertions(+), 86 deletions(-)  create mode 100644 drivers/mmc/core/mmc_ffu.c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

