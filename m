From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/4] MMC: omap_hsmmc: add DT property for max bus frequency
Date: Fri, 12 Oct 2012 17:26:43 +0200
Message-ID: <507836B3.1020809@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-5-git-send-email-zonque@gmail.com> <50783671.1090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <50783671.1090308@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 12.10.2012 17:25, Rob Herring wrote:
> On 10/12/2012 05:58 AM, Daniel Mack wrote:
>> Maximum bus frequency can be limited by external circuitry like level
>> shifters etc. Allow passing this value from DT.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Venkatraman S <svenkatr@ti.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: linux-omap@vger.kernel.org
>> ---
>>  drivers/mmc/host/omap_hsmmc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 86f0759..4650ef7 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1676,7 +1676,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>  {
>>  	struct omap_mmc_platform_data *pdata;
>>  	struct device_node *np = dev->of_node;
>> -	u32 bus_width;
>> +	u32 bus_width, max_freq;
>>  
>>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>  	if (!pdata)
>> @@ -1703,6 +1703,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
>>  	if (of_find_property(np, "ti,needs-special-reset", NULL))
>>  		pdata->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
>>  
>> +	if (!of_property_read_u32(np, "max-frequency", &max_freq))
>> +		pdata->max_freq = max_freq;
>> +
> 
> Is this property documented?

Yes, in the generic part. Forgot to mention that.

  Documentation/devicetree/bindings/mmc/mmc.txt


