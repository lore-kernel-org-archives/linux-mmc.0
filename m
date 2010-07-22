From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v3] Samsung: sdhci-s3c: add support for new card detection
	methods
Date: Thu, 22 Jul 2010 10:25:44 +0200
Message-ID: <000501cb2977$7d6cf210$7846d630$%szyprowski@samsung.com>
References: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
	<20100715133954.7fcb797a.akpm@linux-foundation.org>
	<011401cb24af$8eb2cb70$ac186250$%szyprowski@samsung.com>
	<20100721161133.5c3285d3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100721161133.5c3285d3.akpm@linux-foundation.org>
Content-language: pl
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello,

On Thursday, July 22, 2010 1:12 AM 

> On Fri, 16 Jul 2010 08:24:26 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > > >  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
> > > >  arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 ++++++++++++++----
> -
> > > >  arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 +++++++++++++++---
> --
> > > >  arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
> > > >  arch/arm/plat-samsung/dev-hsmmc3.c         |    5 ++++
> > > >  arch/arm/plat-samsung/include/plat/sdhci.h |   29
> > > ++++++++++++++++++++++++++++
> > > >  8 files changed, 90 insertions(+), 16 deletions(-)
> > >
> > > This is quite confusing.  You've already sent a patch called
> > > "sdhci-s3c: add support for new card detection methods".  It had the
> > > same changelog as this patch and the same title, but the two patches
> > > are utterly different!
> >
> > The real patch has been split into two for easier merging: 1. the driver
> > part and 2. samsung platform related part. The part which patch belongs
> > to is indicated in the last line of the change log.
> >
> > I'm really confused how to submit properly a patch that requires changes
> > to both the driver (which is merged by the proper driver maintainer's
> > sub-tree) and the platform (which should go through platform maintainer's
> > tree).
> 
> Make the relationship very very clear in the changelog.  Send both
> patches to both maintainers.  Ask that one of them merge both patches
> and that the other ack both patches.

Ok. Thanks for the hint.

> Anyway, I've forgotten what's happening here.  I appear to be sitting on
> 
> sdhci-s3c-add-support-for-the-non-standard-minimal-clock-value.patch

This one is independent from the card-detection patches and can be applied
directly onto linux-next kernel tree.

> and
> sdhci-s3c-add-support-for-new-card-detection-methods.patch
> 
> the latter of which is below.
> 
> Am I missing something?  Is
> sdhci-s3c-add-support-for-new-card-detection-methods.patch up to date?
> 

Ok, I will repost these 2 patches under new names to avoid further
confusion. Currently there exists two 
"sdhci-s3c-add-support-for-new-card-detection-methods.patch", both of them 
are required.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
