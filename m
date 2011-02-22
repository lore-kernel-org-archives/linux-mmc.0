From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: set the debounce value and remove duplicated offset
Date: Tue, 22 Feb 2011 11:18:04 +0900
Message-ID: <4D631CDC.2060702@samsung.com>
References: <4D6228F6.6020500@samsung.com>
 <AANLkTi=Vv8=7FwArQPwjXPZ93YoE7uKvyR-0Ze81Lmbn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18307 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab1BVCTp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 21:19:45 -0500
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGZ0061CYFA3NA0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Feb 2011 11:18:46 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGZ00FJWYFAOA@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Feb 2011 11:18:46 +0900 (KST)
In-reply-to: <AANLkTi=Vv8=7FwArQPwjXPZ93YoE7uKvyR-0Ze81Lmbn@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Will Newton wrote:
> On Mon, Feb 21, 2011 at 8:57 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> This patch is set the debouce value..
>> This value do not need to be changed with every command.
>> So we set the value in probe function.
>>
>> And DATA register offset is duplicated..
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>  drivers/mmc/host/dw_mmc.h |    1 -
>>  2 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 62c8440..b3f94ff 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1623,6 +1623,9 @@ static int dw_mci_probe(struct platform_device *pdev)
>>        /* Put in max timeout */
>>        mci_writel(host, TMOUT, 0xFFFFFFFF);
>>
>> +       /* Set the debounce value */
>> +       mci_writel(host, DEBNCE, 0xFFFFFF);
>> +
> 
> As I understand it this is the reset value of the DEBNCE register? Why
> do we need to set it at all?

If need to set other value, we can change the debounce value (5~25ms).
This value is default reset value.

> 
>>        /*
>>         * FIFO threshold settings  RxMark  = fifo_size / 2 - 1,
>>         *                          Tx Mark = fifo_size / 2 DMA Size = 8
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 5dd55a7..f492837 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -51,7 +51,6 @@
>>  #define SDMMC_DSCADDR          0x094
>>  #define SDMMC_BUFADDR          0x098
>>  #define SDMMC_DATA             0x100
>> -#define SDMMC_DATA_ADR         0x100
> 
> This part is fine.
> 
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

