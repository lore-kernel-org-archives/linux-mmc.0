From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
Date: Sat, 02 Feb 2013 21:17:04 +0400
Message-ID: <510D4A10.9040404@mvista.com>
References: <510C1D0E.6030401@mvista.com>
	<20130201185820.GE29898@arwen.pp.htv.fi>
	<510C2A47.1090607@mvista.com>
	<20130201205600.GA31762@arwen.pp.htv.fi>
	<20130201213003.GW2637@n2100.arm.linux.org.uk>
	<510C58DF.3010103@mvista.com>
	<20130202004455.GX2637@n2100.arm.linux.org.uk>
	<510C7554.3060800@mvista.com>
	<20130202101851.GY2637@n2100.arm.linux.org.uk>
	<510D3E7E.6000707@mvista.com>
	<20130202164522.GC2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130202164522.GC2637-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
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

On 02-02-2013 20:45, Russell King - ARM Linux wrote:

>>> There are two people on this thread CC list who were also involved or
>>> CC'd on the mails from the thread in 2010...  Tony and Felipe.
>>> Unfortunately, the person who agreed to do the work is no longer in the
>>> land of the living.  Yes I know it's inconvenient for people to die
>>> when they've still got lots of important work to do but that's what can
>>> happen...

>>     Hm... wasn't it David Brownell? He's the only person who I know has
>> died recently who has dealt with DaVinci, MUSB and the releated stuff.

> Actually, it wasn't David who was going to do it - that's where the email
> thread gets messy because the mailer David was using makes no distinction
> in text format between what bits of text make up the original email being
> replied to, and which bits of text are written by David.

    Hm, strange...

> It might have been Felipe; there appears to be an email from Felipe saying
> that as the immediate parent to David's email.  But that's not really the
> point here.  The point is that _someone_ agreed to put the work in, and
> _that_ agreement is what caused the patch to be discarded.

> And, as I've already explained, you brought up the subject of it being
> discarded shortly after, and it got discussed there _again_, and the
> same things were said _again_ by at least two people about it being in
> drivers/dma.

    It wasn't said that somebody concrete was going to work on it. I had to 
explcitly write an email laying all further responsibility on CPPI 4.1 support 
on TI back then.

> But anyway, that's all past history.  What was said back then about it
> being elsewhere in the tree is just as relevant today as it was back
> then.  The only difference is that because that message wasn't received,
> it's now two years later with no progress on that.  And that's got
> *nothing* what so ever to do with me.

    Yes, of course. In my original mail that started the discussion I said 
that we have to wait indefinitely for TI to write the new DMA driver. I just 
wondered wouldn't it be better to use the same approach as for EDMA with 
transitioning to drivers/dma/ step by step.

> I know people like to blame me just because I'm apparantly the focus of
> the blame culture, but really this is getting beyond a joke.

> So, I want an apology from you for your insistance that I'm to blame
> for this.

    OK, I apologise if you consider yourself the target of my blame. My aim 
was rather to establish the truth about that decision taken back in Dec 2010 
-- which we seem to have achieved.

> Moreover, _I_ want to know what is going to happen in the
> future with this so that I don't end up being blamed anymore for the
> lack of progress on this issue.

    Nothing. My blame for the lack of progress has long been laid on TI, after 
I explictly passed the responsibility for the driver to them. My intent with 
the mail that started the discussion was to probe whether we still have 
another opportunity of having MUSB DMA support for OMAP-L1x and Sitara. I just 
thought that you might have changed your mind somehow on the matter.

WBR, Sergei


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_jan
