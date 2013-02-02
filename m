From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Sun, 03 Feb 2013 00:18:26 +0400
Message-ID: <510D7492.5090202@mvista.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
	<1359742975-10421-2-git-send-email-mporter@ti.com>
	<5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
	<20130201184915.GP2244@beef>
	<2077c13e12314dc3adc8e5b653855da0@DFLE72.ent.ti.com>
	<20130201185959.GQ2244@beef>
	<e9be6668da8b4372a04687847daa1d8c@DFLE72.ent.ti.com>
	<20130202180747.GS2244@beef>
	<3245316d7aa94b2e823f98b69497547d@DLEE74.ent.ti.com>
	<20130202195548.GU2244@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130202195548.GU2244@beef>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02-02-2013 23:55, Matt Porter wrote:

>>>>>>>>> Move mach-davinci/dma.c to common/edma.c so it can be used
>>>>>>>>> by OMAP (specifically AM33xx) as well.

>>>>>>>> I think this should rather go to drivers/dma/?

>>>>>>> No, this is the private EDMA API. It's the analogous thing to
>>>>>>> the private OMAP dma API that is in plat-omap/dma.c. The actual
>>>>>>> dmaengine driver is in drivers/dma/edma.c as a wrapper around
>>>>>>> this...same way OMAP DMA engine conversion is being done.

>>>>>>      Keeps me wondering why we couldn't have the same with CPPI 4.1 when I proposed
>>>>>> that, instead of waiting indefinitely for TI to convert it to drivers/dma/
>>>>>> directly. We could have working MUSB DMA on OMAP-L1x/Sitara all this time... Sigh.

>>>>> That is a shame. Yeah, I've pointed out that I was doing this exactly
>>>>> the same way as was acceptable for the OMAP DMA conversion since it was
>>>>> in RFC. The reasons are sound since in both cases, we have many drivers
>>>>> to convert that need to continue using the private DMA APIs.

>>>>       In case of CPPI 4.1, we'd only have to convert MUSB DMA driver. Other
>>>> in-tree CPPI 4.1 having SoCs don't use it for anything but MUSB -- it even is
>>>> sub-block of their MUSB device, AFAIK (I maybe wrong about Sitaras -- I don't
>>>> know them well).

>>> Well, it's pretty clear to me now that there's good reason for it not
>>> landing in arch/arm/ so the obvious path is to do the dmaengine
>>> conversion and put it in drivers/dma/ if it's really a generic dma engine.
>>> I'm not sure why you express concern over the dma engine api not fitting
>>> with CPPI 4.1?

>>      It's not a DMA controller only, it's 3 distinct devices, with the DMA
>> controller being one among them and using another one, the queue manager, as
>> some sort of proxy. The third device doesn't exist on OMAP-L1x SoCs -- it's
>> the buffer manager.

> Interesting, and you don't see a way to have this split between
> dmaengine and the musb driver?

    This can't be split into the MUSB DMA driver, as the neither of CPPI 4.1 
devices are really MUSB specific. The support should be generic.

> This all assumes there's even a match as
> RMK did raise concerns elsewhere in this thread.

    Didn't quite get this sentence.

>>> If it doesn't work, work with Vinod to fix the api. It's
>>> expected, I'm working on dmaengine API changes right now to deal with a
>>> limitation of EDMA that needs to be abstracted.

>>      Sorry, now it's TI's task. I no longer have time to work on this (my
>> internal project to push OMAP-L1x support upstream has expired at Sep 2010)

    If not somewhat earlier... anyway, I wasn't able to spent much time on 
this project in 2010.

>> and my future in MV is very uncertain at this moment. Most probably I'll leave
>> it (or be forced to leave).

> Too bad, it's certainly "somebody's task". The people employed by TI
> have names too. ;) I suspect it falls to Felipe or Kishon these days,
> but I try to avoid USB as it's generally a source of pain.

    I'm probably masochistic then since I'm still sending MUSB patches, eben 
though I wasn't working on it at MV until I switched to Kontron boards 2 weeks 
ago. Now my task is fixing USB bugs on real Sitara with dual MUSB. :-)

>>> As pointed out, edma.c is already here in arch/arm/, so moving it doesn't
>>> add something new. It does let us regression test all platforms that use it
>>> (both Davinci and AM33xx) as I go through the conversion process.

>>      Could have been the same with CPPI 4.1 in theory if it was added to
>> mach-davinci/ back in 2009... we'd then only have to move it. EDMA code is

    I don't know why Kevin didn't merge it then. I remembere he didn't like 
that it was not a proper platform driver and was tied with the platform code 
thru some variables, and I refused to change that...

>> much older of course, so it's probably more justified.

> Absolutely, timing is everything. I can assure you I've flamed enough
> people "internally" about leaving this EDMA dmaengine conversion for so
> long. As you might have guessed, AM33xx is a bit of a driver for it, but
> all of this would have been quite a bit simpler had somebody taken a
> little effort and moved edma to dmaengine years ago when slave dma
> support was added to dmaengine. ;)

    Hm, it seems to have happened back in 2008 when I was working on CPPI 4.1 
code. Too bad I only knew that drivers/dma/ are for accelerating RAIDs back 
then (if actually noot later than that).
    TI seems to put more efforts into its Arago project than in supoporting 
the cutting edge (or not) CPUs in mainline -- at lest things seem go there 
first. Many Arago patches never reached mainline (not that they can be applied 
without cleanup though).

> -Matt

WBR, Sergei


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
