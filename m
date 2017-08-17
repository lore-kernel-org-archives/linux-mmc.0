From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 2/7] mmc: sdhci: Add quirk to indicate controller
 supports ADMA2
Date: Thu, 17 Aug 2017 11:00:30 +0530
Message-ID: <621be6ac-7670-1969-e133-3368f815c007@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-3-kishon@ti.com>
 <dab59f32-5774-8b97-0391-222be30dea16@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <dab59f32-5774-8b97-0391-222be30dea16-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Tuesday 15 August 2017 01:03 PM, Adrian Hunter wrote:
> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>> TI's implementation of sdhci controller used in DRA7 SoC's doesn't
>> have SDHCI_CAN_DO_ADMA2 set in CAPA register though it supports
>> ADMA2. Add quirk to support using ADMA2 even if the controller reports
>> incorrect capability in CAPA.
> 
> A quirk is not needed for this.  Just call sdhci_read_caps() and change
> host->caps before calling sdhci_add_host().

Okay, got it.

Thanks
Kishon
> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 3 ++-
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ece3751d2a25..fff0baadbc3e 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3264,7 +3264,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>>  	}
>>  
>>  	if ((host->version >= SDHCI_SPEC_200) &&
>> -		(host->caps & SDHCI_CAN_DO_ADMA2))
>> +		((host->caps & SDHCI_CAN_DO_ADMA2) ||
>> +		(host->quirks2 & SDHCI_QUIRK2_FORCE_ADMA)))
>>  		host->flags |= SDHCI_USE_ADMA;
>>  
>>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6905131f603d..d778034e324d 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -437,6 +437,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
>>  /* Controller does not have CRC stripped in Command Response */
>>  #define SDHCI_QUIRK2_NO_CRC_STRIPPING			(1<<16)
>> +/* Controller has bad caps bits, but really supports DMA */
>> +#define SDHCI_QUIRK2_FORCE_ADMA				(1<<17)
>>  
>>  	int irq;		/* Device IRQ */
>>  	void __iomem *ioaddr;	/* Mapped address */
>>
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
