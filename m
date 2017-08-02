From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: mmc: UHS Voltage switch and operating frequency question
Date: Wed, 2 Aug 2017 10:54:06 +0800
Message-ID: <2b79f5e8-2a60-128a-0e24-011e8f4e122f@rock-chips.com>
References: <1501518004.2759.5.camel@baylibre.com>
 <03c65837-6d3c-c822-f505-838e90f34295@rock-chips.com>
 <1501606582.2759.11.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:44888 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751815AbdHBCyS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 22:54:18 -0400
In-Reply-To: <1501606582.2759.11.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

On 2017/8/2 0:56, Jerome Brunet wrote:
> On Tue, 2017-08-01 at 08:38 +0800, Shawn Lin wrote:
>> On 2017/8/1 0:20, Jerome Brunet wrote:
>>> Hi Ulf,
>>>
>>> I am working on adding signal voltage switch callback to the meson mmc
>>> driver.
>>> While testing, I noticed that a few cards fail to exit the busy state after
>>> the
>>> voltage switch.
>>>
>>> After tinkering with the driver a bit, I noticed that increasing the clock
>>> frequency from 400kHz to 1MHz solve the problem. Strange, isn't it ?
>>
> 
> Thanks for your reply Shawn !
> 
>> AFAICT, most of the internal circuit of card is running against the
>> input clock from host. So if you increase your clock, cards will finish
>> thier logic switch faster.
> 
> Yeah that would be my understanding as well
> 
>>   Note that the spec does state that 400KHz is
>> the max freq for indentification mode. But the fact is that almost all
>> cards could accept higher frequecncy.
> 
> Agreed. but I'm not talking about the frequency used during identification.
> The step I'm referring to is after CMD41, during CMD11. After CMD11, the spec

I also notice you said "a few cards fail to exit teh busy state after
the voltage switch". That implies that card didn't finish voltage switch
at all, so it shouldn't argue for increasing the clk as the spec only
say "cmd11 invlokes voltage switching squence. If it is *completed*, the
card enters SDR12(default)." and "Completion of voltage switch sequence
is checked by high level of DAT[3:0]"

So these two cards are probably still in id mode or some un-documented
state, I guess. No hints for that per the spec but you should try to
make sure the behaviour of your contrller follows the whole requirement
of SD spec "4.2.4.2 Timing to Switch Signal Voltage".... especially
to see if your 1.8v is stable within 5ms...


> says that the frequency is up to "default speed or SDR12" so 25Mhz >
> If id mode is limited to 400kHz, it is clearly a different stage.
> 
>>
>> For you issue, please try to hack mmc_set_uhs_voltage to increase the
>> delay there to see if that could solve your problem.
>>
> 
> Ohhh believe me, I did :) however these 2 cards are quite stubborn
> 
>>>
>>> I'm don't know MMC that much but is it possible that some card require a
>>> minimum
>>> operating frequency to enter UHS mode ?
>>>
>>
>> We shoule never give a hypothesis beyond the scope of spec.
> I don't get what you mean ?
> 
>>
>>> The simplified spec (Part 1 - Physical Layer) says that before CMD11, we
>>> should
>>> have had CMD41 (Init Command) . After CMD41, the card should be operating at
>>> Default Speed or SDR12.
>>>
>>> I believe that in both case, the frequency is "up to 25Mhz" ? This would be
>>> the
>>> maximum, but is there a minimum ? 400kHz seems pretty low compared to 25Mhz
>>> ...
>>>
>>
>> 400KHz is good for work unless your IP has limitation for that.
> Ip seems to be fine at 400KHz with every other cards, including uhs ones.
> The 2 "annoying" cards switch to UHS mode fine on a laptop.
> 
> It the combination of the ip and the cards which seems broken, whatever the
> delays I put here and there.
> 
> For a reason I don't understand, increasing the minimal frequency from 400Khz to
> 1MHz make these cards work very nicely.
> 
>>
>>> I hope you will able to shed light on this :)
>>>
>>> Best Regards
>>> jerome
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>>
> 
> 
> 
> 

