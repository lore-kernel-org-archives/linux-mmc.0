From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/8] mmc: omap: Fix DMA configuration to not rely on
 device id
Date: Wed, 27 Nov 2013 13:37:26 -0800
Message-ID: <20131127213726.GB26766@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-3-git-send-email-tony@atomide.com>
 <20131118184723.GR10317@atomide.com>
 <87ioveeo0x.fsf@octavius.laptop.org>
 <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131127225704.208445df2aa7fc5fc6cb5faa@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-mmc@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@bitmer.com> [131127 12:55]:
> Hi Chris
> 
> On Tue, 26 Nov 2013 18:33:50 -0500
> Chris Ball <cjb@laptop.org> wrote:
> 
> > Hi Tony,
> > 
> > On Mon, Nov 18 2013, Tony Lindgren wrote:
> > > We are wrongly relying on device id for the DMA configuration
> > > which can lead to wrong DMA channel being selected.
> > >
> > > Fix the issue by using the standard resources like we should.
> > >
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: linux-mmc@vger.kernel.org
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > Feel free to merge via your tree:
> > 
> > Acked-by: Chris Ball <cjb@laptop.org>
> > 
> Can you enlighten me what's the proper way to get patches to mmc since
> I cannot figure out working methodology from MAINTAINERS file?
> 
> I happened to notice that Tony had this similar patch in linux-omap
> list I sent first time already September to you and linux-mmc (sorry
> linux-omap folks, I didn't want to spam multiple lists):
> 
> http://www.spinics.net/lists/linux-mmc/msg22137.html
> 
> After that I've resend the set a few times including a fix to
> user triggable NULL pointer dereference:
> 
> http://www.spinics.net/lists/linux-mmc/msg22610.html
> 
> I'm fine if mmc patches should go through other subsystems but at least
> it should be documented in MAINTAINERS file.

Bummer, sounds like some duplicate work could have been avoided :(
I suggest resend to Chris and linux-mmc one more time as Chris should
pick up the MMC patches in general.

I've been just trying to get things working in general for v3.13-rc
series for omaps with device tree based booting and patching all over
the place. This is to make it easy for us to just drop the legacy
platform based booting for v3.14 while keeping things working.

Chris, as far as I'm concerned, Aaro and Jarkko are good people to
review and ack the drivers/mmc/omap.c patches, so adding Aaro to
Cc as well.

Regards,

Tony
