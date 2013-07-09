From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [PATCH] Powerpc/t4240: change the
 compatible flags for t4240qds board
Date: Tue, 9 Jul 2013 15:04:22 -0500
Message-ID: <1373400262.8183.201@snotra>
References: <99E897753B6F7048BD8CCDB4661D02E1396F57@039-SN2MPN1-021.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	delsp=Yes	format=Flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:10041
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752627Ab3GIUEg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 16:04:36 -0400
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E1396F57@039-SN2MPN1-021.039d.mgd.msft.net>
	(from B42677@freescale.com on Tue Jul  9 01:04:01 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>, Wrobel Heinz-R39252 <r39252@freescale.com>

On 07/09/2013 01:04:01 AM, Zhang Haijun-B42677 wrote:
>=20
>=20
> Regards & Thanks
>=20
> Haijun.
>=20
> ________________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Wood Scott-B07421
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B47=E6=9C=888=E6=97=A5=
 17:14
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Zhang Haijun-B42677
> =E6=8A=84=E9=80=81: linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozl=
abs.org; =20
> cbouatmailru@gmail.com; cjb@laptop.org; Fleming Andy-AFLEMING; Wrobel=
 =20
> Heinz-R39252; Zhang Haijun-B42677
> =E4=B8=BB=E9=A2=98: Re: [PATCH] Powerpc/t4240: change the compatible =
flags for =20
> t4240qds board
>=20
> On 07/08/2013 02:16:03 AM, Haijun Zhang wrote:
> > In order to make a difference between different T4240 board.
> > Specify T4240QDS board the unique compatible flags for t4240qds
> > eSDHC host.
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > index bd611a9..08b47d0 100644
> > --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > @@ -397,7 +397,7 @@
> >
> >  /include/ "qoriq-esdhc-0.dtsi"
> >       sdhc@114000 {
> > -             compatible =3D "fsl,t4240-esdhc", "fsl,esdhc";
> > +             compatible =3D "fsl,t4240qds-esdhc", "fsl,esdhc";
> >               sdhci,auto-cmd12;
> >       };
>=20
> NACK.  This node is describing the sdhc block of the t4240 SoC.  What
> board you stick it in doesn't change what it is.
>=20
> Plus, what about users with old device trees?
>=20
> Currently no users use this ip block except esdhc driver.

I'm not talking about code users.  I'm talking about people users.

> How about change this in arch/powerpc/boot/dts/t4240qds.dts
>=20
> +++ b/arch/powerpc/boot/dts/t4240qds.dts
> @@ -117,6 +117,10 @@
>                         };
>                 };
>=20
>                sdhc@114000 {
>                       compatible =3D "fsl,t4240-esdhc", "fsl,esdhc";
>                };
>=20
>                i2c@118000 {
>=20
>=20
> +++ b/arch/powerpc/boot/dts/t4240qds.dts
> @@ -117,6 +117,10 @@
>                         };
>                 };
>=20
> +               sdhc@114000 {
> +                       compatible =3D "fsl,t4240qds-esdhc", =20
> "fsl,esdhc";
> +               };
> +
>                 i2c@118000 {

No.  It's still supposed to be describing the sdhc block itself, not =20
the board -- and any workarounds that key off of this will still fail =20
to work with existing device trees.

-Scott
