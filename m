From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: core: add support for hardware reset gpio line
Date: Thu, 29 Jan 2015 10:15:52 +0100
Message-ID: <54C9FA48.5050705@samsung.com>
References: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
 <1422453595-21160-2-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFpowidghwadJS+gYP0EVo6gRUhAG8s14CMEbwatFadP2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAPDyKFpowidghwadJS+gYP0EVo6gRUhAG8s14CMEbwatFadP2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tobias Jakobi <liquid.acid-hi6Y0CQ0nG0@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

On 2015-01-28 15:24, Ulf Hansson wrote:
> On 28 January 2015 at 14:59, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> There are boards (like Hardkernel's Odroid boards) on which eMMC card's
>> reset line is connected to GPIO line instead of the hardware reset
>> logic. In case of such boards, if first stage of bootloader is loaded
>> from such eMMC card, before performing system reboot, additional reset
>> of eMMC card is required to properly boot the whole system again. This
>> patch adds code for handling reset gpio lines defined in device tree.
>
> I don't follow the above sequence. Can you try to elaborate and
> describe for what exact scenario we require the hardware reset to be
> done?

Odroid boards uses multi stage bootloaders. The very first stage is in 
SoC ROM.
That code loads next stages (called bl1, bl2, tz) from either eMMC or SD 
card
(depending on jumper configuration or some card detect pins). This ROM 
code is
very simple and assumes that the mmc card has been reset to the default
configuration. However, eMMC card is not being reset by the board 
'reboot' logic.
Instead the nreset line from emmc card is connected to gpio line of SoC. 
Thus to
perform full system reboot procedure, before triggering reboot inside 
the SoC,
one need to manually toggle nreset line of this emmc card to 'zero' for 
a while.
Only then the card is put back to the default state, so ROM code is able 
to read
bootloaders from it.

My patch adds code for managing gpio line connected to nreset signal of 
emmc card.
It registers reset handler, which is being triggered from Linux reboot 
code. This
handler toggles such gpio line before the final reboot is triggered. My 
patch also
provides a function for registering as a mmc host hw_reset callback, so 
it can be
used to reset mmc card before initializing it with kernel driver (this 
is already
implemented), which also might help to get it working if broken 
bootloader left
the emmc card in some unknown/broken state (already observed such issue, 
but it
has been fixed finally by patching bootloader).


> Also, I wonder whether we could extend the mmc-pwrseq to cover your
> case? Did you consider that as an option?

I didn't consider mmc-pwrseq yet. For me it looked straightforward to 
implement
it just like card detect or write-protection gpio pins. I already 
noticed that
there is code for some mmc host driver, which perform mmc hardware 
reset. If you
think that extending pwrseq is the better approach, I will try to update my
patches. This will add reboot handler to mmc-pwrseq then. The only 
question is
weather to use it always when mmc-pwrseq has been enabled or only if some
additional property like 'reset-on-reboot' has been provided.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
