From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 5/5] mmc: dw-mmc: fix the present flags for card detect
Date: Wed, 29 Aug 2012 10:51:37 +0900
Message-ID: <503D75A9.709@samsung.com>
References: <503C7981.5050209@samsung.com>
 <CAJuYYwQck2zXjQ9A5-m+cQd4DB55oBc4geJ35DEUQCYXdEDVWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:48527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab2H2Bvn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 21:51:43 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9H004OSUGS5T80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 10:51:42 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9H00ICAUI6ZQA0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 10:51:42 +0900 (KST)
In-reply-to: <CAJuYYwQck2zXjQ9A5-m+cQd4DB55oBc4geJ35DEUQCYXdEDVWA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On 08/28/2012 11:04 PM, Thomas Abraham wrote:
> On 28 August 2012 13:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> dw_mci_get_cd() is registered to call-back function.
>> If call host->ops->get_cd(), host didn't set any card present flag.
>> Then host didn't know whether card is present or not.
>> This patch fixed them.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Singed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    7 +++++--
>>  1 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 3642455..8a87d38 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -909,10 +909,13 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
>>                 present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
>>                         == 0 ? 1 : 0;
>>
>> -       if (present)
>> +       if (present) {
>> +               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>                 dev_dbg(&mmc->class_dev, "card is present\n");
>> -       else
>> +       } else {
>> +               clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>                 dev_dbg(&mmc->class_dev, "card is not present\n");
>> +       }
>>
>>         return present;
>>  }
>> --
>> 1.7.4.1
> 
> Isn't this already done in dw_mci_init_slot() function and other
> places in the driver? I have tested with card insert/removal multiple
> times and did not notice any failure.
In my case, use the external cd-gpio pin and use the mmc_gpio_request_cd().
In that case, if didn't insert SD-card when boot at first time, 
at next time host didn't recognize Sd-card.
And it's no problem that the code is placed into get_cd().

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Thomas.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

