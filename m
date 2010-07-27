From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3] Samsung: sdhci-s3c: add support for new card detection
 methods
Date: Tue, 27 Jul 2010 20:27:55 +0900
Message-ID: <000801cb2d7e$c572b7b0$50582710$%kim@samsung.com>
References: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
 <20100715133954.7fcb797a.akpm@linux-foundation.org>
 <011401cb24af$8eb2cb70$ac186250$%szyprowski@samsung.com>
 <20100721161133.5c3285d3.akpm@linux-foundation.org>
 <000501cb2977$7d6cf210$7846d630$%szyprowski@samsung.com>
 <20100726135708.57048800.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100726135708.57048800.akpm@linux-foundation.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Andrew Morton' <akpm@linux-foundation.org>, 'Marek Szyprowski' <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Andrew Morton wrote:
> 
> On Thu, 22 Jul 2010 10:25:44 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > Hello,
> >
> > On Thursday, July 22, 2010 1:12 AM
> >
> > > On Fri, 16 Jul 2010 08:24:26 +0200
> > > Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > >
> > > > > >  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
> > > > > >  arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21
> ++++++++++++++----
> > > -
> > > > > >  arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22
> +++++++++++++++---
> > > --
> > > > > >  arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
> > > > > >  arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
> > > > > >  arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
> > > > > >  arch/arm/plat-samsung/dev-hsmmc3.c         |    5 ++++
> > > > > >  arch/arm/plat-samsung/include/plat/sdhci.h |   29
> > > > > ++++++++++++++++++++++++++++
> > > > > >  8 files changed, 90 insertions(+), 16 deletions(-)
> > > > >
> > > > > This is quite confusing.  You've already sent a patch called
> > > > > "sdhci-s3c: add support for new card detection methods".  It had
the
> > > > > same changelog as this patch and the same title, but the two
patches
> > > > > are utterly different!
> > > >
> > > > The real patch has been split into two for easier merging: 1. the
driver
> > > > part and 2. samsung platform related part. The part which patch
belongs
> > > > to is indicated in the last line of the change log.
> > > >
> > > > I'm really confused how to submit properly a patch that requires
changes
> > > > to both the driver (which is merged by the proper driver
maintainer's
> > > > sub-tree) and the platform (which should go through platform
maintainer's
> > > > tree).
> > >
> > > Make the relationship very very clear in the changelog.  Send both
> > > patches to both maintainers.  Ask that one of them merge both patches
> > > and that the other ack both patches.
> >
> > Ok. Thanks for the hint.
> >
> > > Anyway, I've forgotten what's happening here.  I appear to be sitting
on
> > >
> > > sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value.patch
> >
> > This one is independent from the card-detection patches and can be
applied
> > directly onto linux-next kernel tree.
> >
> > > and
> > > sdhci-s3c-add-support-for-new-card-detection-methods.patch
> > >
> > > the latter of which is below.
> > >
> > > Am I missing something?  Is
> > > sdhci-s3c-add-support-for-new-card-detection-methods.patch up to date?
> > >
> >
> > Ok, I will repost these 2 patches under new names to avoid further
> > confusion. Currently there exists two
> > "sdhci-s3c-add-support-for-new-card-detection-methods.patch", both of
them
> > are required.
> 
> So the second(?) patch "[PATCH v4] Samsung: add new card detection
> methods in s3c-sdhci driver (platform part)" has already been applied
> to linux-next by Kukjin Kim, along with modifications which we have not
> been shown.

Yeah, I applied it in my tree which can be merged linux-next.
> 
> But the first patch
> (sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value.patch)
> has not been applied to linux-next by anoyne and the third patch
> "[PATCH v4] sdhci-s3c: add support for new card detection methods
> (driver part)" has not been applied either.
> 
> This is a complete mess.  What happens if I apply and merge
> sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value.patch
> and
> sdhci-s3c-add-support-for-new-card-detection-methods-driver-part.patch?
> I have no idea.

Hmm...

> 
> I think I'll just drop all of it.  Please sort all of this out then let
> me know what you want me to do.

If any updates, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
