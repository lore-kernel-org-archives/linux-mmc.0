From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH] rename ARCH_BCM to ARCH_BCM_MOBILE
Date: Sat, 21 Sep 2013 12:16:30 -0700
Message-ID: <CAEPRUYq_btMrBeyUtoCVA69yRpc3kn-zpuykUdp9zRxZ0kERDg@mail.gmail.com>
References: <1379718260-24349-1-git-send-email-csd@broadcom.com>
	<CAOesGMjViyCa+FhNmrESc+WmnW+=wzsqBpj=jHeuCyobAmMojg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:41595 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3IUTQb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Sep 2013 15:16:31 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so924021eaj.28
        for <linux-mmc@vger.kernel.org>; Sat, 21 Sep 2013 12:16:30 -0700 (PDT)
In-Reply-To: <CAOesGMjViyCa+FhNmrESc+WmnW+=wzsqBpj=jHeuCyobAmMojg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Christian Daudt <csd@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Domenico Andreoli <cavokz@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>, Matt Porter <matt.porter@linaro.org>, Alex Elder <alex.elder@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

[plain-text resend]
On Fri, Sep 20, 2013 at 5:23 PM, Olof Johansson <olof@lixom.net> wrote:
>
> On Fri, Sep 20, 2013 at 4:04 PM, Christian Daudt <csd@broadcom.com> wrote:
> > Currently ARCH_BCM has been used for Broadcom
> > Mobile V7 based SoCs. In order to allow other Broadcom
> > SoCs to also use mach-bcm directory and files, this patch
> > renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
> > uses ARCH_BCM to define any Broadcom chip residing
> > in mach-bcm directory.
> >
> > Signed-off-by: Christian Daudt <csd@broadcom.com>
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index cc0f1fb..dd00e22 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -42,8 +42,6 @@ dtb-$(CONFIG_ARCH_AT91)       += sama5d34ek.dtb
> >  dtb-$(CONFIG_ARCH_AT91)        += sama5d35ek.dtb
> >
> >  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
> > -dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
> > -       bcm28155-ap.dtb
> >  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
> >         da850-evm.dtb
> >  dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
> > @@ -101,6 +99,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
> >         kirkwood-ts219-6282.dtb \
> >         kirkwood-openblocks_a6.dtb
> >  dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
> > +dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
> > +       bcm28155-ap.dtb
>
> This reordering looks off. The entries should be alphabetically
> ordered, so if anything it should move up above BCM2835.

Heh. I started the rename with ARCH_MOBiLE_BCM and later renamed to
ARCH_BCM_MOBILE. Forgot to move it up to reflect the change in
ordering. Fixed.

>
>
>
> > diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> > index 704d6d3..4207ab4 100644
> > --- a/drivers/clocksource/Makefile
> > +++ b/drivers/clocksource/Makefile
> > @@ -25,7 +25,7 @@ obj-$(CONFIG_SUN4I_TIMER)     += sun4i_timer.o
> >  obj-$(CONFIG_ARCH_TEGRA)       += tegra20_timer.o
> >  obj-$(CONFIG_VT8500_TIMER)     += vt8500_timer.o
> >  obj-$(CONFIG_ARCH_NSPIRE)      += zevio-timer.o
> > -obj-$(CONFIG_ARCH_BCM)         += bcm_kona_timer.o
> > +obj-$(CONFIG_ARCH_BCM_MOBILE)  += bcm_kona_timer.o
> >  obj-$(CONFIG_CADENCE_TTC_TIMER)        += cadence_ttc_timer.o
> >  obj-$(CONFIG_CLKSRC_EXYNOS_MCT)        += exynos_mct.o
> >  obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)       += samsung_pwm_timer.o
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 7fc5099..7e89650 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -251,7 +251,7 @@ config MMC_SDHCI_S3C_DMA
> >
> >  config MMC_SDHCI_BCM_KONA
> >         tristate "SDHCI support on Broadcom KONA platform"
> > -       depends on ARCH_BCM
> > +       depends on ARCH_BCM_MOBILE
> >         select MMC_SDHCI_PLTFM
> >         help
> >           This selects the Broadcom Kona Secure Digital Host Controller
>
> Since nothing breaks (i.e. ARCH_BCM is still there, and will be
> enabled for any ARCH_BCM_MOBILE platform), the above two can go
> through the corresponding subsystem trees as separate patches.
>
I was thinking of doing that, but it will actually break if the
changes to drivers show up before the changes to mach-bcm because the
drivers will no longer be compiled. I'll split it and keep the
nag-ometer set to high to ensure their inclusion then...

 Thanks,
   csd
