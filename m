From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 01/17] mmc: host: omap_hsmmc: use devm_regulator_get_optional()
 for vmmc
Date: Fri, 31 Jul 2015 20:59:58 +0530
Message-ID: <55BB9476.7070105@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com> <1438168187-1614-2-git-send-email-kishon@ti.com> <55B8C265.1050801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbbGaPad (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Jul 2015 11:30:33 -0400
In-Reply-To: <55B8C265.1050801@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, Roger Quadros <rogerq@ti.com>

Hi Grygorii,

On Wednesday 29 July 2015 05:39 PM, Grygorii Strashko wrote:
> On 07/29/2015 02:09 PM, Kishon Vijay Abraham I wrote:
>> Since vmmc can be optional for some platforms, use
>> devm_regulator_get_optional() for vmmc. Now return error only
>> in the case of -EPROBE_DEFER and for all other cases set
>> host->vcc to NULL.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/mmc/host/omap_hsmmc.c |    8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 4d12032..b673e59 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -344,11 +344,13 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>   	struct regulator *reg;
>>   	int ocr_value = 0;
>>   
>> -	reg = devm_regulator_get(host->dev, "vmmc");
>> +	reg = devm_regulator_get_optional(host->dev, "vmmc");
>>   	if (IS_ERR(reg)) {
>> -		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
>> +		if (PTR_ERR(reg) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
>> +		host->vcc = NULL;
>> +		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
>>   			PTR_ERR(reg));
>> -		return PTR_ERR(reg);
> 
> I think, It could be unsafe to just drop this return.
> regulator_get_optional may return:
> 1 valid pointer on regulator : success;
> 2 ERR_PTR(-ENODEV)           : regulator is not assigned, can proceed.
> 3 ERR_PTR(-EPROBE_DEFER)     : regulator is assigned, but not ready yet, retry.
> 4 ERR_PTR(<other error codes>: regulator is assigned, but can't be retrieved, failure, can't proceed
> 
> So, It's allowed to continue with host->vcc = NULL; only in case [2], while
> in case [4] probe should fail.

You are right. Will fix it and resend the patch.

Thanks
Kishon
