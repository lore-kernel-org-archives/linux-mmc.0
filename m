From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 7/8] mmc: dw_mmc: remove the dw_mci_of_cd_gpio()
Date: Fri, 07 Feb 2014 11:44:53 +0900
Message-ID: <52F448A5.5050101@samsung.com>
References: <52EF7A5A.1090908@samsung.com>
 <002901cf232e$41fef750$c5fce5f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61510 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBGCow (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 21:44:52 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0L002XSUAQTN00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Feb 2014 11:44:50 +0900 (KST)
In-reply-to: <002901cf232e$41fef750$c5fce5f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>

On 02/06/2014 08:26 PM, Seungwon Jeon wrote:
> On Mon, February 03, 2014, Jaehoon Chung wrote:
>> If mmc_of_parse() is used, dw_mci_of_get_cd_gpio didn't need.
>> Already implemented into mmc_of_parse().
> 
> Can be this done in 2/8(mmc: dw_mmc: use the mmc_of_parse() instead of local parser) together?
> Additionally we have a chance to remove 'write protect gpio' part including dw_mci_of_get_wp_gpio() now.
> mmc_of_parse() also has those.
> Can you address more?
Sure! It can be removed also. I will update it.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V3:
>> 	-None
>>
>>  drivers/mmc/host/dw_mmc.c |   26 --------------------------
>>  1 file changed, 26 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 2f40593..ac2907d 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2048,26 +2048,6 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
>>
>>  	return gpio;
>>  }
>> -
>> -/* find the cd gpio for a given slot */
>> -static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
>> -					struct mmc_host *mmc)
>> -{
>> -	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
>> -	int gpio;
>> -
>> -	if (!np)
>> -		return;
>> -
>> -	gpio = of_get_named_gpio(np, "cd-gpios", 0);
>> -
>> -	/* Having a missing entry is valid; return silently */
>> -	if (!gpio_is_valid(gpio))
>> -		return;
>> -
>> -	if (mmc_gpio_request_cd(mmc, gpio, 0))
>> -		dev_warn(dev, "gpio [%d] request failed\n", gpio);
>> -}
>>  #else /* CONFIG_OF */
>>  static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>>  {
>> @@ -2081,11 +2061,6 @@ static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
>>  {
>>  	return -EINVAL;
>>  }
>> -static void dw_mci_of_get_cd_gpio(struct device *dev, u8 slot,
>> -					struct mmc_host *mmc)
>> -{
>> -	return;
>> -}
>>  #endif /* CONFIG_OF */
>>
>>  static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>> @@ -2165,7 +2140,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  	}
>>
>>  	slot->wp_gpio = dw_mci_of_get_wp_gpio(host->dev, slot->id);
>> -	dw_mci_of_get_cd_gpio(host->dev, slot->id, mmc);
>>
>>  	ret = mmc_add_host(mmc);
>>  	if (ret)
>> --
>> 1.7.9.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

