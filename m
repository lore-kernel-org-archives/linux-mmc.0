From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH 1/4] mmc: tmio: Implement SDIO IRQ
Date: Mon, 20 Dec 2010 16:51:45 +0100
Message-ID: <4D0F7B91.10604@arndnet.de>
References: <1291656942-18100-1-git-send-email-arnd@arndnet.de>	<AANLkTimHqoHzO8-5mdTiB03sp_mB0Ose6enOXsTvT5R+@mail.gmail.com>	<4CFE26FE.2070206@arndnet.de>	<AANLkTinzGuZjyqLqKJEz6t_CShBUfusobAs-8Md=ix4E@mail.gmail.com>	<4CFE4DD3.8050302@arndnet.de>	<AANLkTikukY6t-4tLTtYhG1=zEfegD4WpictkxBryhHaK@mail.gmail.com> <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:59581 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757931Ab0LTPvv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Dec 2010 10:51:51 -0500
In-Reply-To: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Magnus,

Am 20.12.2010 04:58, schrieb Magnus Damm:
> Hi again Arnd,
> 
> On Wed, Dec 15, 2010 at 12:44 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Wed, Dec 8, 2010 at 12:08 AM, Arnd Hannemann <arnd@arndnet.de> wrote:
>>> Am 07.12.2010 09:37, schrieb Magnus Damm:
>>>> On Tue, Dec 7, 2010 at 9:22 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
>>>>> Am 07.12.2010 00:39, schrieb Magnus Damm:
>>>>>> On Tue, Dec 7, 2010 at 2:35 AM, Arnd Hannemann <arnd@arndnet.de> wrote:
>>>>>>> This patch implements SDIO IRQ support for mfds which
>>>>>>> announce the MMC_CAP_SDIO_IRQ capability for tmio_mmc.
>>>>>>> Tested with a b43-based wireless SDIO card and sh_mobile_sdhi.
>>>>>>>
>>>>>>> This patch applies on top of:
>>>>>>> mmc: tmio_mmc: allow multi-element scatter-gather lists
>>>>>>> mmc: tmio_mmc: fix PIO fallback on DMA descriptor allocation failure
>>>>>>> mmc: tmio: merge the private header into the driver
>>>>>>> mmc: tmio: implement a bounce buffer for unaligned DMA
>>>>>>>
>>>>>>> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
>>>>>>> CC: Ian Molton <ian@mnementh.co.uk>
>>>>>>> CC: Samuel Ortiz <sameo@linux.intel.com>
>>>>>>> CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>>>>>> ---
>>>>>>>  drivers/mmc/host/tmio_mmc.c |   54 ++++++++++++++++++++++++++++++++++++++++++-
>>>>>>>  1 files changed, 53 insertions(+), 1 deletions(-)
>>>>>>
> 
>>>> I'll try to find my AR6002 card, maybe that will shed some light...
>>>
>>> Yeah, that would be really cool.
>>
>> I'll try again next time I have a bit of time to spare. =)
> 
> Alright, now my AR6002-based card is working with your patches. At
> least it seems to be working - my antenna cable is broken so I can
> unfortunately not do any more proper than a simple "iwlist wlan0
> scan". Good thing is that the SDIO IRQ mode and polling mode seem to
> behave about the same.
> 
> Please note that I did not test using the upstream driver. I couldn't
> get that one working last week, so today I reverted to using my last
> known working configuration - the out-of-tree "ar69_sdk" driver
> pointed out by the following instructions:
> http://armin762.wordpress.com/2010/05/24/nvidia-tegra2-getting-wifiatheros-6002-working/

Thanks for testing!

> 
> Anyway, I'm all for including your SDIO IRQ patches, but I think that
> they should be reworked a bit.
> 
> I propose using two flags:
> 
> 1) A hardware-has-sdio-irq-support flag for include/linux/mfd/tmio.h,
> perhaps TMIO_MMC_SDIO_IRQre
> 
> The SDIO IRQ hardware registers are only touched when tmio-mmc is
> provided the TMIO_MMC_SDIO_IRQ flag. The default behavior would be to
> mask the SDIO IRQ interrupt source regardless of the MMC_CAP_SDIO_IRQ
> flag. This should allow us to always enable the SDIO IRQ interrupt
> source in INTC. The SDIO driver should set the TMIO_MMC_SDIO_IRQ flag
> to show that SDHI is known to support SDIO IRQ.
> 
> Hopefully this TMIO_MMC_SDIO_IRQ flag will make it easier for Ian to
> review the code and see that it doesn't break any other platforms that
> may or may not lack SDIO IRQ support.
> 
> 2) The regular MMC_CAP_SDIO_IRQ flag.
> 
> This is enabled per board. If the SDIO IRQ feature doesn't work in
> some case then the system integrator can simply just simply go back to
> polled mode by not setting MMC_CAP_SIDO_IRQ.
> 
> I'm not sure if we can keep the SDIO IRQ interrupt source constantly
> enabled in INTC though. Your current patches require the board
> specific MMC_CAP_SDIO_IRQ flag to be paired with the cpu-specific INTC
> enable change. If someone wishes tho disable SDIO_IRQ support for
> their board then they must know that they also need to revert the INTC
> enable bits, otherwise they'll get endless interrupts when the
> tmio-mmc driver starts. I believe the two-flag approach above will
> solve this problem.

This makes sense, I'll shortly post a revised patchset implementing
your idea...

Thanks,
Arnd
