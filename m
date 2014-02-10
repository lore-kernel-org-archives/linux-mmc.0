From: Puthikorn Voravootivat <puthik@chromium.org>
Subject: Re: [PATCH] dw-mmc: enable trim in eMMC device
Date: Mon, 10 Feb 2014 11:53:08 -0800
Message-ID: <CANCcNXfcf34e496oLH6bvwReNr6KAxX-8VnWejHCKBE11jUnUQ@mail.gmail.com>
References: <1391798398-24634-1-git-send-email-puthik@chromium.org>
	<52F8507A.4030904@samsung.com>
	<CAPDyKFpm3+rHVcW05aPdUhjpKj69EXpi0uzyf1aFqEBE_P-a-A@mail.gmail.com>
	<52F8A19E.90202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:35737 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbaBJTxK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Feb 2014 14:53:10 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so5250133lab.29
        for <linux-mmc@vger.kernel.org>; Mon, 10 Feb 2014 11:53:08 -0800 (PST)
In-Reply-To: <52F8A19E.90202@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Puthikorn Voravootivat <puthik@chromium.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, MMC list <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>

OK, I will send a v2 patch to make MMC_CAP_ERASE default enabled for all host.

Best Regards,
Puthikorn Voravootivat

On Mon, Feb 10, 2014 at 1:53 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/10/2014 06:41 PM, Ulf Hansson wrote:
>> On 10 February 2014 05:07, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi,
>>>
>>> On 02/08/2014 03:39 AM, Puthikorn Voravootivat wrote:
>>>> Force host to have erase capacity to enable trim or
>>>> discard feature in supported eMMC device.
>>>>
>>>> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
>>>> ---
>>>> In mmc_init_queue() before setting up the discard function, mmc driver
>>>> will call mmc_can_erase() which will always return 0 because the host
>>>> erase capacity is not set anywhere. So to enable discard function, we
>>>> need to add erase capacity to the host.
>>>>
>>>>  drivers/mmc/host/dw_mmc.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 55cd110..f47f1c1 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -55,6 +55,8 @@
>>>>  #define DW_MCI_FREQ_MAX      200000000       /* unit: HZ */
>>>>  #define DW_MCI_FREQ_MIN      400000          /* unit: HZ */
>>>>
>>>> +#define DW_MCI_DEFAULT_CAPS (MMC_CAP_ERASE)
>>>> +
>>>
>>> This define didn't need.
>>>
>>>>  #ifdef CONFIG_MMC_DW_IDMAC
>>>>  #define IDMAC_INT_CLR                (SDMMC_IDMAC_INT_AI | SDMMC_IDMAC_INT_NI | \
>>>>                                SDMMC_IDMAC_INT_CES | SDMMC_IDMAC_INT_DU | \
>>>> @@ -2371,6 +2373,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>>>               return ERR_PTR(-ENOMEM);
>>>>       }
>>>>
>>>> +     pdata->caps |= DW_MCI_DEFAULT_CAPS;
>>>> +
>>> I didn't want to enable by default. If it's possible, how about using dt-file?
>>> Well, if need to enable by default, just use the "pdata->caps |= MMC_CAPS_ERASE;"
>>
>> Why not push this one step further; remove MMC_CAPS_ERASE and make it
>> default enabled for all hosts?
>
> I think more better that All host used the MMC_CAP_ERASE by default, than this patch.
>
> Best Regards,
> Jaehoon Chung
>
>>
>> Kind regards
>> Ulf Hansson
>>
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>>       /* find out number of slots supported */
>>>>       if (of_property_read_u32(dev->of_node, "num-slots",
>>>>                               &pdata->num_slots)) {
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
