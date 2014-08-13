From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: Remove architecture dependency
Date: Thu, 14 Aug 2014 00:46:18 +0200
Message-ID: <1786859.jGWg0DZRp1@wuerfel>
References: <1407951153-918-1-git-send-email-abrestic@chromium.org> <CAGOxZ51_cr_j5vWrNO_ZnfAQsvt8zfEjQZC2f-nWv4w9b5R1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63112 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbaHMWqX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 18:46:23 -0400
In-Reply-To: <CAGOxZ51_cr_j5vWrNO_ZnfAQsvt8zfEjQZC2f-nWv4w9b5R1kQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@gmail.com>
Cc: Andrew Bresticker <abrestic@chromium.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Doug Anderson <dianders@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 14 August 2014 03:51:43 Alim Akhtar wrote:
> On Wed, Aug 13, 2014 at 11:02 PM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
> > The dw_mmc host may also be present on non-ARC/ARM SoCs (e.g. MIPS)
> > and the driver itself does not appear to depend on any particular
> > architecture(s).
> >
> > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > ---
> >  drivers/mmc/host/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index a565254..15b110a 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -563,7 +563,6 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
> >
> >  config MMC_DW
> >         tristate "Synopsys DesignWare Memory Card Interface"
> > -       depends on ARC || ARM
> 
> I am not sure if just removing _depends_ is good vs adding another
> architecture(s) dependency here.
> There are n number of places in Kconfig where this _depends_ runs up
> to well over 10 entries.
> What about config like MMC_DW_EXYNOS and MMC_DW_K3 which depends on
> MMC_DW? Is it ok to expose them as well for architectures which might
> not contains these variants?
> 
> One way I found this useful, one need not worry about finding MMC_DW
> in there arch default menu-config, this will just appear, go and
> select it.
> 
> Lets see what others think about this.

In general, it's best to have specific dependencies on the subsystem
a driver uses. You probably need something like

	depends on HAS_IOMEM && COMMON_CLK && REGULATOR
	depends on COMPILE_TEST || ARC || ARM || MIPS

to cover all the possible cases. The specific options are probably
not the ones I listed above, but you should get the idea. Most importantly,
you don't want to allow building the driver on architectures on which
it can't compile.

	Arnd
