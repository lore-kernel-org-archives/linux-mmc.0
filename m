From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v5 4/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Fri, 31 Aug 2012 14:18:17 +0530
Message-ID: <CAJuYYwQ50HCSrDgxrvhRh5X2ECxi_g=_akoa6o9FYCQ5GqHUCQ@mail.gmail.com>
References: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
	<1346237295-7116-5-git-send-email-thomas.abraham@linaro.org>
	<503F28E7.1060608@samsung.com>
	<CAJuYYwQtAe7kC4DC5Ao04qU_9TSjcREw7ktuf6KNmgXHAvUzKg@mail.gmail.com>
	<5040536C.30407@samsung.com>
	<CAJuYYwSokqAegg1Z-jovYzanBYR-oZZaL2W=_nOSNVAsrM_PMw@mail.gmail.com>
	<50406EE9.1040004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43623 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751166Ab2HaIsT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Aug 2012 04:48:19 -0400
Received: by lagy9 with SMTP id y9so2121678lag.19
        for <linux-mmc@vger.kernel.org>; Fri, 31 Aug 2012 01:48:17 -0700 (PDT)
In-Reply-To: <50406EE9.1040004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org

On 31 August 2012 13:29, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>>> +
>>>>>> +     host->ciu_clk = clk_get(host->dev, "ciu");
>>>>>> +     if (IS_ERR(host->ciu_clk))
>>>>>> +             dev_dbg(host->dev, "ciu clock not available\n");
>>>>>> +     else
>>>>>> +             clk_prepare_enable(host->ciu_clk);
>>>>>> +
>>>>>> +     if (IS_ERR(host->ciu_clk))
>>>>>> +             host->bus_hz = host->pdata->bus_hz;
>>>>>> +     else
>>>>>> +             host->bus_hz = clk_get_rate(host->ciu_clk);
>>>>> if clk_get_rate() is incorrect value(ex,400MHz),
>>>>> then mmc->f_min value is too high.
>>>>> because mmc->f_min is assigned to DIV_ROUND_UP(host->bus_hz, 510) into dw_mc_init_slot.
>>>>> Do you have any opinion for solving this?
>>>>
>>>> One option on Exynos5250 is to use the clock divider in the CLKSEL
>>>> register to divide the ciu clock to a lower value. For Exynos4, since
>>>> there is no clock divider in CLKSEL register, the platform code should
>>>> ensure that the ciu clock has a valid range.
>>> I know that can use div-ratio filed at the clksel register.
>>> On Exynos5, i known that is used the div-ratio at CLKSEL register.
>>> If ciu-clock is 400MHz, host->bus_hz is assigned to 400MHz.
>>> 1) host->bus_hz -> 400MHz (at dw-mmc-pltfm.c)
>>> 2) mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510) then mmc->f_min is set to 784KHz.
>>> 3) then host->bus_hz is re-assigned to value that is divided to div-ratio at CLKSEL register.
>>>    at this time, host->bus_hz = 100MHz...
>>>
>>> I think this sequence is something wrong.
>>> (Is 784KHz too high for init card?)
>>>
>>> It's just my thinking..if my understanding is wrong, let me know plz.
>>
>> You have listed the steps 1 to 3 correctly. So, as per step 3, 100Mhz
>> / 510 ~= 196KHz. Which is well within 400KHz. So do you still see a
>> problem here?
> How do you think about this?
> [ 4.620000] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 784314Hz, actual 781250HZ div = 64)

You are right, the sequence is wrong. The host->bus_hz is set to the
correct value of 100Mhz in set_ios callback of exynos. But much prior
to that, the dw_mci_init_slot is called and that initializes
mmc->f_min to host->bus_hz / 510 = 400Mhz / 510 = 768KHz.

To fix this, I am planning to add another implementation specific
callback function that will adjust the host->bus_clk as per
implementation specific extensions. This callback will be called right
from dw_mci_probe right after the host->bus_hz is set using the
clk_get_rate() call.

Sorry, I was not paying proper attention to the log messages. Thanks
for your correction.

Regards,
Thomas.
