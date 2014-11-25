From: Addy <addy.ke@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc
 for vqmmc
Date: Tue, 25 Nov 2014 10:38:03 +0800
Message-ID: <5473EB8B.3000803@rock-chips.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>	<1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>	<CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>	<CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>	<5464152E.7040209@rock-chips.com>	<CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>	<CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>	<CAD=FV=UJT5zBkcj2a03Y_RWxad9+Pu83G_z79Xzzn74V=eRqww@mail.gmail.com> <CAPDyKFqt4rrwi940KAPyPONpjixK1730QmHEsN27V97jyHH+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqt4rrwi940KAPyPONpjixK1730QmHEsN27V97jyHH+Qw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockch>
List-Id: linux-mmc@vger.kernel.org


On Fri, Nov 24, 2014 at 9:29 PM, Ulf Hansson <ulf.hansson@linaro.org> 
wrote:

> On 21 November 2014 at 22:04, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Fri, Nov 21, 2014 at 9:42 AM, Doug Anderson <dianders@chromium.org> wrote:
>>> Ulf,
>>>
>>> On Fri, Nov 21, 2014 at 4:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> [...]
>>>>
>>>>> Sure
>>>>> If the first card is sd2.0 since startup, dw_mci_switch_voltage will not be called,
>>>> That can't be right. mmc_power_up() should trigger
>>>> dw_mci_switch_voltage() to be invoked.
>>> Hmmm, I think you're right.  Addy: can you double check if it's only
>>> the 2nd card for you?  I was thinking that if a regulator is currently
>>> 3.3V and you request 2.7 - 3.3V the regulator framework will treat
>>> that as a noop.  ...but that definitely doesn't appear to be the case.
>>> When I boot up the first time even with no SD card plugged in, I see
>>> this at bootup:
>>>
>>> [    3.042234] vccio_sd: 1800 <--> 3300 mV at 3300 mV
>>>
>>> ...showing that it started at 3.3V.  Then I see:
>>>
>>> $ grep "" /sys/class/regulator/regulator.16/{name,microvolts}
>>> /sys/class/regulator/regulator.16/name:vccio_sd
>>> /sys/class/regulator/regulator.16/microvolts:2700000
>>>
>>> ...so it is certainly getting changed even with no card plugged in.
>>>
>>>
>>> BTW: I don't actually have one of these failing cards--all of mine
>>> work.  Addy, do you know the make and model of the card you have that
>>> fails?
>> Just as a bit of a followup, I did some more digging...
>>
>> 1. It looks as if we now have a bit of "opposite" logic for vmmc vs.
>> vqmmc.  In mmc_power_up() I see that it sets the initial voltage as:
>>
>>    host->ios.vdd = fls(ocr) - 1;
> That's because we would like to supports as many cards as possible.
> The policy is based upon that some cards may not support lower
> voltages, but most will support higher.
>
>> That actually means that we're going to pick the maximum voltage for
>> vmmc (of the supported voltages).  For vqmmc dw_mmc is using the
>> regulator framework which (as described in my previous message) will
>> pick the minimum.
> Correct. I have thought this has been inside spec and choosing the
> lower value would be preferred to lower power consumption. Maybe we
> needs to re-visit this one more time.
>
> Here are some of the interesting sections in the eMMC spec:
> 10.3.3 Power supply Voltages
> "The VCCQ must be defined at equal to or less than VCC".
>
> 10.5 Bus signal levels
> Push-pull mode:
> Voh = 0.75 * VCCQ. (Do note, its VCCQ not VCC).
>
> Summary eMMC: VCCQ must be less and VCC, we should be inside spec.
>
> >From SD spec:
> 6.6.1 Threshold Level for High Voltage Range
> Voh = 0.75 * VDD.
>
> In worst case scenario, VDD = 3.6V and VIO = 2.7V. That gives as the
> factor of 0.75, thus we are inside spec but without margins.
* From eMMC4.5 spec:
   1. (VDDF)vcc: Supply voltage for flash memory,  which is  2.7v -- 3.3v
   2. (VDD)vccq: Supply voltage for memory controller, which is  1.7v -- 
1.95v  and 2,7v -- 3.6v

* And from RK3288 datasheet:
   Digtial GPIO Power(SDMMC0_VDD --> vccq) is 3.0v -- 3.6v and 1.62v - 1.98v

So I think:
3.3v:  (2.7v < vccq < 3.6v)   &&  (3.0v < vccq < 3.6v)  ==> (3.0v < vccq 
< 3.6v)
1.8v:  (1.7v < vccq < 1.95v)  && (1.62v < vccq < 1.98v) ==> (1.7v < vccq 
< 1.95v)

and (2.7v < vcc < 3.3v)

* And according to our hardware engineer:
   All of supply voltage must have +/- 10% cushion.

* And we have found in some worse card that there is 200mv voltage 
collapse when these card is insert.

So I think the best resolution is that vcc and vccq is configurable int 
dt table.

>> 2. Several people I've talked to have expressed concerns that our
>> minimum value is 2.7V.  Apparently that's really on the edge and makes
>> EEs a little nervous.  The quick sample of cards sitting on my desk
>> shows that they seem to claim 0x00ff8000, which doesn't include 2.7V.
> 0x00ff8000 states what values of VDD levels the device supports. Not VIO.
>
>>
>> Both of the above make me feel like dw_mmc should try its best to pick
>> a value for vqmmc that is closest to the value of vmmc (and >= 2.7V).
>> That also happens to make us work exactly like hosts where vmmc and
>> vqmmc are supplied by the same supply.
> I do see your point. And I agree that it would be nice to achieve
> something like this.
>
> The question is how to do this. For sure, we need to involve the mmc
> core to handle this correctly.
>
> Kind regards
> Uffe
>
>
>


