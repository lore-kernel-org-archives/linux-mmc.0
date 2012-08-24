From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] mmc: host: enable OMAP DMA engine support for omap
	hosts by default
Date: Fri, 24 Aug 2012 11:39:13 +0100
Message-ID: <20120824103913.GB25765@n2100.arm.linux.org.uk>
References: <CAMQu2gzX1d1FQtE3z=cwfA6daDgxJe6UFUaSY0PzGGLQOz_-ZQ@mail.gmail.com> <20120718071039.GI6522@atomide.com> <CANfBPZ97onLov1TwXYaT5A6D5XzXxwpvk+=y09W_9FmcOne4Mw@mail.gmail.com> <CAMQu2gy-U1WmgGOGZ+VyXjZmLem9TEWbq5kR8jzC0qXvqF-=BA@mail.gmail.com> <CAAwP0s2Efuuc7vsX3bZuwz175zUjnmsOV87OcZ06p_eoe4T3Ug@mail.gmail.com> <alpine.DEB.2.01.1208232246530.15831@pmeerw.net> <CAMQu2gyEGPbNEE0ur0wh9RoJKuBe4B5NkQMUafQNWGVLX8t9vg@mail.gmail.com> <alpine.DEB.2.01.1208240942100.21552@pmeerw.net> <20120824094231.GA25765@n2100.arm.linux.org.uk> <CAMQu2gxs0bzNMtxb0LFyFKM9s4M4yXxFpopaBO+Hah3RjhCpLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMQu2gxs0bzNMtxb0LFyFKM9s4M4yXxFpopaBO+Hah3RjhCpLA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Javier Martinez Canillas <martinez.javier@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 24, 2012 at 03:51:26PM +0530, Shilimkar, Santosh wrote:
> On Fri, Aug 24, 2012 at 3:12 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >
> > On Fri, Aug 24, 2012 at 09:51:15AM +0200, Peter Meerwald wrote:
> > > the commit just sets CONFIG_DMA_OMAP=y and CONFIG_DMADEVICES=y in
> > > omap2plus_defconfig; this does not help people updating the kernel while
> > > keeping the config, nor does it help people in configuring the kernel
> > >
> > > there is a dependency (at least for beagleboard) between MMC_OMAP_HS and
> > > DMA_OMAP, and I think this should be made explicit
> >
> > Well, this is where stuff starts to get really yucky, because that
> > means if you have DMA_OMAP as a module, you have to have MMC_OMAP_HS
> > as a module too.  Or vice versa.  Which is a real pain for further
> > development of DMA_OMAP.
> >
> > Whatever, the solution here is NOT to add select statements to the
> > Kconfig to force DMA engine support and DMA_OMAP to 'y' for OMAP.
> > The best solution is for MMC_OMAP_HS to depend on DMA_OMAP, but that
> > will just mean that you'll end up with MMC_OMAP_HS disabled in your
> > config witout DMA engine support.  Another less desirable solution
> > is to have MMC_OMAP_HS select DMA engine and DMA_OMAP.
> 
> Part of the patch [1] does the last part.
> MMC_OMAP_HS select DMA engine and DMA_OMAP.
> 
> Regards
> Santosh
> 
> [1] https://patchwork.kernel.org/patch/1203391/

Well, I never saw that patch.  When I say "I'm going to be away for most
of July, and I won't be reading email, and I won't catch up with email
when I'm back" and when I get back I explicitly ask for stuff which needs
my attention sending, that's hardly surprising...

But anyway, as I said above, the "select" option is less desirable because
it forces stuff.  And if you've seen the kind of crap that you have to go
through to figure out why the hell you can't disable an option, you'll
understand why I consider that solution revolting.

Take, for instance, a list of dependencies spits out by menuconfig that
fills your entire screen, and you have to work out by reading carefully
through 2K of characters which combination of options is forcing the one
you want to turn off back on.  That is why "select" used inappropriately
is pure evil incarnate.
