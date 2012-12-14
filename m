From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 3/3] mmc: core: Fixup signal voltage switch
Date: Fri, 14 Dec 2012 18:55:23 +0800
Message-ID: <CADz5_gL8faTe170sz1MoOX8EyijAth6d0K8LdXy87yqTV0afcg@mail.gmail.com>
References: <1354897176-15307-1-git-send-email-johan.rudholm@stericsson.com>
	<1354897176-15307-4-git-send-email-johan.rudholm@stericsson.com>
	<50C2D989.5060901@codeaurora.org>
	<CA+20K0CQjvK1O9Lwci86xLom0G1aHQcKemz1zXdqz5YKFQiRpg@mail.gmail.com>
	<50C6D858.4020509@codeaurora.org>
	<CA+20K0BtApW9e+AFVqm4HMqvq=tCn1N2Ejc2LgK8h1AgYkJ-ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:48281 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab2LNKzY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 05:55:24 -0500
Received: by mail-wg0-f42.google.com with SMTP id dr1so333667wgb.1
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 02:55:23 -0800 (PST)
In-Reply-To: <CA+20K0BtApW9e+AFVqm4HMqvq=tCn1N2Ejc2LgK8h1AgYkJ-ng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Philip Rakity <prakity@marvell.com>, Daniel Drake <dsd@laptop.org>, Aaron <leafy.myeh@allwinnertech.com>

2012/12/14 Johan Rudholm <jrudholm@gmail.com>:
> Hi Subhash,
>
> 2012/12/11 Subhash Jadavani <subhashj@codeaurora.org>:
>> On 12/10/2012 1:51 PM, Johan Rudholm wrote:
>>>
>>> 2012/12/8 Subhash Jadavani <subhashj@codeaurora.org>:
>>>>
>>>> On 12/7/2012 9:49 PM, Johan Rudholm wrote:
>>>>>
>>>>> When switching SD and SDIO cards from 3.3V to 1.8V signal levels, the
>>>>> clock should be gated for 5 ms during the step. After enabling the
>>>>> clock, the host should wait for at least 1 ms before checking for
>>>>> failure. Failure by the card to switch is indicated by dat[0:3] being
>>>>> pulled low. The host should check for this condition and power-cycle
>>>>> the card if failure is indicated.
>>>>>
>>>>> Add a retry mechanism for the SDIO case.
>>>>>
>>>>> If the voltage switch fails repeatedly, give up and continue the
>>>>> initialization using the original voltage.
>>>>>
>>>>> This patch places a couple of requirements on the host driver:
>>>>>
>>>>>    1) mmc_set_ios with ios.clock = 0 must gate the clock
>>>>>    2) mmc_power_off must actually cut the power to the card
>>>>>
>>>>> if these requirements are not fulfilled, the 1.8V signal voltage switch
>>>>> may not be successful.
>>>
>>> <snip>
>>>
>>>>>                  err = host->ops->start_signal_voltage_switch(host,
>>>>> &host->ios);
>>>>
>>>>
>>>> Shouldn't you fix all the existing host drivers who have already
>>>> implemented
>>>> start_signal_voltage_switch host ops? If you don't change them as part of
>>>> this patch then
>>>> i afraid UHS functionality would be broken on those platforms. Also, it's
>>>> not just changing the start_signal_voltage_switch hot op implementation,
>>>> you
>>>> may also need to add card_busy() host op implementation for those
>>>> drivers.
>>>
>>> This is true, and I did actually make an RFC for the sdhci driver
>>> ("[RFC] mmc: sdhci: Let core handle UHS switch failure":
>>> https://patchwork.kernel.org/patch/1517211/). Daniel Drake tried this
>>> code for a problem related to the 1.8V switch (his board could
>>> actually not perform the switch to 1.8V even though this capability
>>> was announced), and I think this pointed out two areas for further
>>> investigation before a proper patch for the sdhci driver can be
>>> created:
>>>
>>> 1) the sdhci driver may not gate the clock when setting ios.clock = 0
>>> and calling mmc_set_ios
>>> 2) mmc_power_off may not cut power to the card
>>>
>>> maybe 2) was only for Daniel's board, I'm not sure, but this needs to
>>> be investigated further anyway. Since I don't have any sdhci hardware
>>> with UHS support, this must either be done by some other kind soul or
>>> it will have to wait until I get the hardware.
>>>
>>> sdhci is the only driver I'm aware of that's got (mainlined) support
>>> for start_signal_voltage_switch, are you thinking of any other driver?
>>
>> You may look at only in tree drivers who have implemented
>> start_singnal_voltage_switch() ops. Our msm_sdcc* driver has also
>> implemented it but it's not in tree driver so i may
>> need to take care of that later once we are synced to kernel version which
>> will have your patch series.
>
> Ok, good.
>
>> Yes, SDHCi seeems to be only one in tree driver implemented the
>> start_singnal_voltage_switch() ops. So you might be good fixing the same.
>
> It seems the UHS support in the SDHCI driver is a complex issue,
> judging from Daniel's experience described above, so I think the best
> way forward is to get these patches in and then take care of the SDHCI
> driver (perhaps based on my previous RFC), unless any of the SDHCI
> guys thinks differently? Naturally, I will be happy to assist in
> fixing the SDHCI driver.
>

Johan,

Just sent a patchset for sdhci based on your patch. Please help to review.
Tested with both UHS and non-UHS sd card on sdhci-pxav3 platform.

Thanks
Kevin
