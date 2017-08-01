From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: mmc: UHS Voltage switch and operating frequency question
Date: Tue, 1 Aug 2017 08:38:16 +0800
Message-ID: <03c65837-6d3c-c822-f505-838e90f34295@rock-chips.com>
References: <1501518004.2759.5.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:45292 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdHAAia (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2017 20:38:30 -0400
In-Reply-To: <1501518004.2759.5.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>


On 2017/8/1 0:20, Jerome Brunet wrote:
> Hi Ulf,
> 
> I am working on adding signal voltage switch callback to the meson mmc driver.
> While testing, I noticed that a few cards fail to exit the busy state after the
> voltage switch.
> 
> After tinkering with the driver a bit, I noticed that increasing the clock
> frequency from 400kHz to 1MHz solve the problem. Strange, isn't it ?

AFAICT, most of the internal circuit of card is running against the
input clock from host. So if you increase your clock, cards will finish
thier logic switch faster. Note that the spec does state that 400KHz is
the max freq for indentification mode. But the fact is that almost all
cards could accept higher frequecncy.

For you issue, please try to hack mmc_set_uhs_voltage to increase the
delay there to see if that could solve your problem.

> 
> I'm don't know MMC that much but is it possible that some card require a minimum
> operating frequency to enter UHS mode ?
> 

We shoule never give a hypothesis beyond the scope of spec.


> The simplified spec (Part 1 - Physical Layer) says that before CMD11, we should
> have had CMD41 (Init Command) . After CMD41, the card should be operating at
> Default Speed or SDR12.
> 
> I believe that in both case, the frequency is "up to 25Mhz" ? This would be the
> maximum, but is there a minimum ? 400kHz seems pretty low compared to 25Mhz ...
> 

400KHz is good for work unless your IP has limitation for that.

> I hope you will able to shed light on this :)
> 
> Best Regards
> jerome
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

