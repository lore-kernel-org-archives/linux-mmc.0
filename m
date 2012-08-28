From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v4 9/9] mmc: dw_mmc: add support for exynos specific
 implementation of dw-mshc
Date: Tue, 28 Aug 2012 10:50:03 +0530
Message-ID: <CAJuYYwR4hnr+GykJmEj+9Tmo6QknOQ11_1CbbuHehTNhRuXAhQ@mail.gmail.com>
References: <1345981927-26359-1-git-send-email-thomas.abraham@linaro.org>
	<1345981927-26359-10-git-send-email-thomas.abraham@linaro.org>
	<503B36D0.4030208@samsung.com>
	<CAJuYYwTKXuJe-8N3kOkkUg_bCzAdG-cG4yjk67zF7dmrg+eGpw@mail.gmail.com>
	<503C4F5D.8050302@samsung.com>
	<CAJuYYwSCJ4M6-49ELvgBz-o42kvvExTs=U+qrG_KSF2--zrD4g@mail.gmail.com>
	<CAJuYYwTShXkEJHHUtsSSzQc13b+uYg80iN5H6s4XRRmxk8rRQQ@mail.gmail.com>
	<503C542E.9080301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40058 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2H1FUF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 01:20:05 -0400
Received: by lbbgj3 with SMTP id gj3so2995798lbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 27 Aug 2012 22:20:03 -0700 (PDT)
In-Reply-To: <503C542E.9080301@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org

On 28 August 2012 10:46, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/28/2012 02:10 PM, Thomas Abraham wrote:
>> On 28 August 2012 10:40, Thomas Abraham <thomas.abraham@linaro.org> wrote:
>>> On 28 August 2012 10:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>> Hi Thomas,
>>>>
>>>> On 08/28/2012 01:48 PM, Thomas Abraham wrote:
>>>>> On 27 August 2012 14:28, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>>> Hi Thomas,
>>>>>>
>>>>>>> +     gpio = of_get_named_gpio(slot_np, "wp-gpios", 0);
>>>>>>> +     if (gpio_is_valid(gpio)) {
>>>>>>> +             if (devm_gpio_request(host->dev, gpio, "dw-mci-wp"))
>>>>>>> +                     dev_info(host->dev, "gpio [%d] request failed\n",
>>>>>>> +                                             gpio);
>>>>>>> +     } else {
>>>>>>> +             dev_info(host->dev, "wp gpio not available");
>>>>>>> +             host->pdata->quirks |= DW_MCI_QUIRK_NO_WRITE_PROTECT;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
>>>>>>> +             return 0;
>>>>>>> +
>>>>>>> +     gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
>>>>>>> +     if (gpio_is_valid(gpio)) {
>>>>>>> +             if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
>>>>>> I'm not sure, but i saw mmc_gpio_request_cd() into drivers/mmc/core/slot-gpio.c.
>>>>>> Can we use this? i think we can use them.
>>>>>> Just my opinion.
>>>>>
>>>>> Thanks for letting me know about this, I was not aware of this.
>>>>> Looking into this code, it is usable for controllers that use a gpio
>>>>> (specified using cd-gpios property) as card-detect line. As you know,
>>>>> the dw-mmc driver does not support this feature yet. In case of
>>>>> exynos, the card-detect pin of the mmc slot is connected to the
>>>>> card-detect pad of the dw-mmc controller using pinmux, which is not
>>>>> considered as a gpio. Hence, mmc_gpio_request_cd() is not applicable
>>>>> in this case.
>>>> But In case of external card-detect-pin, we can use the mmc_gpio_request_cd().
>>>
>>> Yes, we can use. But the current dw-mmc controller driver does not
>>> support this feature yet. The existing driver considers that (a)
>>> card-detect line is connected to the card-detect pad of the controller
>>> or (b) it is broken. For Exynos5250, it is case (a). There is no
>>
>> Sorry, I meant smdk5250, not Exynos5250.
> Already i tested with my exynos5 board.
> If you want, i will share the patch.

But did you use "samsung,cd-pinmux-gpio" binding or "cd-gpios" binding
for specifying the card-detect line. I think, for your board, you have
to use "cd-gpios". But this patch series does not add support for
"cd-gpios".

Sure, I will like to have a look at your patch and understand more.

Thanks,
Thomas.
