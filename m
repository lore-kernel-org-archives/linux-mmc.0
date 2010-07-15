From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] Samsung: sdhci-s3c: add support for new card
 detection methods
Date: Thu, 15 Jul 2010 13:39:54 -0700
Message-ID: <20100715133954.7fcb797a.akpm@linux-foundation.org>
References: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56397 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934691Ab0GOUkb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jul 2010 16:40:31 -0400
In-Reply-To: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org

On Thu, 15 Jul 2010 10:15:21 +0200
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> line. For some embedded designs it is not even needed, because ususally
> the device (like SDIO flash memory or wifi controller) is permanently
> wired to the controller. There are also systems which have a card detect
> line connected to some of the external interrupt lines or the presence
> of the card depends on some other actions (like enabling a power
> regulator).
> 
> This patch adds support for all these cases. The following card
> detection methods are possible:
> 
> 1. internal sdhci host card detect line
> 2. external event
> 3. external gpio interrupt
> 4. no card detect line, controller will poll for the card
> 5. no card detect line, card is permanently wired to the controller
> (once detected host won't poll it any more)
> 
> By default, all existing code would use method #1, what is compatible
> with the previous version of the driver.
> 
> In case of external event, two callbacks must be provided in platdata:
> ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
> function that notifies the s3c-sdhci host contoller as their argument.
> That callback function should be called from the even dispatcher to let
> host notice the card insertion/removal.
> 
> In case of external gpio interrupt, a gpio pin number must be provided
> in platdata (ext_cd_gpio parameter), as well as the information about
> the polarity of that gpio pin (ext_cd_gpio_invert). By default
> (ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
> but this can be changed to 'card has been removed' when
> ext_cd_gpio_invert == 1.
> 
> This patch adds all required changes to platform support code.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> 
> This a resend of the previous patch. Relevant patches for sdhci-s3c
> driver has been posted in a separate patch series for easier merging,
> please refer to the "[PATCH] SDHCI-S3C fixes and enhancements (driver
> specific code)" thread. They have been already taken by Andrew Morton
> into his patch tracking tree.
> 
> I hope these changes to platform specific code gets merged soon, so the
> changes to the driver can be merged as well.
> 
> The patch has been prepared for the following git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
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
>  arch/arm/plat-samsung/include/plat/sdhci.h |   29 ++++++++++++++++++++++++++++
>  8 files changed, 90 insertions(+), 16 deletions(-)

This is quite confusing.  You've already sent a patch called
"sdhci-s3c: add support for new card detection methods".  It had the
same changelog as this patch and the same title, but the two patches
are utterly different!

I suggest that you resend this patch under an appropriate title and
with a more specific changelog, please.

