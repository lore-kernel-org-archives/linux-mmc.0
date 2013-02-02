From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Sat, 02 Feb 2013 21:02:24 +0400
Message-ID: <510D46A0.5060506@mvista.com>
References: <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<510C58DF.3010103@mvista.com>
	<20130202004455.GX2637@n2100.arm.linux.org.uk>
	<510C7554.3060800@mvista.com>
	<20130202101851.GY2637@n2100.arm.linux.org.uk>
	<20130202121738.GZ2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130202121738.GZ2637-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02-02-2013 16:17, Russell King - ARM Linux wrote:

>>>>>>>>> good point, do you wanna send some patches ?

>>>>>>>>       I have already sent them countless times and even stuck CPPI 4.1 support (in
>>>>>>>> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
>>>>>>>> patch. :-(

>>>>>>> sticking into arch/arm/common/ wasn't a nice move. But then again, so
>>>>>>> wasn't asking for the patch to be removed :-s

>>>>>> Err, patches don't get removed, they get moved to 'discarded'.

>>>>>      Any chance to bring it back to life? :-)
>>>>>      Although... drivers/usb/musb/cppi41.c would need to be somewhat
>>>>> reworked for at least AM35x and I don't have time. But that may change,
>>>>> of course.

>>>> Right, I've just looked back at the various meeting minutes from December
>>>> 2010 when the CPPI stuff was discussed.  Yes, I archive these things and
>>>> all email discussions for referencing in cases like this.

>>>     Thanks.

    Thanks again for taking your time to rummage thru the mail archives. I 
also did it, however not thru all threads (it turned out that the placement of 
CPPI 4.1 code was discussed also in the MUSB DMA driver related threads). 
Anyway, I was not a position to do extensive searching as it was already dead 
of the night in Moscow.

>>>> Unfortunately, they do not contain any useful information other than the
>>>> topic having been brought up.  At that point, the CPPI stuff was in
>>>> mach-davinci, and I had suggested moving it into drivers/dma.

>>>     I don't remember that, probably was out of the loop again.

> Here you go - this goes back even _further_ - November 2009 - on the
> mailing list.  The entire thread:

> http://lists.arm.linux.org.uk/lurker/thread/20091102.105759.a54cf3f5.en.html

> And selected emails from it:

> http://lists.arm.linux.org.uk/lurker/message/20091102.103706.38c029b5.en.html
> On Mon, Nov 02, 2009 at 10:37:06AM +0000, I wrote:
> | On Mon, Nov 02, 2009 at 04:27:59PM +0530, Gupta, Ajay Kumar wrote:
> | > Another option is to create arch/arm/ti-common to place all TI platform's
> | > common software, such as CPPI4.1 used both in DA8xx and AM3517.
> |
> | No thanks.  I really don't see why we should allow TI to have yet more
> | directories scattered throughout the tree that are out of place with
> | existing conventions.
> |
> | And what is this CPPI thing anyway?
> |
> | http://acronyms.thefreedictionary.com/CPPI
> |
> | "Communications Port Programming Interface" seems to be about the best
> | applicable one from that list!
> |
> | If it's a USB DMA device (from the patches I can find, that seems to be
> | the case) then why can't it live in drivers/usb or drivers/dma ?

> And again:

> http://lists.arm.linux.org.uk/lurker/message/20091102.115458.61cde450.en.html
> On Mon, Nov 02, 2009 at 11:54:58AM +0000, I wrote:
> | On Mon, Nov 02, 2009 at 04:27:59PM +0530, Gupta, Ajay Kumar wrote:
> | > CPPI4.1 DMA engine can be used either by USB or by Ethernet interface though
> | > currently only USB is using it but in future even Ethernet devices may use it.
> |
> | drivers/dma does seem to be the right place for this.

> http://lists.arm.linux.org.uk/lurker/message/20091102.110217.adec3ca7.en.html
> Even Felipe Balbi said so:
> | you might want to provide support for it via drivers/dma and for the
> | musb stuff, you just add the wrappers musb uses. See how tusb6010_omap.c
> | uses OMAP's system dma which is also used by any other driver which
> | requests a dma channel.

> And it seems that _YOU_ did get the message - see your quoted text in:
> http://lists.arm.linux.org.uk/lurker/message/20091230.132240.ecd56b3d.en.html
>> We're currently having it there but the matter is it should be shred
>> between different platforms, so arch/arm/common/ seems like the right
>> place (which Russell didn't like, suggesting ill suited for that
>> drivers/dma/ instead).

> See - you acknowledge here that I don't like it.  So you _KNOW_ my views
> on it in December 2009, contary to what you're saying in this thread.

    OK, now it seems I misremembered.

> Yet, you persisted with putting it in arch/arm/common:

    Being unable to fit it into drivers/dma/, and loating to place it into 
drivers/usb/, I had no other option. :-)

> http://lists.arm.linux.org.uk/lurker/message/20100515.181453.472c7c10.en.html
> | Changes since the previous version:
> | - moved everything from arch/arm/mach-davinci/ to arch/arm/common/;
> | - s/CONFIG_CPPI41/CONFIG_TI_CPPI41/, made that option invisible;
> | - added #include <linux/slab.h> for kzalloc();
> | - switched alloc_queue() and cppi41_queue_free() to using bit operations;
> | - replaced 'static' linking_ram[] by local variable in cppi41_queue_mgr_init();
> | - fixed pr_debug() in cppi41_dma_ctrlr_init() to print the real queue manager #.

