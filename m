From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v4] Samsung: add new card detection methods in s3c-sdhci
 driver (platform part)
Date: Fri, 23 Jul 2010 09:32:01 +0900
Message-ID: <004801cb29fe$7fb23ad0$7f16b070$%kim@samsung.com>
References: <000501cb2977d6cf210846d630$%szyprowski@samsung.com>
 <1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:65488 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab0GWAcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2010 20:32:05 -0400
In-reply-to: <1279790980-29583-1-git-send-email-m.szyprowski@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kyungmin.park@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org

Marek Szyprowski wrote:
> 
> On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> line. For some embedded designs it is not even needed, because ususally
> the device (like SDIO flash memory or wifi controller) is permanently
> wired to the controller. There are also systems which have a card detect
> line connected to some of the external interrupt lines or the presence
> of the card depends on some other actions (like enabling a power
> regulator).
> 
> This patch adds all required changes to platform support code, so
> another patch, which extends the driver with support for the new card
> detection methods can be applied.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> This a resend of the previous patch.
> 
> I hope these changes to platform specific code gets merged soon, so the
> changes to the driver can be merged as well.
> 
> The patch has been prepared against linux-next kernel tree from 20100722.
> 
> Changes since V3:
> - renamed patch to avoid confusion with the patch for the s3c-sdhci driver
>   itself - added "(platform part)" in subject
> 
> Changes since V2:
> - added support for HSMMC3 device
> 
> Changes since V1:
> - added support for gpio external interrupt card based detect method
>   directly to sdhci-s3c driver
> - removed s3c64xx compilation fix patch from the series
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> ---
> 
>  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
>  arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 ++++++++++++++-----
>  arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 +++++++++++++++-----
>  arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
>  arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
>  arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
>  arch/arm/plat-samsung/dev-hsmmc3.c         |    5 ++++
>  arch/arm/plat-samsung/include/plat/sdhci.h |   29
> ++++++++++++++++++++++++++++
>  8 files changed, 90 insertions(+), 16 deletions(-)
> 

Marek,

Following is build error with this patch.

/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c: In function 's5pc100_setup_sdhci0_cfg_gpio':
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:51: error: dereferencing pointer to incomplete type
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:51: error: 'S3C_SDHCI_CD_INTERNAL' undeclared (first use in
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:51: error: (Each undeclared identifier is reported only once
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:51: error: for each function it appears in.)
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c: In function 's5pc100_setup_sdhci1_cfg_gpio':
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:71: error: dereferencing pointer to incomplete type
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:71: error: 'S3C_SDHCI_CD_INTERNAL' undeclared (first use in
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c: In function 's5pc100_setup_sdhci2_cfg_gpio':
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:91: error: dereferencing pointer to incomplete type
/home/kgene/linux/linux-2.6-mainline-dev/arch/arm/mach-s5pc100/setup-sdhci-g
pio.c:91: error: 'S3C_SDHCI_CD_INTERNAL' undeclared (first use in
make[2]: *** [arch/arm/mach-s5pc100/setup-sdhci-gpio.o] Error 1

and s3c64xx also.

...we need inclusion <plat/sdhci.h> into the ..s3c64xx/setup-sdhci-gpio.c
and ..s5pc100/setup-sdhci-gpio.c.

Will apply with build fix.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

