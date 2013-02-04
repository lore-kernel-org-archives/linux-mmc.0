From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Mon, 4 Feb 2013 17:30:51 -0500
Message-ID: <5110369B.9060901@ti.com>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<20130204154153.GA18237@arwen.pp.htv.fi> <510FF1A6.403@mvista.com>
	<20130204164712.GB4269@arwen.pp.htv.fi>
	<510FF5C9.3030600@mvista.com>
	<20130204170216.GC4269@arwen.pp.htv.fi> <51100A72.6030909@ti.com>
	<CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdZihnp3_Df==QRWxQupgi7W_YXZxc-MxkusVH6J+Vx56A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Nair,
	Sandeep" <sandeep_n-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>LinuxLinux
List-Id: linux-mmc@vger.kernel.org

On 02/04/2013 03:29 PM, Linus Walleij wrote:
> On Mon, Feb 4, 2013 at 8:22 PM, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> wrote:
>
>> Based on our experience with fitting multiple subsystems on top of this
>> DMA-Engine driver, I must say that the DMA-Engine interface has proven
>> to be a less than ideal fit for the network driver use case.
>>
>> The first problem is that the DMA-Engine interface expects to "push"
>> completed traffic up into the upper layer as a part of its callback.
>> This doesn't fit cleanly with NAPI, which expects to "pull" completed
>> traffic from below in the NAPI poll.  We've somehow kludged together a
>> solution around this, but it isn't very elegant.
>
> I cannot understand the actual technical problem from the above
> paragraphs though. dmaengine doesn't have a concept of pushing
> nor polling, it basically copies streams of words from A to B, where
> A/B can be a device or a buffer, nothing else.
>

NAPI needs to switch between polled and interrupt driven modes of 
operation.  Further, in a given poll, it needs to be able to limit the 
amount of traffic processed to a specified budget.

> The thing you're looking for sounds more like an adapter on top
> of dmaengine, which can surely be constructed, some
> drivers/dma/dmaengine-napi.c or whatever.
>

I'm not debating the possibility of duct-taping a network driver on top 
of the dma-engine interface.  That is very much doable, and we have done 
this already.

Starting with a stock dma-engine driver, our first approach was to use 
dmaengine_pause() and dmaengine_resume() in the network driver to 
throttle completion callbacks per NAPI's needs.  This worked, but it was 
ugly because the completion callback was now being used in a 
multi-purpose fashion - (a) as an interrupt notifier [to do a 
napi_schedule()], and (b) as a hand over mechanism for completed packets 
[within a napi_poll()].  The network driver needed to maintain a nasty 
little state machine for this, and this ended up being quite non-trivial 
after we'd fixed up most of the issues.

Having learned our lessons from the first attempt, the second step was 
to add a separate notification callback from the dma-engine layer - a 
notification independent of any particular descriptor.  With this 
callback in place, we got rid of some of the state machine crap in the 
network driver.

The third step was to add a dmaengine_poll() call instead of constantly 
bouncing a channel between paused and running states.  This further 
cleaned up some of the network driver code, but now the dma-engine 
driver looks like crap if it needs to support both the traditional and 
new (i.e. notify + poll) modes.  This is where we are at today.

Even with the addition of these extensions, the interaction between the 
network driver and the dma-engine driver is clumsy and involves multiple 
back and forth calls per packet.  This is not elegant, and certainly not 
efficient.  In comparison, the virtqueue interface is a natural fit with 
the network driver, and is free of the aforementioned problems.

[...]
> Surely the way to look up resources cannot be paramount in this
> discussion, I think the real problem must be your specific networking
> usecase, so we need to drill into that.
>

Agreed.  The dma resource to driver binding is certainly a lesser 
problem than the first.  There are a variety of schemes that we could 
cook up here (filter functions, named lookups, etc.).  However, I think 
that these schemes offer advantages when the binding between the dma 
resource and the dma user is somewhat dynamic.

On the other hand, when the binding between a dma resource and user is 
fixed by hardware and/or configuration, the driver model approach works 
better, IMHO.

Thanks
-- Cyril.

------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb
