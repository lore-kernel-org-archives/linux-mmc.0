From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v3 2/4] mmc: dw-mmc: remove the duplicated code
Date: Tue, 27 Nov 2012 09:41:24 +0000
Message-ID: <50B48AC4.2050606@imgtec.com>
References: <509B6ED3.2000003@samsung.com> <001501cdcc75$5cb15d60$16141820$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55615 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758342Ab2K0JmS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Nov 2012 04:42:18 -0500
In-Reply-To: <001501cdcc75$5cb15d60$16141820$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>

On 27/11/12 08:01, Seungwon Jeon wrote:
> This is minor change.
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks,
> Seungwon Jeon

Looks good to me too.
Acked-by: James Hogan <james.hogan@imgtec.com>

> 
> On Thursday, November 08, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> ctype is used 1-bit buswidth mode by default.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    9 +++------
>>  1 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index a1369aa..0a80b5c 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -773,19 +773,16 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>  	u32 regs;
>>
>> -	/* set default 1 bit mode */
>> -	slot->ctype = SDMMC_CTYPE_1BIT;
>> -
>>  	switch (ios->bus_width) {
>> -	case MMC_BUS_WIDTH_1:
>> -		slot->ctype = SDMMC_CTYPE_1BIT;
>> -		break;
>>  	case MMC_BUS_WIDTH_4:
>>  		slot->ctype = SDMMC_CTYPE_4BIT;
>>  		break;
>>  	case MMC_BUS_WIDTH_8:
>>  		slot->ctype = SDMMC_CTYPE_8BIT;
>>  		break;
>> +	default:
>> +		/* set default 1 bit mode */
>> +		slot->ctype = SDMMC_CTYPE_1BIT;
>>  	}
>>
>>  	regs = mci_readl(slot->host, UHS_REG);
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

