From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a stable
 voltage
Date: Wed, 25 Feb 2015 18:56:02 +0900
Message-ID: <54ED9C32.60004@samsung.com>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
 <CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
 <CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
 <CAGOxZ53vcz96mFbb9ez3GAjZBqEQqiss_TmU1y7EQeRGTVLQdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44049 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbBYJ4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 04:56:06 -0500
In-reply-to: <CAGOxZ53vcz96mFbb9ez3GAjZBqEQqiss_TmU1y7EQeRGTVLQdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>, Doug Anderson <dianders@chromium.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, Andrzej Hajda <a.hajda@samsung.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Eddie Cai <cf@rock-chips.com>, lintao <lintao@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hi,

On 02/25/2015 04:52 PM, Alim Akhtar wrote:
> Hi Doug,
> 
> 
> On Fri, Feb 20, 2015 at 5:19 AM, Doug Anderson <dianders@chromium.org> wrote:
>> Alim and Addy,
>>
>> On Sun, Feb 15, 2015 at 3:28 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
>>> Hi Addy,
>>>
>>> On Sat, Feb 14, 2015 at 11:47 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>>>> As show in mmc_power_up(), in MMC_POWER_UP state, the voltage isn't
>>>> stable and we may get 'data busy' which can't be cleaned by resetting
>>>> all blocks. So we should not send command to update clock in this state.
>>>>
>>>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 4d2e3c2..3472f9b 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -1102,7 +1102,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>>                 drv_data->set_ios(slot->host, ios);
>>>>
>>>>         /* Slot specific timing and width adjustment */
>>>> -       dw_mci_setup_bus(slot, false);
>>>> +       if (ios->power_mode != MMC_POWER_UP)
>>>> +               dw_mci_setup_bus(slot, false);
>>>>
>>> This looks a HACK to me.
>>> If stabilizing host voltage regulator is the problem, can you try out
>>> below patch, and see if this resolve your issue?
>>
>> Actually, IMHO Alim's patch is more of a hack than Addy's.  There's
>> already a 10ms delay between "power up" and "power on" in the MMC core
>> in mmc_power_up() state.  That delay is commented as:
>>
> Well, my suggestion (adding 5ms in switch_volatge) was based on DW_MMC
> databook (V2.41a) section "7.4.1.2 Voltage switch Normal Scenario"
> step #7 which says:" After the 5ms timer expires, the host voltage
> regulator is stable".

if you want to stable power, How about using SDMMC_CMD_INIT flag?

It waits for 80-clock before sending command.(To stable power)
- You can refer to CMD register description.

Best Regards,
Jaehoon Chung

> 
> PS: I have limited to no access of my mails and workstation until
> March 9th, so replies will be slow.
> 
>>   /*
>>    * This delay should be sufficient to allow the power supply
>>    * to reach the minimum voltage.
>>    */
>>   mmc_delay(10);
>>
>> That means that assuming that the voltage is stable in MMC_POWER_UP is
>> not valid anyway.
>>
>>
>> Addy's patch certainly needs more comments.  In another context Olof suggested:
>>
>> /*
>>  * Skip bus setup while voltage is still stabilizing. Instead,
>>  * bus setup will be done at MMC_POWER_ON.
>>  */
>>
>>
>> ...thinking about this more, though: really the voltage should be
>> stabilized when the regulator call returns (see my comments below).
>> In actuality the "right" fix might be to just rearrange this function
>> a little not to turn the clock on _before_ we even try to turn the
>> voltage on.
>>
>> I've got that coded up but I'm still testing it...  If you want to try
>> it too, you can find it at
>> <https://chromium-review.googlesource.com/251341>.
>>
>> Note that without my patch I find that I _really_ need Addy's patch to
>> make sure that the card isn't busy in setup_bus.  With my patch Addy's
>> code catches the card busy less often.  I'm still trying to see if
>> there's a way to totally remove the need for his setup_bus and still
>> trying to grok all the patches flying around...
>>
>>
>>> ===========
>>> [PATCH] mmc: dw_mmc: Wait for host voltage regulator to be stable
>>>
>>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 4d2e3c2..dc10fbb 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1202,6 +1202,9 @@ static int dw_mci_switch_voltage(struct mmc_host
>>> *mmc, struct mmc_ios *ios)
>>>   }
>>>   mci_writel(host, UHS_REG, uhs);
>>>
>>> + /* wait for 5ms so that host voltage regulator is stable */
>>> + usleep_range(5000, 5500);
>>> +
>>
>> Alim: if you have some other instance where you actually need VQMMC to
>> stabilize it should probably be done in a different way.  If I
>> understand correctly it is the regulator core's job to make sure that
>> voltage is stable before returning.  If you have a gpio-regulator you
>> may be able to use "startup-delay-us" to specify how long the
>> regulator takes to come up.  You could also look at
>> 'regulator-enable-ramp-delay'
>>
>> -Doug
> 
> 
> 

