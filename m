From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH 1/4] mmc: tmio: Implement SDIO IRQ
Date: Tue, 07 Dec 2010 10:08:03 -0500
Message-ID: <4CFE4DD3.8050302@arndnet.de>
References: <1291656942-18100-1-git-send-email-arnd@arndnet.de>	<AANLkTimHqoHzO8-5mdTiB03sp_mB0Ose6enOXsTvT5R+@mail.gmail.com>	<4CFE26FE.2070206@arndnet.de> <AANLkTinzGuZjyqLqKJEz6t_CShBUfusobAs-8Md=ix4E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:40769 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752863Ab0LGPIO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Dec 2010 10:08:14 -0500
In-Reply-To: <AANLkTinzGuZjyqLqKJEz6t_CShBUfusobAs-8Md=ix4E@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Magnus,

Am 07.12.2010 09:37, schrieb Magnus Damm:
> On Tue, Dec 7, 2010 at 9:22 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
>> Am 07.12.2010 00:39, schrieb Magnus Damm:
>>> On Tue, Dec 7, 2010 at 2:35 AM, Arnd Hannemann <arnd@arndnet.de> wrote:
>>>> This patch implements SDIO IRQ support for mfds which
>>>> announce the MMC_CAP_SDIO_IRQ capability for tmio_mmc.
>>>> Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.
>>>>
>>>> This patch applies on top of:
>>>> mmc: tmio_mmc: allow multi-element scatter-gather lists
>>>> mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
>>>> mmc: tmio: merge the private header into the driver
>>>> mmc: tmio: implement a bounce buffer for unaligned DMA
>>>>
>>>> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
>>>> CC: Ian Molton <ian@mnementh.co.uk>
>>>> CC: Samuel Ortiz <sameo@linux.intel.com>
>>>> CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>>> ---
>>>>  drivers/mmc/host/tmio_mmc.c |   54 ++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 files changed, 53 insertions(+), 1 deletions(-)
>>>
>>> Thanks for your work on this!
>>>
>>> Just curious, did you test this change in 4-bit mode and/or 1-bit
>>> mode? I believe that 1-bit mode support is rather simple, but 4-bit
>>> mode requires toggling between the IRQ and DATA function which happen
>>> to be using the same pin. It looks like the current code only deals
>>> with 1-bit mode - perhaps 4-bit mode isn't supported by the b43
>>> driver?
>>
>> Yes, I tested this in 1-bit and 4-bit mode. At least the card claims it is using it,
>> it says "width=2". I also read about the toggling, and expected to do
>> something fancy, but when tests where successful I came to the conclusion
>> that the controller does the toggling for us. Do you believe otherwise?
> 
> Yes, I believe something more advanced is needed for 4-bit mode. But I
> don't really have any proof. I just know that I spent quite some time
> trying to get it to work and ended up staying in polling mode because
> enabling real IRQs seemed to require too much time. This was before
> some interrupt ack fixes so things may have improved since then. I
> also remember both testing on b43 hardware and AR6002.

There was also this nasty DMA issue Guennadi fixed recently...

> 
> There are a couple of things against us at this point:
> 
> a) b43 hardware may not be enough to test this

Ok, do you still have that AR6002 and could test with that by any chance?

> are you really sure 4-bit mode is enabled? =)
> is the b43 driver doing multi-block data transfers? i believe IRQs
> work differently for multi-block data transfers and single-block.

I'm pretty sure its using 4-bit mode, from the probe of the card:

mmc1: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 25000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc1: clock 25000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 2 timing 0

Its doing probably not doing any multi-block data transfers, but I'll
recheck. Actually most data transfers are very small.
 
> b) we don't have any public data sheet for the SDHI hardware block
> 
> how good is that?
> 
> c) the simplified SDIO spec is not exactly full of details:
> 
> 8.1.3
> Interrupt Period Definition
> This section is not included in the Simplified Specification.
> 8.1.4
> Interrupt Period at the Data Block Gap in 4-bit SD Mode (Optional)
> This section is not included in the Simplified Specification.
> 8.1.5
> Inhibited Interrupts (Removed Section)
> This section is not included in the Simplified Specification.
> 8.1.6
> End of Interrupt Cycles
> This section is not included in the Simplified Specification.

Yes I read this too, but this is of course only interface
between host and card, so we may be just lucky that the controller
hides these details from us.

>>> Not sure how the Linux MMC stack supports 4-bit IRQs, but the S4MI bit
>>> in the CCCR should specify if it's allowed to enable interrupts in
>>> between data transfers or not. Perhaps that is something we need to
>>> deal with in the driver? Or maybe the framework needs to be extended?
>>
>> I quick grep shows that nobody seems to care about this bit until now...
> 
> Yeah, that seems to be the case. I guess it's a non-issue then. =)
> 
> I'll try to find my AR6002 card, maybe that will shed some light...

Yeah, that would be really cool.

Thanks,
Arnd
