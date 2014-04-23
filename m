From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: Turn SDIO interrupts on
Date: Wed, 23 Apr 2014 09:42:47 +0530
Message-ID: <CAGOxZ53urGaOmezRi35fGpz_sR+E8Ukq3s9v08pAGLL6ChOWKw@mail.gmail.com>
References: <1395635037-24081-1-git-send-email-yuvaraj.cd@samsung.com>
 <532FB4A7.7020700@samsung.com> <CAKuRcOKOBebW157R16_KtSR541MwwZ4pyynBRnbvOLm9RK4SAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:34431 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbaDWEN2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Apr 2014 00:13:28 -0400
In-Reply-To: <CAKuRcOKOBebW157R16_KtSR541MwwZ4pyynBRnbvOLm9RK4SAg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Grant Grundler <grundler@chromium.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Doug Anderson <dianders@chromium.org>

Hi Yuvaraj,

On Mon, Mar 24, 2014 at 10:12 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
> On Mon, Mar 24, 2014 at 9:59 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi, Yuvaraj.
>>
>> NACK. we can use "mmc_of_parese()".
> Thanks Jaehoon for the pointer.I will use "mmc_of_parse()".
Are you planning to re-spin this patch? Now Jaehoon's changes for
using mmc_of_parse() is landed in mmc-next.
Thanks!!
>>
>> I have sent the patch that use "mmc_of_parse()".
>> https://patchwork.kernel.org/patch/3750681/
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 03/24/2014 01:23 PM, Yuvaraj Kumar C D wrote:
>>> The mmc part in exynos supports SDIO interrupts and they work fine, so
>>> turn the capability on.  With this I see download speeds increase
>>> about 10x.
>>>
>>> This V1 of this patch is posted to LKML at
>>> https://patchwork.kernel.org/patch/2429661/) by Doug Anderson.
>>>
>>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 0c56faa..240949d 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -2417,6 +2417,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>>       if (of_get_property(np, "cd-inverted", NULL))
>>>               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>>>
>>> +     if (of_find_property(np, "cap-sdio-irq", NULL))
>>> +             pdata->caps |= MMC_CAP_SDIO_IRQ;
>>> +
>>>       return pdata;
>>>  }
>>>
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
