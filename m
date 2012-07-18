From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Wed, 18 Jul 2012 10:25:48 +0200
Message-ID: <CAAwP0s1UB_Q33KhXp_gvKfTMHRiBaH60HmXsMKxVkAxT1byctg@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
 <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
 <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com> <20120718065951.GH6522@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45326 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab2GRI0J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 04:26:09 -0400
In-Reply-To: <20120718065951.GH6522@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin.Hilman.khilman@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Wed, Jul 18, 2012 at 8:59 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier@dowhile0.org> [120716 23:56]:
>> On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
>> <santosh.shilimkar@ti.com> wrote:
>> > Hi,
>> >
>> > On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
>> > <javier@dowhile0.org> wrote:
>> >> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
>> >> engine API instead of the previous private DMA API implementation.
>> >>
>> >> So, if the kernel is built with support for any of these hosts but it
>> >> doesn't support DMA devices nor OMAP DMA support, it fails when trying
>> >> to obtain a DMA channel which leads to the following error on an OMAP3
>> >> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
>> >>
>> >> [ 2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>> >> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>> >>
>> >> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
>> >>
>> >> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> >> ---
>> > Considering, we are updating drivers to select the DMA engine, can you
>> > also include
>> > "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
>> >
>> > Regards
>> > Santosh
>>
>> Hi Santosh,
>>
>> Ok, I'll send a v2 now which includes spi-omap2-mcspi then.
>
> I don't think we should do this, the drivers should work with and without
> dma. This just needs to be added to the omap2plus_defconfig.
>
> Regards,
>
> Tony
> --

Hi Tony,

That was my first approach in fact, I sent this patch:
https://patchwork.kernel.org/patch/1198401/

But then was told by Kevin Hilman that the right solution was to do
the select on the drives to fix not only omap2plus_defconfig but any
config.
So I sent this patch and Santosh agrees with Kevin.

I don't really know the hardware nor the driver well enough to have a
strong position on this.

Best regards,
Javier
