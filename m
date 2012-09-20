From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/34] i.MX multi-platform support
Date: Thu, 20 Sep 2012 21:36:32 +0800
Message-ID: <20120920133630.GG2450@S2101-09.ap.freescale.net>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920114148.GH17666@opensource.wolfsonmicro.com>
 <20120920115213.GF2450@S2101-09.ap.freescale.net>
 <20120920124709.GN17666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120920124709.GN17666-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Javier Martin <javier.martin-N4RbWZIug12MkV8/HQOAswC/G2K4zDHf@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Paulius Zaleckas <paulius.zalecka>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 20, 2012 at 08:47:10AM -0400, Mark Brown wrote:
> On Thu, Sep 20, 2012 at 07:52:15PM +0800, Shawn Guo wrote:
> > On Thu, Sep 20, 2012 at 07:41:50AM -0400, Mark Brown wrote:
> 
> > > It's usually pretty early but Takashi will be on holiday this time so
> > > I'm not sure if things might be different (he was going to send the pull
> > > request from holiday).  I also didn't guarantee that it'll be stable
> > > yet, can someone please tell me what the depenency is here?
> 
> > We need the patch to have all imx drivers mach/* inclusion free,
> > so that we can enable multi-platform support for imx, which is the
> > whole point of the series.
> 
> That doesn't answer the question.  What is the dependency - what is it
> about this patch that something else depends on?  Your cover letters
> just say you'd like to do this but don't mention dependencies at all and
> when I asked the question last night you said the same thing.  I've not
> seen the rest of the series...
> 
Ah, right.  You did get copied on the whole series.  So the whole point
of patch "ASoC: mx27vis: retrieve gpio numbers from platform_data" is
to get rid of inclusion mach/iomux-mx27.h.  This has to be done before
we enable multi-platform support for imx, since mach/* has to be removed
completely for multi-platform build.

> > If your for-3.7 is not stable anyway, I guess the easiest the way
> 
> It probably *is* stable but I'm not enthused about people pulling
> unsigned tags.  I might rebase, though - I'm going to finalise the tree
> in the next few days.
> 
> > to do it might be you drop the patch "ASoC: mx27vis: retrieve gpio
> > numbers from platform_data" from your tree and I have it be part of
> > the series to go via arm-soc tree as a whole.  (This is the original
> > plan that I mentioned in v1 cover letter)
> 
> You just mentioned it as a preference (you said it's something you'd
> like to do), please if you're doing this sort of cross tree thing be
> explicit about what the inter-tree relationships are.  If things need to
> go in via the same tree say so explicitly (and ideally say way this is).
> 
Ok, my bad.

> The main reason I applied it straight away was that Javier mentioned
> that it was a bug fix and it's near the merge window and these random
> ARM cleanup serieses never seem to go in quickly.

The series is planned for 3.7 merge window.  Is it still possible for
you to drop the patch from your tree to ease the process?  Or I will
hold my pull-request to arm-soc until you tell me you have your tree
finalized.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
