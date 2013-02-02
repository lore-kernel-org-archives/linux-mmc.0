From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Sat, 02 Feb 2013 20:27:42 +0400
Message-ID: <510D3E7E.6000707@mvista.com>
References: <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
	<20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<510C58DF.3010103@mvista.com>
	<20130202004455.GX2637@n2100.arm.linux.org.uk>
	<510C7554.3060800@mvista.com>
	<20130202101851.GY2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130202101851.GY2637-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Cousson,
	Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02-02-2013 14:18, Russell King - ARM Linux wrote:

>>>>>> On Fri, Feb 01, 2013 at 11:49:11PM +0300, Sergei Shtylyov wrote:
>>>>>>>> good point, do you wanna send some patches ?

>>>>>>>       I have already sent them countless times and even stuck CPPI 4.1 support (in
>>>>>>> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
>>>>>>> patch. :-(

>>>>>> sticking into arch/arm/common/ wasn't a nice move. But then again, so
>>>>>> wasn't asking for the patch to be removed :-s

>>>>> Err, patches don't get removed, they get moved to 'discarded'.

>>>>      Any chance to bring it back to life? :-)
>>>>      Although... drivers/usb/musb/cppi41.c would need to be somewhat
>>>> reworked for at least AM35x and I don't have time. But that may change,
>>>> of course.

>>> Right, I've just looked back at the various meeting minutes from December
>>> 2010 when the CPPI stuff was discussed.  Yes, I archive these things and
>>> all email discussions for referencing in cases like this.

>>     Thanks.

>>> Unfortunately, they do not contain any useful information other than the
>>> topic having been brought up.  At that point, the CPPI stuff was in
>>> mach-davinci, and I had suggested moving it into drivers/dma.

>>     I don't remember that, probably was out of the loop again.

    I looked back at the history of CPPI 4.1 driver related threads, and found 
that Kevin Hilman gas suggested it too while the driver was in mach-davinci/ 
still...

>>> The result of that was to say that it doesn't fit the DMA engine APIs.

    Right, I tried to fit it (in my thought only though) in and it didn't work 
out.

>>     I remember this as a discussion happening post me sending the patch to
>> the patch system and it being discarded...

    Well, actually before doing this too...

>>> So someone came up with the idea of putting it in arch/arm/common - which

>>     Probably was me.

    No, it was someone from TI.

>> There was also idea of putting it into
>> drivers/usb/musb/ -- which TI indeed followed in its Arago prject. I
>> firmly denied that suggestion.

    Moving it to drivers/usb/ is probably the reason TI has been quite content 
with the situation -- their clients kept receiving MUSB DMA support on both 
OMAP-L1x and then Sitara, so all looked well for them.

>>> I frankly ignored by email (how long have we been saying "no drivers in
>>> arch/arm" ?)

    Well, maybe you should have said it one more time for those who were late 
in the game like me.

>>     But there *are* drivers there! And look at edma.c which is about to be
>> moved there... Anyway, I haven't seen such warnings, probably was too
>> late in the game.

> I've already objected about the header moving to some random place in
> arch/arm/include.  Really, edma.c needs to find another home too - but
> there's a difference here.  edma.c is already present under arch/arm.
> CPPI is _not_.  CPPI is new code appearing under arch/arm (you can see
> that for yourself by looking at the diffstat of 6305/1... it doesn't
> move files, it adds new code.)

    Yes, of course, that's clear.

>>> Now, it would've been discussed in that meeting, but unfortunately no
>>> record exists of that.  What does follow that meeting is a discussion
>>> trail.  From what I can see there, but it looks to me like the decision
>>> was taken to move it to the DMA engine API, and work on sorting out MUSB
>>> was going to commence.

>>> The last email in that says "I'll get to that soon"... and that is also
>>> the final email I have on this topic.  I guess if nothing has happened...
>>> Shrug, that's someone elses problem.

>>     Well, as usual... :-(

>>> Anyway, the answer for putting it in arch/arm/common hasn't changed,
>>> and really, where we are now, post Linus having a moan about the size
>>> of arch/arm, that answer is even more concrete in the negative.  It's
>>> 54K of code which should not be under arch/arm at all.

>>> Anyway, if you need to look at the patch, it's 6305/1.  Typing into the
>>> summary search box 'cppi' found it in one go.

>>     Thanks, I remember this variant was under arch/arm/common/.
>>     Now however, I see what happened to that variant in somewhat different
>> light. Looks like it was entirely your decision to discard the patch,
>> without TI's request...

> Firstly, it is *my* perogative to say no to anything in arch/arm, and I
> really don't have to give reasons for it if I choose to.

    That's clear. You're the ARM King. :-)

> Secondly, it *was* discussed with TI, and the following thread of
> discussion (threaded to the minutes email) shows that *something* was
> going to happen _as a result of that meeting_ to address the problem of
> it being under arch/arm.  And *therefore* it was discarded from the patch
> system - because there was expectation that it was going to get fixed.

> For christ sake, someone even agreed to do it.  Even a target was mentioned,
> of 2.6.39.  That was mentioned on 7th December 2010.  And 6305/1 was
> discarded on 8th December 2010.  Cause and effect.

> And yes, *you* were not part of that discussion.  You work for Montavista
> which contracts with TI to provide this support.

    Here you're not quite correct. TI did not prolongate contgract with MV 
after our releasing the support for OMAP-L137, which is early 2009, AFAIR.

> It is up to TI to pass > stuff like this on to their contractors.

    As you can see, TI didn't feel obliged to do so already.

> There are two people on this thread CC list who were also involved or
> CC'd on the mails from the thread in 2010...  Tony and Felipe.
> Unfortunately, the person who agreed to do the work is no longer in the
> land of the living.  Yes I know it's inconvenient for people to die
> when they've still got lots of important work to do but that's what can
> happen...

    Hm... wasn't it David Brownell? He's the only person who I know has died 
recently who has dealt with DaVinci, MUSB and the releated stuff.

WBR, Sergei


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
