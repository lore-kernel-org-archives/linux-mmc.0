From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 4/7] mmc: sdhci: Add quirk to indicate broken
 POWER_CONTROL
Date: Thu, 17 Aug 2017 11:02:29 +0530
Message-ID: <c7712629-f462-b315-fd79-67882549ef83@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-5-kishon@ti.com>
 <45762ded-3c42-fefc-e6bb-2542d75c9c67@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <45762ded-3c42-fefc-e6bb-2542d75c9c67@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On Tuesday 15 August 2017 01:11 PM, Adrian Hunter wrote:
> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>> TI's implementation of sdhci controller used in DRA7 SoC's uses
>> POWER_CONTROL register for configuring IO voltage and not
>> for core voltage (vdd) which is it's intended use. Add a quirk
>> to indicate broken POWER_CONTROL register.
> 
> A quirk isn't needed for this.  Use the ->set_power() callback instead.

sure!

Thanks
Kishon
> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 6 ++++++
>>  drivers/mmc/host/sdhci.h | 2 ++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d5050ec42481..a7465a56e6b5 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1419,6 +1419,9 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>>  
>>  	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>>  
>> +	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_POWER_CONTROL)
>> +		return;
>> +
>>  	if (mode != MMC_POWER_OFF)
>>  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>>  	else
>> @@ -1430,6 +1433,9 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>>  {
>>  	u8 pwr = 0;
>>  
>> +	if (host->quirks2 & SDHCI_QUIRK2_BROKEN_POWER_CONTROL)
>> +		return;
>> +
>>  	if (mode != MMC_POWER_OFF) {
>>  		switch (1 << vdd) {
>>  		case MMC_VDD_165_195:
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 39c7a2723906..ba94cca7c892 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -439,6 +439,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_NO_CRC_STRIPPING			(1<<16)
>>  /* Controller has bad caps bits, but really supports DMA */
>>  #define SDHCI_QUIRK2_FORCE_ADMA				(1<<17)
>> +/* Controller uses POWER_CONTROL for managing IO voltage and not core voltage */
>> +#define SDHCI_QUIRK2_BROKEN_POWER_CONTROL		(1<<18)
>>  
>>  	int irq;		/* Device IRQ */
>>  	void __iomem *ioaddr;	/* Mapped address */
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
