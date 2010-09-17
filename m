From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/5] ARM: S5PV310: Add HSMMC support and SDHCI configuration
Date: Fri, 17 Sep 2010 09:57:16 +0900
Message-ID: <039f01cb5603$49205f20$db611d60$%kim@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
 <1284626223-18944-2-git-send-email-jeongbae.seo@samsung.com>
 <AANLkTi=Vx42siGBno7sLrirCRSiMvEr=2-toHHYU7405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19875 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab0IQA5F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2010 20:57:05 -0400
In-reply-to: <AANLkTi=Vx42siGBno7sLrirCRSiMvEr=2-toHHYU7405@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>, 'Jeongbae Seo' <jeongbae.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>

Kyungmin Park wrote:
>=20
> On Thu, Sep 16, 2010 at 5:36 PM, Jeongbae Seo <jeongbae.seo@samsung.c=
om>
> wrote:
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > This patch adds to support HSMMC for S5PV310 and S5PC210 and setup =
for
> > HSMMC host controller and also related GPIO.
> > At most 4 channel can be used at the same time.
> > A user can configure SDHCI data bus as 8bit or 4bit.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> > ---
> > =A0arch/arm/mach-s5pv310/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 39 ++=
++++++
> > =A0arch/arm/mach-s5pv310/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +
> > =A0arch/arm/mach-s5pv310/setup-sdhci-gpio.c | =A0156
> ++++++++++++++++++++++++++++++
> > =A0arch/arm/mach-s5pv310/setup-sdhci.c =A0 =A0 =A0| =A0 69 ++++++++=
+++++
> > =A04 files changed, 266 insertions(+), 0 deletions(-)
> > =A0create mode 100644 arch/arm/mach-s5pv310/setup-sdhci-gpio.c
> > =A0create mode 100644 arch/arm/mach-s5pv310/setup-sdhci.c
> >
> > diff --git a/arch/arm/mach-s5pv310/Kconfig
b/arch/arm/mach-s5pv310/Kconfig
> > index 9ac29fe..6a07968 100644
> > --- a/arch/arm/mach-s5pv310/Kconfig
> > +++ b/arch/arm/mach-s5pv310/Kconfig
> > @@ -25,6 +25,17 @@ config S5PV310_SETUP_I2C2
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Common setup code for i2c bus 2.
> >
> > +config S5PV310_SETUP_SDHCI
> > + =A0 =A0 =A0 bool
> > + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI_GPIO
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Internal helper functions for S5PV310 based SDHCI=
 systems.
> > +
> > +config S5PV310_SETUP_SDHCI_GPIO
> > + =A0 =A0 =A0 bool
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Common setup code for SDHCI gpio.
> > +
> > =A0# machine support
> >
> > =A0menu "S5PC210 Machines"
> > @@ -33,6 +44,11 @@ config MACH_SMDKC210
> > =A0 =A0 =A0 =A0bool "SMDKC210"
> > =A0 =A0 =A0 =A0select CPU_S5PV310
> > =A0 =A0 =A0 =A0select ARCH_SPARSEMEM_ENABLE
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC1
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC2
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC3
> > + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Machine support for Samsung SMDKC210
> > =A0 =A0 =A0 =A0 =A0S5PC210(MCP) is one of package option of S5PV310
> > @@ -53,9 +69,32 @@ config MACH_SMDKV310
> > =A0 =A0 =A0 =A0bool "SMDKV310"
> > =A0 =A0 =A0 =A0select CPU_S5PV310
> > =A0 =A0 =A0 =A0select ARCH_SPARSEMEM_ENABLE
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC1
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC2
> > + =A0 =A0 =A0 select S3C_DEV_HSMMC3
> > + =A0 =A0 =A0 select S5PV310_SETUP_SDHCI
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0Machine support for Samsung SMDKV310
> >
> > =A0endmenu
> >
> > +comment "Configuration for HSMMC bus width"
> > +
> > +menu "Use 8-bit bus width"
> > +
> > +config S5PV310_SDHCI_CH0_8BIT
> > + =A0 =A0 =A0 bool "Channel 0 with 8-bit bus"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Support HSMMC Channel 0 8-bit bus.
> > + =A0 =A0 =A0 =A0 If selected, Channel 1 is disabled.
> > +
> > +config S5PV310_SDHCI_CH2_8BIT
> > + =A0 =A0 =A0 bool "Channel 2 with 8-bit bus"
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 Support HSMMC Channel 2 8-bit bus.
> > + =A0 =A0 =A0 =A0 If selected, Channel 3 is disabled.
>=20
> I think it's not needed since most boards have fixed bandwith and
> cfg_gpio handle it regardless these configuration.
> Also we use the select state if needed, e.g., when MMC0 uses
> 8-buswidth then don't select MMC1.
> I saw the SMDK board use this configuration. but just choose bandwidt=
h 4
or 8.
>=20
Hmm...

If it can be supported 4bit or 8bit option on each board, should be add=
ed
above configuration for selecting it.

Mr. Seo, it would be nice if you could add un-selection CH1 or CH3 when
selecting 8bit support later.

Anyway, looks ok to me now..will apply.

> Others good.
>=20
(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

