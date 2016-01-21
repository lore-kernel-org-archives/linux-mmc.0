From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH RFC 09/15] ARM: dts: sun6i: sina31s: Switch to mmc3 for
 onboard eMMC
Date: Thu, 21 Jan 2016 13:38:54 +0100
Message-ID: <56A0D15E.8030308@redhat.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-10-git-send-email-wens@csie.org>
 <56A0BE25.1020309@redhat.com>
 <CAGb2v64-Hx_uCHZVw61OUc-z_KvHHf7gWduwfMQq6T_1ZDtCdA@mail.gmail.com>
 <56A0CE45.6010608@redhat.com>
 <CAGb2v66zzbmm_6OjWbFgd0Uq_gUjowRpx2u1akDnUD63OMTuVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60751 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965107AbcAUMjA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jan 2016 07:39:00 -0500
In-Reply-To: <CAGb2v66zzbmm_6OjWbFgd0Uq_gUjowRpx2u1akDnUD63OMTuVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

Hi,

On 21-01-16 13:28, Chen-Yu Tsai wrote:
> On Thu, Jan 21, 2016 at 8:25 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 21-01-16 13:23, Chen-Yu Tsai wrote:
>>>
>>> On Thu, Jan 21, 2016 at 7:16 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 21-01-16 06:26, Chen-Yu Tsai wrote:
>>>>>
>>>>>
>>>>> According to Allwinner, only mmc3 supports 8 bit DDR transfers for eMMC.
>>>>> Switch to mmc3 for the onboard eMMC, and also assign vqmmc for signal
>>>>> voltage sensing/switching, and "cap-mmc-hw-reset" to denote this
>>>>> instance can use eMMC hardware reset.
>>>>
>>>>
>>>>
>>>> This is going to need some more explanation, does this mean
>>>> that the old dtsi is wrong and the emmc does not work there are all ?
>>>
>>>
>>> mmc2 works fine for either 4 bit SDR/DDR or 8 bit SDR only. It does
>>> not work for 8 bit DDR. I actually tested all the above combinations.
>>>
>>> Also see
>>> https://groups.google.com/d/msg/linux-sunxi/pMzwMWwLALw/6WGgCN1eAQAJ
>>>
>>> About old DTs not working:
>>>
>>> a) The old DT will not work with the mmc patches, as it will try 8 bit DDR
>>>      and fail. Also, the old DT does not use the highest drive strength for
>>>      the mmc pins, meaning it might not work for the other chip families.
>>>
>>> b) Old DT + old kernel works fine (8 bit high-speed), just slower.
>>>
>>> An alternative would be to drop MMC_CAP_1_8V_DDR from the driver, and
>>> use the "mmc-ddr-1_8v" DT capability flag at the dtsi or board level.
>>> There's no real way to describe "don't use 8 bit with MMC DDR" in the DT.
>>
>>
>> OK, so what is confusing me, is how can we choose between the emmc being
>> connected to mmc2 resp mmc3, are there dipswitches on the board? Or can both
>> mmc controllers be routed to the outside on the same port/pins ?
>
> They are on the same pins, just with a different mux value/function.
> I believe the previous patch explains this.

Ah yes, I see the remark about them sharing pins in the previous
patch commit msg now, weird.

Regards,

Hans


>
> ChenYu
>
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>>
>>>
>>> Regards
>>> ChenYu
>>>
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>>>> ---
>>>>>     arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 6 ++++--
>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
>>>>> b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
>>>>> index ea69fb8ad4d8..4ec0c8679b2e 100644
>>>>> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
>>>>> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
>>>>> @@ -61,12 +61,14 @@
>>>>>     };
>>>>>
>>>>>     /* eMMC on core board */
>>>>> -&mmc2 {
>>>>> +&mmc3 {
>>>>>           pinctrl-names = "default";
>>>>> -       pinctrl-0 = <&mmc2_8bit_emmc_pins>;
>>>>> +       pinctrl-0 = <&mmc3_8bit_emmc_pins>;
>>>>>           vmmc-supply = <&reg_dcdc1>;
>>>>> +       vqmmc-supply = <&reg_dcdc1>;
>>>>>           bus-width = <8>;
>>>>>           non-removable;
>>>>> +       cap-mmc-hw-reset;
>>>>>           status = "okay";
>>>>>     };
>>>>>
>>>>>
>>>>
>>
