From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: modify DATA register offset
Date: Mon, 17 Oct 2011 17:46:47 +0900
Message-ID: <4E9BEB77.4060202@samsung.com>
References: <4E9BD3D2.5020702@samsung.com> <4E9BE6E1.3060602@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43617 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1JQIrZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2011 04:47:25 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LT7001N4CEPW730@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Oct 2011 17:47:23 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LT700MKWCEZO260@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 17 Oct 2011 17:47:23 +0900 (KST)
In-reply-to: <4E9BE6E1.3060602@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

Hi James.

On 10/17/2011 05:27 PM, James Hogan wrote:

> Hi,
> 
> On 10/17/2011 08:05 AM, Jaehoon Chung wrote:
>> In dw_mmc 2.40a spec, Data register's offset is changed.
>> Now we used Data register offset is 0x100. but if somebody use 2.40a
>> controller, must use 0x200 for Data register.
>>
>> This patch is added version-id checking point and using SDMMC_DATA(x)
>> instead of SDMMC_DATA. (assume 2.40a is the latest version)
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |   66 ++++++++++++++++++++++++++++++--------------
>>  drivers/mmc/host/dw_mmc.h  |   10 ++++++-
>>  include/linux/mmc/dw_mmc.h |    2 +
>>  3 files changed, 56 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 701f14e..3aaeb08 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1043,7 +1043,8 @@ static void dw_mci_push_data16(struct dw_mci *host, void *buf, int cnt)
>>  		buf += len;
>>  		cnt -= len;
>>  		if (!sg_next(host->sg) || host->part_buf_count == 2) {
>> -			mci_writew(host, DATA, host->part_buf16);
>> +			mci_writew(host, DATA(host->data_offset),
>> +					host->part_buf16);
>>  			host->part_buf_count = 0;
>>  		}
>>  	}
> 
> I really think it would be more concise to just have something like this:
> mci_writew(host, host->data_offset, host->part_buf16);
> ...
> 
>> +#define DATA_OFFSET		0
>> +#define DATA_240A_OFFSET	0x100
> 
> and then have these as register positions like the other #defines, e.g.
> #define SDMMC_DATA      0x100
> #define SDMMC_DATA_240A 0x200
> 


Sorry, if change your suggestion, how do you control SDMMC_##reg?
mci_readl(dev, reg) __raw_readl(dev->regs + SDMMC_##reg)

>> @@ -1952,6 +1964,18 @@ static int dw_mci_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/*
>> +	 * In 2.40a spec, Data offset is changed.
>> +	 * Need to check the version-id and set data-offset for DATA register.
>> +	 */
>> +	host->verid = SDMMC_GET_VERID(mci_readl(host, VERID));
>> +	dev_info(&pdev->dev, "Version ID is %04x\n", host->verid);
>> +
>> +	if (host->verid < DW_MMC_240A)
>> +		host->data_offset = DATA_OFFSET;
>> +	else
>> +		host->data_offset = DATA_240A_OFFSET;
>> +
>> +	/*
>>  	 * Enable interrupts for command done, data over, data empty, card det,
>>  	 * receive ready and error such as transmit, receive timeout, crc error
>>  	 */
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index bfa3c1c..965fd19 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -14,6 +14,8 @@
>>  #ifndef _DW_MMC_H_
>>  #define _DW_MMC_H_
>>  
>> +#define DW_MMC_240A		0x240a
>> +
>>  #define SDMMC_CTRL		0x000
>>  #define SDMMC_PWREN		0x004
>>  #define SDMMC_CLKDIV		0x008
>> @@ -51,7 +53,11 @@
>>  #define SDMMC_IDINTEN		0x090
>>  #define SDMMC_DSCADDR		0x094
>>  #define SDMMC_BUFADDR		0x098
>> -#define SDMMC_DATA		0x100
>> +#define SDMMC_DATA(x)		(0x100 + (x))
>> +
>> +/* Data offset is difference according to Verision */
> 
> should that be "version"?

Typo..should fix that.

> 
>> +#define DATA_OFFSET		0
>> +#define DATA_240A_OFFSET	0x100
>>  
>>  /* shift bit field */
>>  #define _SBF(f, v)		((v) << (f))
>> @@ -130,6 +136,8 @@
>>  #define SDMMC_IDMAC_ENABLE		BIT(7)
>>  #define SDMMC_IDMAC_FB			BIT(1)
>>  #define SDMMC_IDMAC_SWRESET		BIT(0)
>> +/* Version ID register define */
>> +#define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>>  
>>  /* Register access macros */
>>  #define mci_readl(dev, reg)			\
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 6b46819..6928e29 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -147,6 +147,8 @@ struct dw_mci {
>>  	u32			current_speed;
>>  	u32			num_slots;
>>  	u32			fifoth_val;
>> +	u16			verid;
>> +	u16			data_offset;
>>  	struct platform_device	*pdev;
>>  	struct dw_mci_board	*pdata;
>>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
> 
> The kerneldoc comment above struct dw_mci should be updated to describe
> the new fields.

I will add the comment for new fields,

Best Regards,
Jaehoon Chung

> 

> Other than that it looks good to me.
> 
> Thanks
> James
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


