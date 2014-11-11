From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/3] mmc: Support FFU for eMMC v5.0
Date: Tue, 11 Nov 2014 12:33:22 +0900
Message-ID: <54618382.6080302@samsung.com>
References: <n@samsung.com>
 <1415639607-32711-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50165 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaKKDdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Nov 2014 22:33:23 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEU00GXEV7M6620@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 11 Nov 2014 12:33:22 +0900 (KST)
In-reply-to: <1415639607-32711-1-git-send-email-avi.shchislowski@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <avi.shchislowski@sandisk.com>, ulf.hansson@linaro.org
Cc: 'Chris Ball' <chris@printf.net>, linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, gwendal@google.com, CPGS <cpgs@samsung.com>

Hi,

Subjects of Patch[1/3~3/3] are same, it can be confused.

Best Regards,
Jaehoon Chung

On 11/11/2014 02:13 AM, Avi Shchislowski wrote:
> he Field Firmware Update (FFU) feature is new for eMMC 5.0 spec (Jedec:
>  JESD84-B50.pdf)
>    
>  http://www.jedec.org/standards-documents/technology-focus-areas/flash-
>  memory-ssds-ufs-emmc/e-mmc
>  
>  *New ioctl has been add:
>  * [Alex Lemberg] "MMC_FFU_INVOKE - transfer the new Firmware data from user spac[Alex Lemberg]space
>  	to the eMMC deivce and install the new image[Alex Lemberg] firmware.
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
>   mmc: Support FFU for eMMC v5.0
>   mmc: Support FFU for eMMC v5.0
>   mmc: Support FFU for eMMC v5.0
> 
>  drivers/mmc/card/Kconfig    |    8 +
>  drivers/mmc/card/block.c    |    5 +
>  drivers/mmc/card/mmc_test.c |   97 +--------
>  drivers/mmc/core/Makefile   |    1 +
>  drivers/mmc/core/core.c     |  128 ++++++++++++
>  drivers/mmc/core/mmc.c      |    9 +
>  drivers/mmc/core/mmc_ffu.c  |  487 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h    |    2 +
>  include/linux/mmc/core.h    |   30 +++
>  include/linux/mmc/mmc.h     |    9 +
>  10 files changed, 690 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/mmc/core/mmc_ffu.c
> 

