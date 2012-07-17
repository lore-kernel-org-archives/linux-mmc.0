From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 1/1] mmc: host: enable OMAP DMA engine support for omap
 hosts by default
Date: Tue, 17 Jul 2012 18:38:35 +0200
Message-ID: <CABxcv=k+9XBRHXVLpr30vtLyj6fOYyqyoWDSdtp3jRTk0oM5WQ@mail.gmail.com>
References: <1342508636-2782-1-git-send-email-javier@dowhile0.org>
	<CAMQu2gyf=-0QG4UCDEGfDmsCZ+xJs_B=+SSH3VxqO4hu=mSPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51953 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2GQQif (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 12:38:35 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so580041yen.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 09:38:35 -0700 (PDT)
In-Reply-To: <CAMQu2gyf=-0QG4UCDEGfDmsCZ+xJs_B=+SSH3VxqO4hu=mSPdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 17, 2012 at 9:09 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Tue, Jul 17, 2012 at 12:33 PM, Javier Martinez Canillas
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
>> While being there, also update drivers/spi/spi-omap2-mcspi which has been
>> ported to DMA engine API too.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
>> ---
>>
> Looks like this patch should go to Russell's tree where rest of the OMAP
> DMA engine patches are queued.
>
> For the patch itself,
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Santhosh,

Thanks a lot for your feedback.

Russell can you take this patch please or do you want me to resend?

Best regards,
Javier