> So, see, I had already objected to it being in arch/arm well before
> you stuck your patch into the patch system.  And somehow you think
> that ignoring my previous comments and doing it anyway will result in
> progress?

    I probably did that out of hopelessness partly.

> So, let's recap.  The timeline behind this is:

> + 2 Nov 2009: Question asked about putting it in arch/arm/ti-common
>    + I responded saying a clear no to that, suggesting other locations
>      all of which were outside arch/arm.
>    + I responded again saying an hour or two later saying the same thing.
>    + Felipe Balbi agreed with drivers/dma.
> + 15 May 2010: v5 posted with it in arch/arm/common
> + 06 Aug 2010: put into patch system sa 6305/1
> + 06 Dec 2010: TI meeting.
>    + Pre-meeting notes show that my views on this are known:
>      + I'll quote this from it: "Russell suggested to move the driver at
>        drivers/dma/".
>      + Raises concern that DMA engine API may not fit.
>    + I respond to that concern as work has been done on the DMA engine API
>      to improve the slave mode support recently as a result of Linus Walleij's
>      work on AMBA PL08x DMA support.
>      (I would _not_ have done so if I had changed my view about it being
>       under drivers/dma/).

    Unfortunately, as I see it, that work is far from enough for CPPI 4.1.
I maybe don't know drivers/dma/ slave mode well, but adding CPPI 4.1 support 
would have required a complete redesign of all related interfaces.

> + 07 Dec 2010: emails talking about moving MUSB over to DMA engine API
>    so that MUSB should not care about its DMA backend (that being CPPI
>    or some other one.)

    As we know, it was a bad idea generally.

>    + Email with "Let's see if I can get it all done by 2.6.39."

    Didn't ever see that one.

> + 08 Dec 2010: patch 6305/1 discarded from the patch system as there now
>    seems to be concensus on the issue.
> + 03 Jan 2011: you ask me why it was discarded
>    http://lists.arm.linux.org.uk/lurker/thread/20110103.160610.8cbe8e7d.en.html
>    + I respond "It may have been that it's inventing its own API rather
>      than using something like the DMA engine API."
>    + Ajay said: "This issue was discussed recently at TI and proposal was
>      to place it to drivers/dma folder. Moreover, even Felipe also seems
>      to move other musb DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma."

> Oh, and then we come to this interesting email from Felipe to you, in
> response to your reluctance to put it in drivers/dma.

    It was in reposnse to Ajay's email about Felipe's assumed intent to switch 
MUSB to drivers/dma/ API insted of its custom DMA API, AFAIR. To which I, of 
course, started to object. It wasn't about CPPI 4.1 driver at all.

> | Do I really have to spell it out ? Really ?
> |
> | You don't need to physically move the part of the code to drivers/dma,
> | but it has to use the API. The mentor DMA is internal to MUSB.
> | tusb6010_omap.c isn't.
> |
> | Where it makes sense to move the code under drivers/dma, it will be
> | done, where it doesn't, it won't be done, but it will use the same API.
> | That's all.
> |
> | The end goal is just to drop all these ad-hoc "APIs" for accessing DMA
> | on musb code.

    Now I don't even quite understand what (multiple?) ad-hoc APIs Felipe had 
in mind. There\ is one and only one DMA API in MUSB. Perhaps he meant the 
tusb6010_omap.c driver which is using OMAP DMA API?

> See the common theme here?  I don't like it under arch/arm.  I've been
> pretty _consistent_ in suggesting drivers/dma/ all through that...
> Others have said it.  People even acknowledge that's what I've been
> saying, people who were not in the original discussion.

> What I think is this: it is _YOU_ who don't want to hear that message,
> so _YOU_ are intentionally ignoring it, and _YOU_ are looking for
> someone to blame for it.  You've decided I'm to blame because _YOU_
> aren't listening.

    My intent wasn't to lay blame on anybody, just to restore the sequence of 
events which passed completely around me.

> The reason there hasn't been any progress on this is _NOT_ down to me.
> I've provided my feedback, and promptly been ignored.  Others have told
> you the same thing, and promptly been ignored.  Sorry, this is not my
> problem.  This is entirely YOUR problem, one of your own making.

   I didn't really ignore requests to move to drivers/dma/, I just honestly 
didn't see how it can be done, and frankly didnt have much time to massively 
rewrite my stuff written back in 2008 based on earlier TI work. Then my 
project to push OMAP-L137 support simply ended (I can't restore the date now, 
perhaps this was somewhere in 2010), so I simply couldn't continue to invest 
big efforts in this work.

> But whatever.  We are NOT going to put CPPI under arch/arm.  Not now that
> during the last merge window Linus complained to Arnd about the amount of
> code coming through for arch/arm _AGAIN_.  Not after last time Linus
> complained about TI OMAP which prompted the creation of arm-soc.  AND THAT
> IS *FINAL*.  CPPI DMA SUPPORT IS *NOT* GOING UNDER ARCH/ARM.  PERIOD.  NOT
> GOING TO HAPPEN.

> Is this clear enough yet, or how many more years of emails do you need
> yet more emails to get this message through?

    It's crystal clear, thank you. I just thought something might have changed 
seeing how EDMA support moves to arch/arm/common/. Now I see it's not.

WBR, Sergei


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
