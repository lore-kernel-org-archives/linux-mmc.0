From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: MMC: no regulator off during probe for
 eMMC
Date: Tue, 31 May 2011 06:45:03 -0700
Message-ID: <20110531134502.GT11352@atomide.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
 <1306765534-20103-3-git-send-email-balajitk@ti.com>
 <20110531132614.GR11352@atomide.com>
 <BANLkTikhQ9esHA+WefbbfD=RUDWVsG9MbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59465 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751756Ab1EaNpG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 09:45:06 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikhQ9esHA+WefbbfD=RUDWVsG9MbA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

* T Krishnamoorthy, Balaji <balajitk@ti.com> [110531 06:28]:
> On Tue, May 31, 2011 at 6:56 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Balaji T K <balajitk@ti.com> [110530 07:23]:
> >> eMMC does not handle power off when not in sleep state,
> >> Skip regulator disable during probe when eMMC is
> >> not in known state - state left by bootloader.
> >>
> >> Resolves eMMC failure on OMAP4
> >> mmc0: error -110 whilst initialising MMC card
> >>
> >> --- a/arch/arm/mach-omap2/hsmmc.h
> >> +++ b/arch/arm/mach-omap2/hsmmc.h
> >> @@ -18,6 +18,7 @@ struct omap2_hsmmc_info {
> >> =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0nonremovable; =C2=A0 /* Non=
removable e.g. eMMC */
> >> =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0power_saving; =C2=A0 /* Try=
 to sleep or power off when possible */
> >> =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0no_off; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* power_saving and power is not to go off */
> >> + =C2=A0 =C2=A0 bool =C2=A0 =C2=A0no_off_init; =C2=A0 =C2=A0/* no =
power off when not in MMC sleep state */
> >> =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0vcc_aux_disable_is_sleep; /=
* Regulator off remapped to sleep */
> >> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 gpio_cd; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* or -EINVAL */
> >> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 gpio_wp; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* or -EINVAL */
> >
> > Can't you use no_off for this too?
>=20
> no_off is used for devices which do not want to disable regulator at =
any time.
>=20
> newly introduced no_off_init is to skip disable regulator only during=
 probe
> After eMMC is put in sleep state (while suspend), regulator for eMMC
> (VAUX1) can be disabled.

OK I'll queue this as a fix too then. Anybody from the MMC list care
to ack?

Tony
