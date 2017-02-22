From: Avri Altman <Avri.Altman@sandisk.com>
Subject: RE: SDIO bus hang on BayTrail machines
Date: Wed, 22 Feb 2017 12:40:23 +0000
Message-ID: <9BEFCB713C10BF4B91D714797ECA5EEA117EC576@ULS-OP-MBXIP04.sdcorp.global.sandisk.com>
References: <CA+A7VXXmA1KGjPfnUmZPBKDXmUMYhjLeXbo=8Ho3CrCvt7rjbA@mail.gmail.com>
 <CAPDyKFrO4ajLw=TDsMa==fL_Q6BYxoO_x1OFODB7+oMJdJCr3w@mail.gmail.com>
 <e2659959-ded2-1ea9-e859-6ce8a8172eab@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4748 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbdBVMly (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Feb 2017 07:41:54 -0500
In-Reply-To: <e2659959-ded2-1ea9-e859-6ce8a8172eab@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, =?iso-8859-1?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux@endlessm.com" <linux@endlessm.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Thursday, February 16, 2017 3:09 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; Jo=E3o Paulo Rechi Vita
> <jprvita@gmail.com>
> Cc: Dong Aisheng <b29396@freescale.com>; Jo=E3o Paulo Rechi Vita
> <jprvita@endlessm.com>; linux-mmc@vger.kernel.org; linux@endlessm.com
> Subject: Re: SDIO bus hang on BayTrail machines
>=20
> On 11/01/17 17:42, Ulf Hansson wrote:
> > On 12 December 2016 at 23:55, Jo=E3o Paulo Rechi Vita <jprvita@gmail.co=
m>
> wrote:
> >> Hello Dong Adrian and Ulf,
> >>
> >> I'm working on enabling a BayTrail-based machine with very similar
> >> hardware to one of the Intel Compute sticks, which is an Intel
> >> BayTrail and has a RTL8723BS WiFi card on the SDIO bus. I'm using
> >> Linux 4.8 with the driver from https://github.com/hadess/rtl8723bs,
> >> and I was experiencing a complete machine hang when using the WiFi
> >> card. Passing `intel_idle.max_cstate=3D1` together with the following
> >> patch (with the sdhci_runtime_pm_get and sdhci_runtime_pm_put
> >> implementations added back) makes the problem go away:
> >> https://github.com/hadess/rtl8723bs/blob/master/patches_4.5/0002-mmc-
> >> sdhci-get-runtime-pm-when-sdio-irq-is-enabled.patch
> >
> > It's been a while ago and I wasn't able to dig out some information
> > from earlier discussions/submissions.
> >
> >>
> >> I could not find much information on why this was never sent
> >> upstream, and would like to know if this approach would be
> >> acceptable, or if there are any other better alternatives to solve
> >> this problem. I'm not a runtime PM expert, but as I understand this
> >> keeps the device powered on as long as interrupts are enabled,
> >> potentially increasing the power consumption. As this kernel has to
> >> run several different machines using the same code base and config, I
> >> would rather avoid something that could have a negative impact on othe=
r
> platforms.
> >
> > Unless the board/soc supports an option to re-configure the SDIO IRQ
> > as wakeup when entering runtime suspend state, there is no other way
> > but to keep the device runtime resumed.
> >
> > For this specific case, I have seen two different solutions for how to
> > allow the device to be runtime suspended when using SDIO IRQ.
> > 1) Re-routing the SDIO IRQ DAT line as a GPIO IRQ at runtime suspend,
> > thus a wakeup becomes enabled.
> > 2) Using a completely separate line for SDIO IRQs and thus not a DAT
> > line, configured as a GPIO IRQ.
> >
> >>
> >> Any ideas appreciated, and I'm happy to try a newer tree if you guys
> >> think some other commit might have fixed the problem.
Did you look for possible wa on the wifi side?
Maybe you can look into the wifi driver module params -=20
can it be loaded with d0i3 disabled? Or even with power management disabled=
 (power scheme =3D CAM)?
Also maybe try Intel's wifi card...

Cheers,
Avri

> >
> > I think the best option right now, is something very similar to the
> > patch you point to at github above.
>=20
> Sorry for the *very* slow reply! :-(.  I need to find time to look at thi=
s, but
> although the patch is OK for Intel it is wrong for other SDHCI-based driv=
ers
> which *do* runtime suspend with the clock (and perhaps the whole host
> controller) still on and thus expect SDIO interrupts *during* runtime sus=
pend.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
