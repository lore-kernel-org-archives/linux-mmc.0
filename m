From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v6] OMAP4 HSMMC: Adding Card detect support for MMC1 on OMAP4
Date: Thu, 5 Aug 2010 17:41:07 -0500
Message-ID: <A30C38BCD2714EE8A5E107E8C4CE6976@am.dhcp.ti.com>
References: <20809.10.24.255.18.1278511944.squirrel@dbdmail.itg.ti.com><AANLkTimNbzSMeOW4m201D=uV1WyYqkwpE1KqdTb8Qudy@mail.gmail.com><966519786A214EA4BC770E7EC4D50628@am.dhcp.ti.com><AANLkTinZDt-ApCSPRxXQnFx6=M4-_EZhYBrtetoRhcn8@mail.gmail.com><AC97C00B2EE8468DAA78B37136C89721@am.dhcp.ti.com> <AANLkTi=5mvAN5iK1aV1yWPxSmrd6OKwg_HW6mgqqQro4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37778 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760837Ab0HEWmF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 18:42:05 -0400
In-Reply-To: <AANLkTi=5mvAN5iK1aV1yWPxSmrd6OKwg_HW6mgqqQro4@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'kishore kadiyala' <kishorek.kadiyala@gmail.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, adrian.hunter@nokia.com



> -----Original Message-----
> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
> Sent: Thursday, August 05, 2010 11:04 AM
> To: Madhusudhan
> Cc: Andrew Morton; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.=
org;
> tony@atomide.com; adrian.hunter@nokia.com
> Subject: Re: [PATCH v6] OMAP4 HSMMC: Adding Card detect support for M=
MC1
> on OMAP4
>=20
> Madhu,
>=20
> On Thu, Aug 5, 2010 at 4:26 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> > <snip>
> >
> >> >> > =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A07 +++-
> >> >> > =A0drivers/mfd/twl6030-irq.c =A0 =A0 =A0 =A0 =A0 | =A0 76
> >> >> +++++++++++++++++++++++++++++++++++
> >> >> > =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 | =A0 =A04 +-
> >> >> > =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 +=
++++++
> >> >> > =A04 files changed, 100 insertions(+), 3 deletions(-)
> >> >> >
> >> >> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/m=
ach-
> >> >> omap2/board-4430sdp.c
> >> >> > index f287461..388b96d 100644
> >> >> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> >> >> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> >> >> > @@ -227,9 +227,14 @@ static int
> omap4_twl6030_hsmmc_late_init(struct
> >> >> device *dev)
> >> >> > =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->=
platform_data;
> >> >> >
> >> >> > =A0 =A0 =A0 =A0/* Setting MMC1 Card detect Irq */
> >> >> > - =A0 =A0 =A0 if (pdev->id =3D=3D 0)
> >> >> > + =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_mmc_card_detect=
_config();
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed =
configuring MMC1 card
> >> detect\n");
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_ir=
q =3D TWL6030_IRQ_BASE
> +
> >> >> >
> =A0MMCDETECT_INTR_OFFSET;
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect =3D
> >> twl6030_mmc_card_detect;
> >
> > You are assigning an exported fn here.
> >
> > What if somebody disables CONFIG_TWL4030_CORE in the
> omap_4430sdp_defconfig
> > file? Does the driver behave nicely with only loosing the hotplug
> > capability?
>=20
> On mainline 2.6.35 omap3_defconfig works for OMAP4 but without hotplu=
g
> functionality
> Disabling CONFIG_TWL4030_CORE in defconfig  means disabling
> regulator's  and eventually
> on bootup mmc host drivers probe fails as omap_hsmmc_reg_get( )
> fails. Seems like
> MMC and TWL are tightly coupled because of LDO dependency.
>=20
> With this V6 patch and omap3_defconfig , disabling CONFIG_TWL4030_COR=
E
> [also need to disable USB & comment board-devkit8000.c in
> mach-omap2/Makefile as they have dependency on
> twl_i2c_write_u8/twl_i2c_read_u8 defined in twl-core.c] doesn't
> compile due to undefined reference to those exported functions
> twl6030_mmc_card_detect_config & twl6030_mmc_card_detect .
>
> Having below one[in twl.h] in addition to V6 :
>=20
>  /* Card detect Configuration for MMC1 Controller on OMAP4 */
> +#if defined(CONFIG_TWL4030_CORE)
>  int twl6030_mmc_card_detect_config(void);
> +#else
> +static inline int twl6030_mmc_card_detect_config(void)
> +{
> +	pr_err("twl6030_mmc_card_detect_config not supported\n");
> +	return 0;
> +}
> +#endif
>=20
>  /* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
> +#if defined(CONFIG_TWL4030_CORE)
>  int twl6030_mmc_card_detect(struct device *dev, int slot);
> -
> +#else
> +static inline int twl6030_mmc_card_detect(struct device *dev, int sl=
ot)
> +{
> +	pr_err("Call back twl6030_mmc_card_detect not supported\n");
> +	return -EIO;
> +}
> +#endif
>=20
> With the above change compilation as well as booting goes well but mm=
c
> probe
> fails.
>=20
> Shall I go with above changes and post V7 ?
>=20

Yes. In my opinion this is better than V6.

Regards,
Madhu

> <snip>
>=20
> Thanks ,
> Kishore

