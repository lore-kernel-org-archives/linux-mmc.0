From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Tue, 17 Jul 2012 08:51:19 +0200
Message-ID: <CABxcv=nsmeVLspzXERYXebmPaNO6rKCsVnak7dMtvGjiYH4vOw@mail.gmail.com>
References: <1342485005-5178-1-git-send-email-javier@dowhile0.org>
	<CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55989 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2GQGvU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 02:51:20 -0400
Received: by obbuo13 with SMTP id uo13so125109obb.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jul 2012 23:51:19 -0700 (PDT)
In-Reply-To: <CAMQu2gxaF8K78puE84+=8VJLbsdtdD97ww81XJxG6sCtYTYXww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin.Hilman.khilman@ti.com, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, Jul 17, 2012 at 8:45 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> Hi,
>
> On Tue, Jul 17, 2012 at 6:00 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:
>> The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
>> engine API instead of the previous private DMA API implementation.
>>
>> So, if the kernel is built with support for any of these hosts but it
>> doesn't support DMA devices nor OMAP DMA support, it fails when trying
>> to obtain a DMA channel which leads to the following error on an OMAP3
>> IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):
>>
>> [    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>> [    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>>
>> selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
> Considering, we are updating drivers to select the DMA engine, can you
> also include
> "drivers/spi/spi-omap2-mcspi.c" which is also updated for DMA engine.
>
> Regards
> Santosh

Hi Santosh,

Ok, I'll send a v2 now which includes spi-omap2-mcspi then.

Thanks a lot and best regards,
Javier
