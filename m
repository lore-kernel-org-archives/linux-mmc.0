From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv2 1/2] arm: samsung: support the second capability for
 samsung-soc
Date: Tue, 15 Nov 2011 19:18:38 +0900
Message-ID: <4EC23C7E.1070503@samsung.com>
References: <4EB1FE0E.5070902@samsung.com>
 <005b01cca37c$6f9f3a00$4eddae00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:20463 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1KOKSu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 05:18:50 -0500
In-reply-to: <005b01cca37c$6f9f3a00$4eddae00$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>

Hi Kukjin

On 11/15/2011 06:53 PM, Kukjin Kim wrote:

> Jaehoon Chung wrote:
>>
>> In mmc, there are capabilities and use the host_caps.
>> That capability is expressed with bit[0:31].
>> But now..already filled the bit[0:31]...
>> so we need to denote with the other capability field.
>> (if we want to use the cache, powerclass, etc for eMMC..this field is
> necessary)
>>
> Hi,
> 
> This description is better than previous.
> However, I wonder this is _really_ used for eMMC at sdhci-s3c.c driver.


You means that samsung is using the other, right?
If that is reason, i think that we need to add the second capability in future.
Because, Second capability also need for SD/SDIO interface.
(if need not to add the second capability, 
how do you add more capabilities for SD/SDIO)

Best Regards,
Jaehoon Chung

> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
>> ---
>> Changelog v2:
>>    - based-on samsung-soc's for-next tree.
>>
>>  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
>>  arch/arm/plat-samsung/platformdata.c       |    2 ++
>>  2 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
>> samsung/include/plat/sdhci.h
>> index dcff7dd..bf33ea1 100644
>> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
>> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
>> @@ -40,6 +40,7 @@ enum clk_types {
>>   * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
>>   * @max_width: The maximum number of data bits supported.
>>   * @host_caps: Standard MMC host capabilities bit field.
>> + * @host_caps2: The Second Standard MMC host capabilities bit field.
>>   * @cd_type: Type of Card Detection method (see cd_types enum above)
>>   * @clk_type: Type of clock divider method (see clk_types enum above)
>>   * @ext_cd_init: Initialize external card detect subsystem. Called on
>> @@ -63,6 +64,7 @@ enum clk_types {
>>  struct s3c_sdhci_platdata {
>>  	unsigned int	max_width;
>>  	unsigned int	host_caps;
>> +	unsigned int	host_caps2;
>>  	enum cd_types	cd_type;
>>  	enum clk_types	clk_type;
>>
>> diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-
>> samsung/platformdata.c
>> index 4c9a207..5ffcf46 100644
>> --- a/arch/arm/plat-samsung/platformdata.c
>> +++ b/arch/arm/plat-samsung/platformdata.c
>> @@ -54,4 +54,6 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata
> *pd,
>>  		set->host_caps |= pd->host_caps;
>>  	if (pd->clk_type)
>>  		set->clk_type = pd->clk_type;
>> +	if (pd->host_caps2)
>> +		set->host_caps2 |= pd->host_caps2;
>>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


