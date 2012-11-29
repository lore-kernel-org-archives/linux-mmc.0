From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v3 2/4] mmc: dw-mmc: remove the duplicated code
Date: Fri, 30 Nov 2012 00:03:55 +0900
Message-ID: <CAELcNGRR3NuOtBrm+_nQ3K99hZfhKKE+82NrwbBShsOE8_TksA@mail.gmail.com>
References: <509B6ED3.2000003@samsung.com>
	<001501cdcc75$5cb15d60$16141820$%jun@samsung.com>
	<50B48AC4.2050606@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39644 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab2K2PD4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Nov 2012 10:03:56 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so13100662obb.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Nov 2012 07:03:55 -0800 (PST)
In-Reply-To: <50B48AC4.2050606@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

2012/11/27 James Hogan <james.hogan@imgtec.com>:
> On 27/11/12 08:01, Seungwon Jeon wrote:
>> This is minor change.
>>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Thanks,
>> Seungwon Jeon
>
> Looks good to me too.
> Acked-by: James Hogan <james.hogan@imgtec.com>
>
>>
>> On Thursday, November 08, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> ctype is used 1-bit buswidth mode by default.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |    9 +++------
>>>  1 files changed, 3 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index a1369aa..0a80b5c 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -773,19 +773,16 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>      struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>>      u32 regs;
>>>
>>> -    /* set default 1 bit mode */
>>> -    slot->ctype = SDMMC_CTYPE_1BIT;
>>> -
>>>      switch (ios->bus_width) {
>>> -    case MMC_BUS_WIDTH_1:
>>> -            slot->ctype = SDMMC_CTYPE_1BIT;
>>> -            break;
>>>      case MMC_BUS_WIDTH_4:
>>>              slot->ctype = SDMMC_CTYPE_4BIT;
>>>              break;
>>>      case MMC_BUS_WIDTH_8:
>>>              slot->ctype = SDMMC_CTYPE_8BIT;
>>>              break;
>>> +    default:
>>> +            /* set default 1 bit mode */
>>> +            slot->ctype = SDMMC_CTYPE_1BIT;
>>>      }
>>>
>>>      regs = mci_readl(slot->host, UHS_REG);
>>> --
>>> 1.7.4.1
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
