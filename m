From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/8] mmc: dw_mmc: use the mmc_of_parse() instead of
 local parser
Date: Wed, 29 Jan 2014 08:47:15 +0900
Message-ID: <52E84183.6060508@samsung.com>
References: <52E76955.2030701@samsung.com>
 <000601cf1c28$0246aed0$06d40c70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14721 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755884AbaA1Xqq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 18:46:46 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0400IZ4Y1WA0B0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Jan 2014 08:46:44 +0900 (KST)
In-reply-to: <000601cf1c28$0246aed0$06d40c70$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Olof Johansson' <olof@lixom.net>

On 01/28/2014 09:53 PM, Seungwon Jeon wrote:
> On Tue, January 28, 2014, Jaehoon Chung wrote:
>> mmc_of_parse() have been already parsed the general capability.
>> Didn't need to use the local parser.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>> 	- None
>>
>>  drivers/mmc/core/host.c   |    4 ++--
>>  drivers/mmc/host/dw_mmc.c |   49 +--------------------------------------------
>>  2 files changed, 3 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 5a82e81..4b81c93 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -429,9 +429,9 @@ int mmc_of_parse(struct mmc_host *host)
>>  		host->pm_caps |= MMC_PM_KEEP_POWER;
>>  	if (of_find_property(np, "enable-sdio-wakeup", &len))
>>  		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> -	if (of_find_property(np, "mmc-hs200-1_8v", NULL))
>> +	if (of_find_property(np, "mmc-hs200-1_8v", &len))
>>  		host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> -	if (of_find_property(np, "mmc-hs200-1_2v", NULL))
>> +	if (of_find_property(np, "mmc-hs200-1_2v", &len))
>>  		host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>>
>>  	return 0;
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 55cd110..8193e21 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2046,21 +2046,6 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>>  	return quirks;
>>  }
>>
>> -/* find out bus-width for a given slot */
>> -static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> -{
>> -	struct device_node *np = dw_mci_of_find_slot_node(dev, slot);
>> -	u32 bus_wd = 1;
>> -
>> -	if (!np)
>> -		return 1;
>> -
>> -	if (of_property_read_u32(np, "bus-width", &bus_wd))
>> -		dev_err(dev, "bus-width property not found, assuming width"
>> -			       " as 1\n");
>> -	return bus_wd;
>> -}
>> -
>>  /* find the write protect gpio for a given slot; or -1 if none specified */
>>  static int dw_mci_of_get_wp_gpio(struct device *dev, u8 slot)
>>  {
>> @@ -2108,10 +2093,6 @@ static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
>>  {
>>  	return 0;
>>  }
>> -static u32 dw_mci_of_get_bus_wd(struct device *dev, u8 slot)
>> -{
>> -	return 1;
>> -}
>>  static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
>>  {
>>  	return NULL;
>> @@ -2134,7 +2115,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
>>  	int ctrl_id, ret;
>>  	u32 freq[2];
>> -	u8 bus_width;
>>
>>  	mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
>>  	if (!mmc)
>> @@ -2189,19 +2169,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  	if (host->pdata->caps2)
>>  		mmc->caps2 = host->pdata->caps2;
>>
>> -	if (host->pdata->get_bus_wd)
>> -		bus_width = host->pdata->get_bus_wd(slot->id);
>> -	else if (host->dev->of_node)
>> -		bus_width = dw_mci_of_get_bus_wd(host->dev, slot->id);
>> -	else
>> -		bus_width = 1;
>> -
>> -	switch (bus_width) {
>> -	case 8:
>> -		mmc->caps |= MMC_CAP_8_BIT_DATA;
>> -	case 4:
>> -		mmc->caps |= MMC_CAP_4_BIT_DATA;
>> -	}
>> +	mmc_of_parse(mmc);
>>
>>  	if (host->pdata->blk_settings) {
>>  		mmc->max_segs = host->pdata->blk_settings->max_segs;
>> @@ -2399,24 +2367,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>  			return ERR_PTR(ret);
>>  	}
>>
>> -	if (of_find_property(np, "keep-power-in-suspend", NULL))
>> -		pdata->pm_caps |= MMC_PM_KEEP_POWER;
>> -
>> -	if (of_find_property(np, "enable-sdio-wakeup", NULL))
>> -		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> -
>>  	if (of_find_property(np, "supports-highspeed", NULL))
>>  		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>>
>> -	if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
>> -		pdata->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> -
>> -	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
>> -		pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
> Can you remove caps2-mmc-hs200-1_8v and caps2-mmc-hs200-1_2v in Documentation(synopsys-dw-mshc.txt)?

Sure, I will remove that.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
>> -
>> -	if (of_get_property(np, "cd-inverted", NULL))
>> -		pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>> -
>>  	return pdata;
>>  }
>>
>> --
>> 1.7.9.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

