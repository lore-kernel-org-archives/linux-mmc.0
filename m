From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Fri, 25 Apr 2014 12:20:18 +0100
Message-ID: <20140425112018.GJ26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com> <20140424101726.GH26756@n2100.arm.linux.org.uk> <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com> <20140424105745.GM26756@n2100.arm.linux.org.uk> <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com> <20140425090343.GH26756@n2100.arm.linux.org.uk> <CAPDyKFpAiegwfh=kA8NyB+DdwKT=wSGJsB=gbEgLbyv0RJ2EOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpAiegwfh=kA8NyB+DdwKT=wSGJsB=gbEgLbyv0RJ2EOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Stephe
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 25, 2014 at 01:18:28PM +0200, Ulf Hansson wrote:
> On 25 April 2014 11:03, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > On Thu, Apr 24, 2014 at 01:13:05PM +0200, Ulf Hansson wrote:
> >> On 24 April 2014 12:57, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> >> > This is nothing new or unexpected - it was last posted back in February,
> >> > and I elected that it should be held off until after the last merge
> >> > window.
> >> >
> >> > Unfortunately, I didn't have time to post it immediately after the merge
> >> > window closed, partly because it needed to be rebased on top of tglx's
> >> > IRQ changes on which it depends.  I was carrying those as separate commits
> >> > to the ones Thomas was carrying in his tree - and in the event, Thomas had
> >> > modified his patches slightly between sending me copies of them and the
> >> > versions he sent during the merge window.
> >>
> >> Okay, so let's keep up the frequency here then. I only had some minor
> >> comments, please fix them and send a v2.
> >
> > Right, so I've updated the patches, and added one ack to one patch.
> > That seems insufficient to me - the only platform these have been
> > tested on is iMX6, which is sdhci-esdhc-imx.c.
> >
> > They _really_ need testing elsewhere too.  Or is the plan to merge
> > them and then see about getting people to test them and fix them up
> > afterwards?
> 
> I was hoping people could start doing tests, before Chris actually
> decided to pull them in. Now, if that doesn't happen, we could just
> merge them, as you say, and thus we have to fix potential problems
> afterwards. I would expect you to help out if problem occurs.
> 
> If we decide to not merge in a while, I am not sure how long we could
> prevent other sdhci patches from being merged. I guess Chris will have
> to take the final call.

Or we just drop them for yet another cycle and show how mainline kernel
development sucks, why getting stuff into mainline is utterly painful,
and why using vendor kernels is /soo/ much better than this crap.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
