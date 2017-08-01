From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: mmc: UHS Voltage switch and operating frequency question
Date: Tue, 01 Aug 2017 18:56:22 +0200
Message-ID: <1501606582.2759.11.camel@baylibre.com>
References: <1501518004.2759.5.camel@baylibre.com>
         <03c65837-6d3c-c822-f505-838e90f34295@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35162 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdHAQ4Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Aug 2017 12:56:24 -0400
Received: by mail-wm0-f49.google.com with SMTP id m85so20367133wma.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Aug 2017 09:56:24 -0700 (PDT)
In-Reply-To: <03c65837-6d3c-c822-f505-838e90f34295@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

On Tue, 2017-08-01 at 08:38 +0800, Shawn Lin wrote:
> On 2017/8/1 0:20, Jerome Brunet wrote:
> > Hi Ulf,
> > 
> > I am working on adding signal voltage switch callback to the meson mmc
> > driver.
> > While testing, I noticed that a few cards fail to exit the busy state after
> > the
> > voltage switch.
> > 
> > After tinkering with the driver a bit, I noticed that increasing the clock
> > frequency from 400kHz to 1MHz solve the problem. Strange, isn't it ?
> 

Thanks for your reply Shawn !

> AFAICT, most of the internal circuit of card is running against the
> input clock from host. So if you increase your clock, cards will finish
> thier logic switch faster.

Yeah that would be my understanding as well

>  Note that the spec does state that 400KHz is
> the max freq for indentification mode. But the fact is that almost all
> cards could accept higher frequecncy.

Agreed. but I'm not talking about the frequency used during identification.
The step I'm referring to is after CMD41, during CMD11. After CMD11, the spec
says that the frequency is up to "default speed or SDR12" so 25Mhz. 

If id mode is limited to 400kHz, it is clearly a different stage.

> 
> For you issue, please try to hack mmc_set_uhs_voltage to increase the
> delay there to see if that could solve your problem.
> 

Ohhh believe me, I did :) however these 2 cards are quite stubborn 

> > 
> > I'm don't know MMC that much but is it possible that some card require a
> > minimum
> > operating frequency to enter UHS mode ?
> > 
> 
> We shoule never give a hypothesis beyond the scope of spec.
I don't get what you mean ? 

> 
> > The simplified spec (Part 1 - Physical Layer) says that before CMD11, we
> > should
> > have had CMD41 (Init Command) . After CMD41, the card should be operating at
> > Default Speed or SDR12.
> > 
> > I believe that in both case, the frequency is "up to 25Mhz" ? This would be
> > the
> > maximum, but is there a minimum ? 400kHz seems pretty low compared to 25Mhz
> > ...
> > 
> 
> 400KHz is good for work unless your IP has limitation for that.
Ip seems to be fine at 400KHz with every other cards, including uhs ones.
The 2 "annoying" cards switch to UHS mode fine on a laptop.

It the combination of the ip and the cards which seems broken, whatever the
delays I put here and there.

For a reason I don't understand, increasing the minimal frequency from 400Khz to
1MHz make these cards work very nicely.

> 
> > I hope you will able to shed light on this :)
> > 
> > Best Regards
> > jerome
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> > 
> 
> 

