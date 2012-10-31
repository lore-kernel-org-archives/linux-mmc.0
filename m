From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [RESEND PATCH V2] mmc: omap_hsmmc: Enable HSPE bit for high speed
 cards
Date: Wed, 31 Oct 2012 16:18:02 +0530
Message-ID: <509101E2.5050606@ti.com>
References: <1351672116-17309-1-git-send-email-gururaja.hebbar@ti.com> <20121031100422.GA10094@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121031100422.GA10094@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: svenkatr@ti.com, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com
List-Id: linux-mmc@vger.kernel.org

On 10/31/2012 3:34 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Oct 31, 2012 at 01:58:35PM +0530, Hebbar, Gururaja wrote:
>> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
>> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
>> on the HSMMC IP timing closure done for the high speed cards.
>>
>>  From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
>>
>> The MMC/SD/SDIO output signals can be driven on either falling edge or
>> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
>> to reach better timing performance, and thus to increase data transfer
>> frequency.
>>
>> There are few pre-requisites for enabling the HSPE bit
>> - Controller should support High-Speed-Enable Bit and
>> - Controller should not be using DDR Mode and
>> - Controller should advertise that it supports High Speed in
>>    capabilities register and
>> - MMC/SD clock coming out of controller > 25MHz
>>
>> Note:
>> The implementation reuses the output of calc_divisor() so as to reduce
>> code addition.
>>
>> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
>> ---
>> Rebased on mmc-next (v3.7.0-rc1)
>> Only Build tested since EDMA support for AM335x is not yet added
>>
>> Changes in V2
>> 	- Added note in commit message about code re-use
>> 	- replaced ((a & BIT(n) == BIT(n))) with (a & BIT(n)) since
>> 	  effectively both are same.
>>
>> :100644 100644 be76a23... ed271fc... M	Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> :100644 100644 8b4e4f2... 346af5b... M	arch/arm/plat-omap/include/plat/mmc.h
>> :100644 100644 54bfd0c... 5ea4c9d... M	drivers/mmc/host/omap_hsmmc.c
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>>   arch/arm/plat-omap/include/plat/mmc.h              |    1 +
>>   drivers/mmc/host/omap_hsmmc.c                      |   30 +++++++++++++++++++-
>>   3 files changed, 31 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> index be76a23..ed271fc 100644
>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>> @@ -19,6 +19,7 @@ ti,dual-volt: boolean, supports dual voltage cards
>>   "supply-name" examples are "vmmc", "vmmc_aux" etc
>>   ti,non-removable: non-removable slot (like eMMC)
>>   ti,needs-special-reset: Requires a special softreset sequence
>> +ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
>>   
>>   Example:
>>   	mmc1: mmc@0x4809c000 {
>> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
>> index 8b4e4f2..346af5b 100644
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -126,6 +126,7 @@ struct omap_mmc_platform_data {
>>   		/* we can put the features above into this variable */
>>   #define HSMMC_HAS_PBIAS		(1 << 0)
>>   #define HSMMC_HAS_UPDATED_RESET	(1 << 1)
>> +#define HSMMC_HAS_HSPE_SUPPORT	(1 << 2)
>>   		unsigned features;
>>   
>>   		int switch_pin;			/* gpio (card detect) */
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 54bfd0c..5ea4c9d 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -62,6 +62,7 @@
>>   
>>   #define VS18			(1 << 26)
>>   #define VS30			(1 << 25)
>> +#define HSS			(1 << 21)
>>   #define SDVS18			(0x5 << 9)
>>   #define SDVS30			(0x6 << 9)
>>   #define SDVS33			(0x7 << 9)
>> @@ -89,6 +90,7 @@
>>   #define MSBS			(1 << 5)
>>   #define BCE			(1 << 1)
>>   #define FOUR_BIT		(1 << 1)
>> +#define HSPE			(1 << 2)
>>   #define DDR			(1 << 19)
>>   #define DW8			(1 << 5)
>>   #define CC			0x1
>> @@ -489,6 +491,7 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>>   	struct mmc_ios *ios = &host->mmc->ios;
>>   	unsigned long regval;
>>   	unsigned long timeout;
>> +	unsigned long clkdiv;
>>   
>>   	dev_vdbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
>>   
>> @@ -496,7 +499,8 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>>   
>>   	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
>>   	regval = regval & ~(CLKD_MASK | DTO_MASK);
>> -	regval = regval | (calc_divisor(host, ios) << 6) | (DTO << 16);
>> +	clkdiv = calc_divisor(host, ios);
>> +	regval = regval | (clkdiv << 6) | (DTO << 16);
>>   	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
>>   	OMAP_HSMMC_WRITE(host->base, SYSCTL,
>>   		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
>> @@ -507,6 +511,27 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
>>   		&& time_before(jiffies, timeout))
>>   		cpu_relax();
>>   
>> +	/*
>> +	 * Enable High-Speed Support
>> +	 * Pre-Requisites
>> +	 *	- Controller should support High-Speed-Enable Bit
>> +	 *	- Controller should not be using DDR Mode
>> +	 *	- Controller should advertise that it supports High Speed
>> +	 *	  in capabilities register
>> +	 *	- MMC/SD clock coming out of controller > 25MHz
>> +	 */
>> +	if ((mmc_slot(host).features & HSMMC_HAS_HSPE_SUPPORT) &&
>> +	    (ios->timing != MMC_TIMING_UHS_DDR50) &&
>> +	    (OMAP_HSMMC_READ(host->base, CAPA) & HSS)) {
>> +		regval = OMAP_HSMMC_READ(host->base, HCTL);
>> +		if (clkdiv && (clk_get_rate(host->fclk)/clkdiv) > 25000000)
> that clk rate could be a symbolic define.

Ok will update as below and re-use

#define OMAP_HSMMC_CLKOUT   25000000
>
>> +			regval |= HSPE;
>> +		else
>> +			regval &= ~HSPE;
>> +
>> +		OMAP_HSMMC_WRITE(host->base, HCTL, regval);
>> +	}
>> +
>>   	omap_hsmmc_start_clock(host);
>>   }
>>   
>> @@ -1700,6 +1725,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>   	if (of_find_property(np, "ti,needs-special-reset", NULL))
>>   		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
>>   
>> +	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
>> +		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
> this could be of_property_read_bool().
Ok will change.

>

