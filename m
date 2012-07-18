From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Wed, 18 Jul 2012 10:49:52 +0200
Message-ID: <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com> <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
 <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com>
 <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:37742 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab2GRIuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 04:50:14 -0400
In-Reply-To: <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Jul 18, 2012 at 10:36 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Wed, Jul 18, 2012 at 1:14 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>> On Wed, Jul 18, 2012 at 12:40 PM, Tony Lindgren <tony@atomide.com> wrote:
>>> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 00:09]:
>>>> On Wed, Jul 18, 2012 at 12:29 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>> > * Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
>>>> >> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
>>>> >> <santosh.shilimkar@ti.com> wrote:
>>>> >> > Hi,
>>>> >> >
>>>> >> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
>>>> >> > <javier@dowhile0.org> wrote:
>>>> >> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
>>>> >> >> engine API instead of the previous private DMA API implementation.
>>>> >> >>
>>>> >> >> So, if the kernel is built with support for any of these hosts but it
>>>> >> >> doesn't support DMA devices nor OMAP DMA support, it fails when trying
>>>> >> >> to obtain a DMA channel which leads to the following error on an OMAP3
>>>> >> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
>>>> >> >>
>>>> >> >> [ 2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>>>> >> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>>>> >> >>
>>>> >> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
>>>> >> >>
>>>> >> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>>>> >> >> ---
>>>> >> > Considering, we are updating drivers to select the DMA engine, can you
>>>> >> > also include
>>>> >> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
>>>> >> >
>>>> >> > Regards
>>>> >> > Santosh
>>>> >>
>>>> >> Hi Santosh,
>>>> >>
>>>> >> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.
>>>> >
>>>> > I don't think we should do this, the drivers should work with and without
>>>> > dma. This just needs to be added to the omap2plus_defconfig.
>>>> >
>>>> Well this was not decided based on any DMA CONFIG option before for
>>>> the subject drivers. It is already by default enabled if the DMA is supported
>>>> by the driver IP. There is a possibility to disable it from driver platform/dt
>>>> data so that still remains.
>>>
>>> I think it should rather be that if the driver is broken and does not work
>>> without DMA, it should have depends on CONFIG_DMA_OMAP.
>>>
>> I can confirm that omap MMC can't work without DMA; polled mode is not
>> supported / implemented.
>
> Same case for SPI driver as well. It uses DMA for everything except the cases
> where DMA doesn't make sense like 1 byte/2 byte etc. And its not configurable,
>
> At least considering this, it is better we do this per driver than enabling
> it at SOC config.
>
> Regards
> Santosh
> --

Hi Santosh,

And what about enabling it at the SoC config level but making the
drivers dependant on CONFIG_DMADEVICES and CONFIG_DMA_OMAP? If you
agree I can send something like this in two different patches (one for
the omap2plus_defconfig and another to make the drivers dependant on
the config option):

diff --git a/arch/arm/configs/omap2plus_defconfig
b/arch/arm/configs/omap2plus_defconfig
index b152de7..e58edc3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_OMAP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index aa131b3..314c7bd 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA

 config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
-	depends on ARCH_OMAP
+	depends on ARCH_OMAP && DMADEVICES && DMA_OMAP
 	select TPS65010 if MACH_OMAP_H2
 	help
 	  This selects the TI OMAP Multimedia card Interface.
@@ -242,7 +242,8 @@ config MMC_OMAP

 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on (SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4) && \
+		    DMADEVICES && DMA_OMAP
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..1c23242 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -237,7 +237,7 @@ config SPI_OMAP_UWIRE

 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS && DMADEVICES && DMA_OMAP
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.

Best regards,
Javier
