From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: csd version check updated to support MMC v4.41
Date: Wed, 14 Jul 2010 18:15:30 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E27D761@dbde02.ent.ti.com>
References: <1279095667-21255-1-git-send-email-s-ghorai@ti.com>
	<FCCFB4CDC6E5564B9182F639FC3560870305CE5795@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E27D730@dbde02.ent.ti.com>
 <AANLkTinpi8fhKB-zTHVgDub_ppqpvsWeTLnoQat3PX8m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59271 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541Ab0GNMpk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 08:45:40 -0400
In-Reply-To: <AANLkTinpi8fhKB-zTHVgDub_ppqpvsWeTLnoQat3PX8m@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: kyungmin78@gmail.com [mailto:kyungmin78@gmail.com] On Behalf Of
> Kyungmin Park
> Sent: Wednesday, July 14, 2010 6:09 PM
> To: Ghorai, Sukumar
> Cc: Sripathy, Vishwanath; linux-mmc@vger.kernel.org; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH] mmc: csd version check updated to support MMC v4=
=2E41
>=20
> Hi,
>=20
> you can find it's already merged at mmc tree.
>=20
> Try to find this one. [PATCH v2] Recognize CSD structure version 3
[Ghorai] Thanks I got it.=20
>=20
> Thank you,
> Kyungmin Park
>=20
> On Wed, Jul 14, 2010 at 9:19 PM, Ghorai, Sukumar <s-ghorai@ti.com> wr=
ote:
> >
> >
> >> -----Original Message-----
> >> From: Sripathy, Vishwanath
> >> Sent: Wednesday, July 14, 2010 5:23 PM
> >> To: Ghorai, Sukumar; linux-mmc@vger.kernel.org; linux-
> omap@vger.kernel.org
> >> Subject: RE: [PATCH] mmc: csd version check updated to support MMC
> v4.41
> >>
> >>
> >>
> >> > -----Original Message-----
> >> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> > owner@vger.kernel.org] On Behalf Of Ghorai, Sukumar
> >> > Sent: Wednesday, July 14, 2010 1:51 PM
> >> > To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> >> > Cc: Ghorai, Sukumar
> >> > Subject: [PATCH] mmc: csd version check updated to support MMC v=
4.41
> >> >
> >> > =A0CSD_STRUCTURE [127:126] describes the version of the CSD stru=
cture.
> >> > =A0According to the MMC specificaiton (v4.4.1), 3 is also a vali=
d
> number.
> >> >
> >> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> >> > ---
> >> > =A0Tested on omap4430 ES2.0
> >> >
> >> > =A0drivers/mmc/core/mmc.c | =A0 =A02 +-
> >> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >> >
> >> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> > index 89f7a25..525af33 100644
> >> > --- a/drivers/mmc/core/mmc.c
> >> > +++ b/drivers/mmc/core/mmc.c
> >> > @@ -122,7 +122,7 @@ static int mmc_decode_csd(struct mmc_card *c=
ard)
> >> > =A0 =A0 =A0* v1.2 has extra information in bits 15, 11 and 10.
> >> > =A0 =A0 =A0*/
> >> > =A0 =A0 csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
> >> > - =A0 if (csd_struct !=3D 1 && csd_struct !=3D 2) {
> >> > + =A0 if (csd_struct > 3) {
> >>
> >> Can't csd_struct be 0? If so then your new check will break right?
> > [Ghorai] 0 to 3 are the valid numbers.
> >
> >>
> >> > =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised CSD st=
ructure
> version %d\n",
> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host)=
, csd_struct);
> >> > =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
omap"
> in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
