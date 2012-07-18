From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Wed, 18 Jul 2012 15:14:28 +0530
Message-ID: <CAMQu2gy+uXJFfmOwLX=YH41pr-N+T28-1wLo5rXEaj9MGffHPw@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
 <20120718065951.GH6522@atomide.com> <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com>
 <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com>
 <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com>
 <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com>
 <CAMQu2gxLwGACAT-r6=L9DKB=3fTNaEJ4woZOb4zttJ8qTTJmFA@mail.gmail.com>
 <CAAwP0s2apfBHLKHtzvwqb2KPCMNhEXMe5R9792bO7FhfY5Y+uQ@mail.gmail.com> <CANfBPZ_N4ZK5PgFQLHWMwsG60tb-FPTjeieTJ92rBUNgONAxAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:60858 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010Ab2GRJou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 05:44:50 -0400
Received: by yenq10 with SMTP id q10so2439491yen.9
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 02:44:49 -0700 (PDT)
In-Reply-To: <CANfBPZ_N4ZK5PgFQLHWMwsG60tb-FPTjeieTJ92rBUNgONAxAw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Jul 18, 2012 at 3:08 PM, S, Venkatraman <svenkatr@ti.com> wrote:
> On Wed, Jul 18, 2012 at 2:46 PM, Javier Martinez Canillas
> <martinez.javier@gmail.com> wrote:

[...]

>>>>
>>>> And what about enabling it at the SoC config level but making the
>>>> drivers dependant on CONFIG_DMADEVICES and CONFIG_DMA_OMAP? If you
>>>> agree I can send something like this in two different patches (one for
>>>> the omap2plus_defconfig and another to make the drivers dependant on
>>>> the config option):
>>>>
>>>> diff --git a/arch/arm/configs/omap2plus_defconfig
>>>> b/arch/arm/configs/omap2plus_defconfig
>>>> index b152de7..e58edc3 100644
>>>> --- a/arch/arm/configs/omap2plus_defconfig
>>>> +++ b/arch/arm/configs/omap2plus_defconfig
>>>> @@ -193,6 +193,8 @@ CONFIG_MMC_OMAP_HS=y
>>>>  CONFIG_RTC_CLASS=y
>>>>  CONFIG_RTC_DRV_TWL92330=y
>>>>  CONFIG_RTC_DRV_TWL4030=y
>>>> +CONFIG_DMADEVICES=y
>>>> +CONFIG_DMA_OMAP=y
>>>>  CONFIG_EXT2_FS=y
>>>>  CONFIG_EXT3_FS=y
>>>>  # CONFIG_EXT3_FS_XATTR is not set
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index aa131b3..314c7bd 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA
>>>>
>>>>  config MMC_OMAP
>>>>         tristate "TI OMAP Multimedia Card Interface support"
>>>> -       depends on ARCH_OMAP
>>>> +       depends on ARCH_OMAP && DMADEVICES && DMA_OMAP
>>>
>>> May be. But since for sure a driver knows that it needs DMA
>>> support to be enabled, I will just select it rather than depends
>>> on.
>>>
>>> Regards
>>> santosh
>>
>> Yes I agree with you, I was just exploring other options :-)
>>
> For MMC atleast, there's already a patch in mmc-next to do a "Depends On"
> http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=7c68046c99f0b96d965c31cf42814b9a0f15ad46

Change log assumes says .

"The patch simply make them depend on DMA_OMAP since DMA_OMAP
will select DMA_ENGINE automatically"

This won't be true if the DMA selection are not done
at ARCH_OMAP level as discussed in this thread.

Having said that, I think Russell and Tony need to
take call on how this needs to be handled.

Regards
Santosh
