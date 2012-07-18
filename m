From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Wed, 18 Jul 2012 15:08:31 +0530
Message-ID: <CANfBPZ_N4ZK5PgFQLHWMwsG60tb-FPTjeieTJ92rBUNgONAxAw@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com> <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
 <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com>
 <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
 <CAMQu2gxLwGACAT-r6=L9DKB=3fTNaEJ4woZOb4zttJ8qTTJmFA@mail.gmail.com> <CAAwP0s2apfBHLKHtzvwqb2KPCMNhEXMe5R9792bO7FhfY5Y+uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:43873 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753165Ab2GRJiy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 05:38:54 -0400
Received: by bkty15 with SMTP id y15so2039528bkt.16
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 02:38:51 -0700 (PDT)
In-Reply-To: <CAAwP0s2apfBHLKHtzvwqb2KPCMNhEXMe5R9792bO7FhfY5Y+uQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Jul 18, 2012 at 2:46 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> On Wed, Jul 18, 2012 at 11:11 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Wed, Jul 18, 2012 at 2:19 PM, Javier Martinez Canillas
>> <martinez.javier@gmail.com> wrote:
>>> On Wed, Jul 18, 2012 at 10:36 AM, Shilimkar, Santosh
>>> <santosh.shilimkar@ti.com> wrote:
>>>> On Wed, Jul 18, 2012 at 1:14 PM, S, Venkatraman <svenkatr@ti.com> wrote:
>>>>> On Wed, Jul 18, 2012 at 12:40 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120718 00:09]:
>>>>>>> On Wed, Jul 18, 2012 at 12:29 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>>>> > * Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
>>>>>>> >> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
>>>>>>> >> <santosh.shilimkar@ti.com> wrote:
>>>>>>> >> > Hi,
>>>>>>> >> >
>>>>>>> >> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
>>>>>>> >> > <javier@dowhile0.org> wrote:
>>>>>>> >> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
>>>>>>> >> >> engine API instead of the previous private DMA API implementation.
>>>>>>> >> >>
>>>>>>> >> >> So, if the kernel is built with support for any of these hosts but it
>>>>>>> >> >> doesn't support DMA devices nor OMAP DMA support, it fails when trying
>>>>>>> >> >> to obtain a DMA channel which leads to the following error on an OMAP3
>>>>>>> >> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
>>>>>>> >> >>
>>>>>>> >> >> [ 2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>>>>>>> >> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>>>>>>> >> >>
>>>>>>> >> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
>>>>>>> >> >>
>>>>>>> >> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>>>>>>> >> >> ---
>>>>>>> >> > Considering, we are updating drivers to select the DMA engine, can you
>>>>>>> >> > also include
>>>>>>> >> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
>>>>>>> >> >
>>>>>>> >> > Regards
>>>>>>> >> > Santosh
>>>>>>> >>
>>>>>>> >> Hi Santosh,
>>>>>>> >>
>>>>>>> >> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.
>>>>>>> >
>>>>>>> > I don't think we should do this, the drivers should work with and without
>>>>>>> > dma. This just needs to be added to the omap2plus_defconfig.
>>>>>>> >
>>>>>>> Well this was not decided based on any DMA CONFIG option before for
>>>>>>> the subject drivers. It is already by default enabled if the DMA is supported
>>>>>>> by the driver IP. There is a possibility to disable it from driver platform/dt
>>>>>>> data so that still remains.
>>>>>>
>>>>>> I think it should rather be that if the driver is broken and does not work
>>>>>> without DMA, it should have depends on CONFIG_DMA_OMAP.
>>>>>>
>>>>> I can confirm that omap MMC can't work without DMA; polled mode is not
>>>>> supported / implemented.
>>>>
>>>> Same case for SPI driver as well. It uses DMA for everything except the cases
>>>> where DMA doesn't make sense like 1 byte/2 byte etc. And its not configurable,
>>>>
>>>> At least considering this, it is better we do this per driver than enabling
>>>> it at SOC config.
>>>>
>>>> Regards
>>>> Santosh
>>>> --
>>>
>>> Hi Santosh,
>>>
>>> And what about enabling it at the SoC config level but making the
>>> drivers dependant on CONFIG_DMADEVICES and CONFIG_DMA_OMAP? If you
>>> agree I can send something like this in two different patches (one for
>>> the omap2plus_defconfig and another to make the drivers dependant on
>>> the config option):
>>>
>>> diff --git a/arch/arm/configs/omap2plus_defconfig
>>> b/arch/arm/configs/omap2plus_defconfig
>>> index b152de7..e58edc3 100644
>>> --- a/arch/arm/configs/omap2plus_defconfig
>>> +++ b/arch/arm/configs/omap2plus_defconfig
>>> @@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
>>>  CONFIG_RTC_CLASS=y
>>>  CONFIG_RTC_DRV_TWL92330=y
>>>  CONFIG_RTC_DRV_TWL4030=y
>>> +CONFIG_DMADEVICES=y
>>> +CONFIG_DMA_OMAP=y
>>>  CONFIG_EXT2_FS=y
>>>  CONFIG_EXT3_FS=y
>>>  # CONFIG_EXT3_FS_XATTR is not set
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index aa131b3..314c7bd 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA
>>>
>>>  config MMC_OMAP
>>>         tristate "TI OMAP Multimedia Card Interface support"
>>> -       depends on ARCH_OMAP
>>> +       depends on ARCH_OMAP && DMADEVICES && DMA_OMAP
>>
>> May be. But since for sure a driver knows that it needs DMA
>> support to be enabled, I will just select it rather than depends
>> on.
>>
>> Regards
>> santosh
>
> Yes I agree with you, I was just exploring other options :-)
>
For MMC atleast, there's already a patch in mmc-next to do a "Depends On"
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=7c68046c99f0b96d965c31cf42814b9a0f15ad46
