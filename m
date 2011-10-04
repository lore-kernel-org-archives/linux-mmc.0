From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: use the use_hold_reg bit in CMD register
Date: Tue, 04 Oct 2011 10:21:31 +0900
Message-ID: <4E8A5F9B.8060204@samsung.com>
References: <4E859DEF.7090308@samsung.com> <4E85A293.6020006@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43745 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567Ab1JDBVm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2011 21:21:42 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LSI008T7P3SSN10@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 10:21:41 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LSI009DXP44DQ40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Oct 2011 10:21:40 +0900 (KST)
In-reply-to: <4E85A293.6020006@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>

Hi James

On 09/30/2011 08:05 PM, James Hogan wrote:

> Hi,
> 
> On 09/30/2011 11:46 AM, Jaehoon Chung wrote:
>> This patch is added the use_hold_reg bit in CMD register.
>>
>> In 2.40a, bit[29] of CMD register is used the use_hold_reg.
>> Some SoC is affected by this bit.
>> (This bit means whether use hold register when send data and cmd.
>>  And related with cclk_in_drv phase)
>> if set IMPLEMENT_HOLD_REG in HCON register, i think fine that set this
>> bit by default.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c  |    9 +++++++++
>>  drivers/mmc/host/dw_mmc.h  |    1 +
>>  include/linux/mmc/dw_mmc.h |    1 +
>>  3 files changed, 11 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0ed1d28..544a616 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -276,6 +276,13 @@ static void dw_mci_start_command(struct dw_mci *host,
>>  	mci_writel(host, CMDARG, cmd->arg);
>>  	wmb();
>>
>> +	/*
>> +	 * If use HOLD register,
>> +	 * CMD and DATA sent to card through HOLD register.
>> +	 */
>> +	if (host->use_hold_reg)
>> +		cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
>> +
> 
> Is the HOLD register an internal register that is always required for
> hardware that has it to work? What effect does it have on the transaction?


I known that it's internal register. if we used hold register, it should
be work to delay cclk_in to drive the card output.

> 
>>  	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>>  }
>>
>> @@ -1886,6 +1893,8 @@ static int dw_mci_probe(struct platform_device *pdev)
>>  		host->data_shift = 2;
>>  	}
>>
>> +	host->use_hold_reg = (mci_readl(host, HCON) >> 22) & 0x1;
>> +
> 
> it'd be nice to have a #define for the HCON bit.


I will add a #define for the HCON

> 
>>  	/* Reset all blocks */
>>  	if (!mci_wait_reset(&pdev->dev, host)) {
>>  		ret = -ENODEV;
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index bfa3c1c..8c4edca 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -102,6 +102,7 @@
>>  #define SDMMC_INT_ERROR			0xbfc2
>>  /* Command register defines */
>>  #define SDMMC_CMD_START			BIT(31)
>> +#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
>>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>>  #define SDMMC_CMD_UPD_CLK		BIT(21)
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 6b46819..d6d1515 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -147,6 +147,7 @@ struct dw_mci {
>>  	u32			current_speed;
>>  	u32			num_slots;
>>  	u32			fifoth_val;
>> +	bool			use_hold_reg;
> 
> in case of other similar bits being added it may be better to have a
> copy of the hcon register here, but its fine as it is too.

>

>>  	struct platform_device	*pdev;
>>  	struct dw_mci_board	*pdata;
>>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
> 
> Cheers
> James
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


