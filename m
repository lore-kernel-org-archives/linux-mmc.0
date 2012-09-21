From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 6/9] mmc: dw_mmc: add device tree support
Date: Fri, 21 Sep 2012 11:43:06 +0900
Message-ID: <505BD43A.9020608@samsung.com>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
 <1347905803-22742-7-git-send-email-thomas.abraham@linaro.org>
 <001301cd966c$3f99f0a0$becdd1e0$%jun@samsung.com>
 <CAJuYYwQOCLPsVjGYQFTnTaqDeWnaDONGMHPEF5TB3htYc5SsJA@mail.gmail.com>
 <003501cd97a0$98a7fcc0$c9f7f640$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31926 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab2IUCnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Sep 2012 22:43:31 -0400
In-reply-to: <003501cd97a0$98a7fcc0$c9f7f640$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

>>>> +#else /* CONFIG_OF */
>>>> +static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>>> +{
>>>> +     return ERR_PTR(-EINVAL);
>>>> +}
>>>> +#endif /* CONFIG_OF */
>>>> +
>>>>  int dw_mci_probe(struct dw_mci *host)
>>>>  {
>>>>       int width, i, ret = 0;
>>>>       u32 fifo_size;
>>>>       int init_slots = 0;
>>>>
>>>> -     if (!host->pdata || !host->pdata->init) {
>>> "!host->pdata->init" is removed.
>>> Please check it.
>>
>> I have checked again in mmc-next branch and "init" is still there.
> I mean that there is no condition whether "host->pdata->init" is present or not, unlike origin code.
> In this patch this condition is removed. We don't need it anymore?
Actually i didn't know why need the pdata->init.
Why need host->pdata->init? In case of exynos, just return 1.
I didn't know how use this at other-soc.

Best Regards,
Jaehoon Chung
> 
>>
>> Thanks,
>> Thomas.
>>
>>
>>>
>>> Thanks,
>>> Seungwon Jeon
>>>
>>>> -             dev_err(host->dev,
>>>> -                     "Platform data must supply init function\n");
>>>> -             return -ENODEV;
>>>> +     if (!host->pdata) {
>>>> +             host->pdata = dw_mci_parse_dt(host);
>>>> +             if (IS_ERR(host->pdata)) {
>>>> +                     dev_err(host->dev, "platform data not available\n");
>>>> +                     return -EINVAL;
>>>> +             }
>>>>       }
>>>>
>>>>       if (!host->pdata->select_slot && host->pdata->num_slots > 1) {
>>>> --
>>>> 1.6.6.rc2
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> [...]
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

