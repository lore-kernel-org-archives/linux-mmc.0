From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Thu, 28 Aug 2014 08:52:13 -0700
Message-ID: <CAD=FV=V1+xC3xzFvq_E2W1aRWvgwK20JZkUJzfnHV+_63C95ZQ@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
	<CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
	<CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
	<CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
	<53FAF8C7.8040007@samsung.com>
	<CAD=FV=XbV7R+FqRRucA5Cv2A+=3g8zccASwxcTtJD6YyO-ioCg@mail.gmail.com>
	<53FD5501.1010007@samsung.com>
	<CAD=FV=VCw1mLpArSY1uj+1zorWROjqGeT3dcTJYzr_1J6jdsBQ@mail.gmail.com>
	<53FD62C6.8010100@samsung.com>
	<CAD=FV=X+BsvTth4J3oqLJ=pMw_NB-GoYnaqJgyOSr9foLreLvQ@mail.gmail.com>
	<53FEEBCA.3040909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:46822 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbaH1PwO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Aug 2014 11:52:14 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so1045487vcb.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2014 08:52:13 -0700 (PDT)
In-Reply-To: <53FEEBCA.3040909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, "cpgs ." <cpgs@samsung.com>

Jaehoon,

On Thu, Aug 28, 2014 at 1:43 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/28/2014 12:49 AM, Doug Anderson wrote:
>> Jaehoon,
>>
>> On Tue, Aug 26, 2014 at 9:47 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Doug,
>>>
>>> On 08/27/2014 01:14 PM, Doug Anderson wrote:
>>>> Jaehoon,
>>>>
>>>> On Tue, Aug 26, 2014 at 8:48 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi, Doug,
>>>>>
>>>>> On 08/26/2014 12:25 AM, Doug Anderson wrote:
>>>>>> Jaehoon,
>>>>>>
>>>>>> On Mon, Aug 25, 2014 at 1:50 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>>>> On 08/25/2014 05:13 PM, Ulf Hansson wrote:
>>>>>>>> On 22 August 2014 20:27, Sonny Rao <sonnyrao@chromium.org> wrote:
>>>>>>>>> On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>>>>>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>>>>>>>>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>>>>>>>>>>> detection.But unfortunately CD# line is on the same voltage rails
>>>>>>>>>>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>>>>>>>>>>> detection will break in these boards.
>>>>>>>
>>>>>>> I didn't know that use CD# line for card detect.
>>>>>>> And if CD# voltage rails and I/O voltage rail are same voltage, it doesn't make sense.
>>>>>>> Which card is used with same voltages? (eMMC? SD? SDIO?)
>>>>>>>
>>>>>>> Well, I have checked Exynos5250 and 5420, but it looks like not same rails.
>>>>>>
>>>>>> I'm not sure I totally understood what you said.  In my manual I have
>>>>>> a table titled "Table 2-1 Exynos 5420 Pin List".  Look in this table
>>>>>> for XMMC2CDN and XMMC2DATA_0.  Look to the right of the table and
>>>>>> you'll see the power domain.  For both it shows VDDQ_MMC2.  If that
>>>>>> doesn't mean that the two are in the same voltage domain then I don't
>>>>>> know what does.  Can you point to any examples where they have
>>>>>> different voltage domains?
>>>>> I think you're mis-understanding for it.
>>>>> Right, It's described at exynos5420, but it's not connected.
>>>>
>>>> "It's not connected".  What do you mean?  If I were to guess I'd say
>>>> that on some particular board you're looking at they don't happen to
>>>> use the "CD" pin for card detect.  If this is what you mean, it
>>>> doesn't help me.  exynos5420-peach-pit does use the CD pin for card
>>>> detect.  You can look at the DTS file and confirm it.
>>>
>>> I didn't know how exynos5420-peach-pit's circuit is configured.
>>> But i guess that almost all exynos5 boards are configured with the similar circuit.
>>>
>>> At Almost all Exynos5 board, CD-pin is used, but not included in Same power domain.
>>> (CD-pin is external card-detect pin. - like XEINT_# pin)
>>> You mentioned CD# and DATA# lines is used the same power domain, right?
>>> In Circuit (not exynos5420-peach-pit), DATA# line and CMD/CLK(vqmmc) is same power supply, and vdd is used other power supply.
>>> Not use the CD# pin, used the XEINT_# pin.
>>> So i think we don't need to consider the CD#.
>>> If exynos5420-peach-pit board is used the CD#-pin, then our discussion can be changed.
>>
>> Maybe on your board you have CD connected to a "gpx" line.  ...but not
>> mine.  The guys who designed our hardware followed the SMDK5420
>> reference schematics which connect the SD card slot card detect to
>> "gpc2_2", which is the card detect pin.
>>
>> See "arch/arm/boot/dts/exynos5420-smdk5420.dts", specifically noting
>> the lack of a GPIO card detect and the inclusion of "sd2_cd"
>>
>> mmc@12220000 {
>>   status = "okay";
>>   card-detect-delay = <200>;
>>   samsung,dw-mshc-ciu-div = <3>;
>>   samsung,dw-mshc-sdr-timing = <2 3>;
>>   samsung,dw-mshc-ddr-timing = <1 2>;
>>   pinctrl-names = "default";
>>   pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>   bus-width = <4>;
>>   cap-sd-highspeed;
>> };
>>
>> See "arch/arm/boot/dts/exynos5420-peach-pit.dts" too:
>>
>> &mmc_2 {
>>   status = "okay";
>>   num-slots = <1>;
>>   cap-sd-highspeed;
>>   card-detect-delay = <200>;
>>   clock-frequency = <400000000>;
>>   samsung,dw-mshc-ciu-div = <3>;
>>   samsung,dw-mshc-sdr-timing = <2 3>;
>>   samsung,dw-mshc-ddr-timing = <1 2>;
>>   pinctrl-names = "default";
>>   pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>>   bus-width = <4>;
>> };
>>
>>
>> Here, see this ASCII art that shows how some lines are hooked up on
>> peach-pit.  You might need to paste this into something with a
>> fixed-width font.
>>
>>                      +--------------------
>>                      |    Exynos 5420
>>                      |
>>                      |
>> P2.8V_LOUT4 ---------|- VDDQ_MMC2 (AK7)
>>     |                |
>>     |                |
>>   +-+- 10K res -+----|- XMMC2CDN (AK6)
>>   |             |    |
>>   |             |    |
>>   |             |    |
>>   |           Ext CD |
>>   |                  |
>>   +-- 10K res-+--+---|- XMMC2CMD (AK8)
>>                  |
>>                  |
>>                Ext CMD
>>
>> You can see from the above that the external card detect signal (that
>> goes to the connector) named "Ext CD" is pulled up to the same voltage
>> as the external CMD signal (that also goes to the connector).  This is
>> vqmmc.  If we turn off vqmmc then the 10K resistor will (I think) act
>> as a pull down, or in the best case it will be floating.
>>
>> Said another way: we can't read card detect when vqmmc is off.
>
> If that's the case, it makes sense. But i wonder why designed like that.
> Anyway, then we need to consider that controls the vqmmc power for card-detection.

Maybe you can send a message to the SoC designers at Samsung not to
design the chip incorrectly in the future?
