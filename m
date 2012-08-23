From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/5] mmc: dw-mmc: ensure that the card is not busy when
 changing clock.
Date: Thu, 23 Aug 2012 22:26:58 +0900
Message-ID: <50362FA1.6010005@samsung.com>
References: <503614A5.5090906@samsung.com>
 <CAFbHwiRm3niUF+Kds0-+XOUzCu8F5hkY9NJi+jKg_PtFrhQ+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53867 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933798Ab2HWN1P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 09:27:15 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M97006MAMOWBFC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 22:27:14 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9700IXUMPDNO20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Aug 2012 22:27:13 +0900 (KST)
In-reply-to: <CAFbHwiRm3niUF+Kds0-+XOUzCu8F5hkY9NJi+jKg_PtFrhQ+CQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On 08/23/2012 09:33 PM, Will Newton wrote:
> On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> To avoid glitches in the card clock output,
>> need to check whether card is busy or not.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   30 ++++++++++++++++++++++++------
>>  drivers/mmc/host/dw_mmc.h |    1 +
>>  2 files changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 36f98c0..8bef3c2 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -623,6 +623,27 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>>                 cmd, arg, cmd_status);
>>  }
>>
>> +static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci *host = slot->host;
>> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);
> 
> Is there a reason why this timeout value was chosen? It seems quite long.
There is no special reason. I will fix it with more reasonable value.
> 
>> +       u32 ctrl, status;
>> +
>> +       do {
>> +               status = mci_readl(host, STATUS);
>> +               if (!(status & SDMMC_DATA_BUSY))
>> +                       break;
>> +               ctrl = mci_readl(host, CTRL);
>> +               ctrl |= SDMMC_CTRL_RESET;
>> +               mci_writel(host, CTRL, ctrl);
>> +       } while (time_before(jiffies, timeout));
>> +
>> +       if (status & SDMMC_DATA_BUSY)
>> +               dev_err(&slot->mmc->class_dev,"Card is busy..!\n");
> 
> The two periods in this message do not need to be there.
Will fix.

Best Regards,
Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

