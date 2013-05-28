From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: fix error return code in sdhci_acpi_add_own_cd()
Date: Tue, 28 May 2013 09:27:56 +0300
Message-ID: <51A44E6C.9070708@intel.com>
References: <CAPgLHd_FWg3egTZxBena+BTgWdZCzqr9AjV1_NpWBGYD3aPz0w@mail.gmail.com> <000801ce5b65$28d9f400$7a8ddc00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:13896 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932971Ab3E1GV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 May 2013 02:21:57 -0400
In-Reply-To: <000801ce5b65$28d9f400$7a8ddc00$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Wei Yongjun' <weiyj.lk@gmail.com>, cjb@laptop.org, rafael.j.wysocki@intel.com, sonic.zhang@analog.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

On 28/05/13 08:35, Jingoo Han wrote:
> On Tuesday, May 28, 2013 2:26 PM, Wei Yongjun wrote:
>>
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> Fix to return a negative error code in the gpio_to_irq() error
>> handling case instead of 0, as done elsewhere in this function.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> It looks good.
> 
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Yes, thank you!

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Best regards,
> Jingoo Han
> 
>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index a51e603..08a85ec 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -189,8 +189,10 @@ static int sdhci_acpi_add_own_cd(struct device *dev, int gpio,
>>  		goto out;
>>
>>  	irq = gpio_to_irq(gpio);
>> -	if (irq < 0)
>> +	if (irq < 0) {
>> +		err = irq;
>>  		goto out_free;
>> +	}
>>
>>  	flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>>  	err = devm_request_irq(dev, irq, sdhci_acpi_sd_cd, flags, "sd_cd", mmc);
> 
> 
> 

