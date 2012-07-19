From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] MMC: OMAP: make MMC_OMAP* depend on DMA_OMAP
Date: Thu, 19 Jul 2012 16:59:45 +0530
Message-ID: <CANfBPZ8K3=EG296_ZBd_ZaMaKPCXx4YWBOT6LjCy9T6ZsVhRHw@mail.gmail.com>
References: <1341450721-20993-1-git-send-email-ming.lei@canonical.com> <87pq7s9w8f.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:60207 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754014Ab2GSLaI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 07:30:08 -0400
Received: by bkcjk13 with SMTP id jk13so1895458bkc.10
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jul 2012 04:30:05 -0700 (PDT)
In-Reply-To: <87pq7s9w8f.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ming Lei <ming.lei@canonical.com>, Kevin Hilman <khilman@ti.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On Thu, Jul 19, 2012 at 10:35 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Venkat -- please could you ACK/review this patch?
>

Chris,
 I think we have to hold on to this patch just for today. There's
another thread about this same issue on linux-omap

> On Wed, Jul 04 2012, Ming Lei wrote:
>> Recent commits on omap mmc/hsmmc in -next tree switch to
>> DMA_ENGINE entirely, so make MMC_OMAP* depend on DMA_OMAP
>> and DMA_ENGINE, otherwise OMAP MMC/HSMMC won't work without
>> enabling DMA_ENGINE and DMA_OMAP.
>>
>> The patch simply make them depend on DMA_OMAP since DMA_OMAP
>> will select DMA_ENGINE automatically.
>>
>> Signed-off-by: Ming Lei <ming.lei@canonical.com>
>> ---
>>  drivers/mmc/host/Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index aa131b3..ef72c50 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -231,7 +231,7 @@ config MMC_SDHCI_S3C_DMA
>>
>>  config MMC_OMAP
>>       tristate "TI OMAP Multimedia Card Interface support"
>> -     depends on ARCH_OMAP
>> +     depends on ARCH_OMAP && DMA_OMAP
>>       select TPS65010 if MACH_OMAP_H2
>>       help> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


>>         This selects the TI OMAP Multimedia card Interface.
>> @@ -242,7 +242,7 @@ config MMC_OMAP
>>
>>  config MMC_OMAP_HS
>>       tristate "TI OMAP High Speed Multimedia Card Interface support"
>> -     depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
>> +     depends on (SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4) && DMA_OMAP
>>       help
>>         This selects the TI OMAP High Speed Multimedia card Interface.
>>         If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
>
