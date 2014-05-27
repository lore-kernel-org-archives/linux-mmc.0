From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 12/13] mmc: mmci: add explicit clk control
Date: Tue, 27 May 2014 15:14:47 +0100
Message-ID: <53849DD7.1070202@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849578-7585-1-git-send-email-srinivas.kandagatla@linaro.org>	<CAPDyKFqz-O9-Douk96LBuFRD_P1146c_Ld14TgiduBgfBqRi_A@mail.gmail.com>	<5383C28D.1060808@linaro.org>	<CAPDyKFpD==5wMZa5KbcMpGnZMTyncmGZfc=17j0=YjKT8qq5bg@mail.gmail.com>	<5384887F.2060505@linaro.org> <CAPDyKFqy+UW7QHhJfVCefeWTwTzpzLb2APwxQKhAdzM6Ex_ZrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqy+UW7QHhJfVCefeWTwTzpzLb2APwxQKhAdzM6Ex_ZrQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org



On 27/05/14 15:07, Ulf Hansson wrote:
>>> Hmm. Looking a bit deeper into this, we have some additional related
>>> code to fixup. :-)
>>>
>>> In ->probe(), we do clk_set_rate(100MHz), if the mclk > 100MHz. That's
>>> due to the current variants don't support higher frequency than this.
>>> It seems like the Qcom variant may support up to 208MHz? Now, if
>>> that's the case, we need to add "f_max" to the struct variant_data to
>>> store this information, so we can respect different values while doing
>>> clk_set_rate() at ->probe().
>>>
>> Yes, qcom SOCs support more than 100Hhz clock.
>>
>> Probe and clk_set_rate/set_ios should respect this.
>>
>> On the other thought, Should probe actually care about clocks which are
>> explicitly controlled? It should not even attempt to set any frequency to
>> start with.
>
> The 100 MHz is related to constraints set by the specification of the
> IP block, not the MMC/SD/SDIO spec.
>
> Thus at ->probe() we must perform the clk_set_rate().
I agree its valid for controllers which have this constraints.

>
>> mmc-core would set the right frequency depending on the mmc
>> state-machine respecting f_min and f_max.
>> I think for qcom, probe should just check the if f_max and f_min are valid
>> and set them to defaults if any in the same lines as existing code.
>>
>>
>>> While updating mmc->f_max for host->variant->explicit_mclk_control, we
>>> shouldn't care about using the host->mclk as a limiter, instead, use
>>> min(mmc->f_max, host->variant->f_max) and fallback to fmax.
>>>
>> Yes, that's correct, mclk should not be used as limiter. Adding f_max to the
>> variant looks useful.
>>
>>
>>> Not sure how that will affect the logic. :-)
>>>
>>>>
>>>>
>>>>> Additionally, this makes me wonder about f_min. I haven't seen
>>>>> anywhere in this patch were that value is being set to proper value,
>>>>> right?
>>>>>
>>>>
>>>> f_min should be 400000 for qcom, I think with the default mclk frequency
>>>> and
>>>> a divider of 512 used for calculating the f_min is bringing down the
>>>> f_min
>>>> to lessthan 400Kz. Which is why its working fine.
>>>> I think the possibility of mclk default frequency being greater than
>>>> 208Mhz
>>>> is very less. so I could either leave it as it is Or force this to 400000
>>>> all the time for qcom chips.
>>>
>>>
>>> No, this seems like a wrong approach.
>>>
>>> I think you would like to do use the clk_round_rate() find out the
>>> lowest possible rate. Or just use a fixed fallback value somehow.
>>
>>
>> clk_round_rate(mclk, 0) might be more generic, instead of fixed fallback.
>> Let the mmc-core figure out what frequency would be best from its table
>> starting from f_min.
>
> Agree!
>
> clk_round_rate(mclk, 100KHz), might be better though - since that is
> actually the lowest request frequency whatsoever.
>
Perfect.

--srini
> Kind regards
> Ulf Hansson
>
