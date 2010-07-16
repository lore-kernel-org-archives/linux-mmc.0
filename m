From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v3] Samsung: sdhci-s3c: add support for new card detection
	methods
Date: Fri, 16 Jul 2010 08:24:26 +0200
Message-ID: <011401cb24af$8eb2cb70$ac186250$%szyprowski@samsung.com>
References: <1279181721-23333-1-git-send-email-m.szyprowski@samsung.com>
	<20100715133954.7fcb797a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100715133954.7fcb797a.akpm@linux-foundation.org>
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

On Thursday, July 15, 2010 10:40 PM Andrew Morton wrote:

> On Thu, 15 Jul 2010 10:15:21 +0200
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > On some Samsung SoCs not all SDHCI controllers have card detect (CD)
> > line. For some embedded designs it is not even needed, because ususally
> > the device (like SDIO flash memory or wifi controller) is permanently
> > wired to the controller. There are also systems which have a card detect
> > line connected to some of the external interrupt lines or the presence
> > of the card depends on some other actions (like enabling a power
> > regulator).
> >
> > This patch adds support for all these cases. The following card
> > detection methods are possible:
> >
> > 1. internal sdhci host card detect line
> > 2. external event
> > 3. external gpio interrupt
> > 4. no card detect line, controller will poll for the card
> > 5. no card detect line, card is permanently wired to the controller
> > (once detected host won't poll it any more)
> >
> > By default, all existing code would use method #1, what is compatible
> > with the previous version of the driver.
> >
> > In case of external event, two callbacks must be provided in platdata:
> > ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
> > function that notifies the s3c-sdhci host contoller as their argument.
> > That callback function should be called from the even dispatcher to let
> > host notice the card insertion/removal.
> >
> > In case of external gpio interrupt, a gpio pin number must be provided
> > in platdata (ext_cd_gpio parameter), as well as the information about
> > the polarity of that gpio pin (ext_cd_gpio_invert). By default
> > (ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
> > but this can be changed to 'card has been removed' when
> > ext_cd_gpio_invert == 1.
> >
> > This patch adds all required changes to platform support code.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >
> > This a resend of the previous patch. Relevant patches for sdhci-s3c
> > driver has been posted in a separate patch series for easier merging,
> > please refer to the "[PATCH] SDHCI-S3C fixes and enhancements (driver
> > specific code)" thread. They have been already taken by Andrew Morton
> > into his patch tracking tree.
> >
> > I hope these changes to platform specific code gets merged soon, so the
> > changes to the driver can be merged as well.
> >
> > The patch has been prepared for the following git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-next
> >
> > Changes since V2:
> > - added support for HSMMC3 device
> >
> > Changes since V1:
> > - added support for gpio external interrupt card based detect method
> >   directly to sdhci-s3c driver
> > - removed s3c64xx compilation fix patch from the series
> >
> > Best regards
> > --
> > Marek Szyprowski
> > Samsung Poland R&D Center
> >
> > ---
> >
> >  arch/arm/mach-s3c64xx/setup-sdhci-gpio.c   |   14 +++++++++---
> >  arch/arm/mach-s5pc100/setup-sdhci-gpio.c   |   21 ++++++++++++++-----
> >  arch/arm/mach-s5pv210/setup-sdhci-gpio.c   |   22 +++++++++++++++-----
> >  arch/arm/plat-samsung/dev-hsmmc.c          |    5 ++++
> >  arch/arm/plat-samsung/dev-hsmmc1.c         |    5 ++++
> >  arch/arm/plat-samsung/dev-hsmmc2.c         |    5 ++++
> >  arch/arm/plat-samsung/dev-hsmmc3.c         |    5 ++++
> >  arch/arm/plat-samsung/include/plat/sdhci.h |   29
> ++++++++++++++++++++++++++++
> >  8 files changed, 90 insertions(+), 16 deletions(-)
> 
> This is quite confusing.  You've already sent a patch called
> "sdhci-s3c: add support for new card detection methods".  It had the
> same changelog as this patch and the same title, but the two patches
> are utterly different!

The real patch has been split into two for easier merging: 1. the driver
part and 2. samsung platform related part. The part which patch belongs
to is indicated in the last line of the change log.

I'm really confused how to submit properly a patch that requires changes
to both the driver (which is merged by the proper driver maintainer's
sub-tree) and the platform (which should go through platform maintainer's
tree).

> I suggest that you resend this patch under an appropriate title and
> with a more specific changelog, please.

Ok, I will add something like "(platform changes)" to the patch title next time.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
