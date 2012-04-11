From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Get rid of of_have_populated_dt() usage
Date: Wed, 11 Apr 2012 13:31:46 +0300
Message-ID: <20120411103145.GA12064@arwen.pp.htv.fi>
References: <1334138593-9692-1-git-send-email-rnayak@ti.com>
 <20120411100956.GT12064@arwen.pp.htv.fi>
 <4F855BDC.9070103@ti.com>
 <20120411102632.GY12064@arwen.pp.htv.fi>
 <4F855D23.2090803@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fKtH0JUtvN5p2ETH"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:32985 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756306Ab2DKKcf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 06:32:35 -0400
Received: by lagj5 with SMTP id j5so618003lag.31
        for <linux-mmc@vger.kernel.org>; Wed, 11 Apr 2012 03:32:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F855D23.2090803@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: balbi@ti.com, cjb@laptop.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, b-cousson@ti.com, Balaji TK <balajitk@ti.com>, Rob Herring <rob.herring@calxeda.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>


--fKtH0JUtvN5p2ETH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2012 at 03:59:55PM +0530, Rajendra Nayak wrote:
> On Wednesday 11 April 2012 03:56 PM, Felipe Balbi wrote:
> >On Wed, Apr 11, 2012 at 03:54:28PM +0530, Rajendra Nayak wrote:
> >>On Wednesday 11 April 2012 03:39 PM, Felipe Balbi wrote:
> >>>On Wed, Apr 11, 2012 at 03:33:13PM +0530, Rajendra Nayak wrote:
> >>>>@@ -1564,7 +1564,7 @@ static void omap_hsmmc_set_ios(struct mmc_host =
*mmc, struct mmc_ios *ios)
> >>>>  			 * can't be allowed when booting with device
> >>>>  			 * tree.
> >>>>  			 */
> >>>>-			(!of_have_populated_dt())) {
> >>>>+			!host->dev->of_node) {
> >>>
> >>>won't compile
> >>>
> >>why? compiles fine for me.
> >
> >aren't you missing the opening parenthesis ? Or is there a something not
> >shown in the context ?
> >
> Its the missing context thats confusing :-)
>=20
> This is how the code looks in the file after the patch.
>=20
>                if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
>                         (ios->vdd =3D=3D DUAL_VOLT_OCR_BIT) &&
>                         /*
>                          * With pbias cell programming missing, this
>                          * can't be allowed when booting with device
>                          * tree.
>                          */
>                         !host->dev->of_node) {

ok, my bad then. Should've looked at the source code. Sorry for the
noise.

--=20
balbi

--fKtH0JUtvN5p2ETH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPhV2RAAoJEIaOsuA1yqREDsQQAINS1PjgP4JSwNre03muMrF4
NPEe+5EJa582ebc/1NVaevNMMaXgsi8++8UT2LV7PSzxh3zDQGlDNcg624nLs570
dHAoLQAcnv/qwNSpR1CzxIFrpD0QvwilVGQdxftkJ5Ks/1KyNdFpRwpyopiCbZO5
owe7ES4dVzLF843S25UcGhPoI1eFnRtRJrWCA03MVOXD0OJOOOJF7i8hWXyy9/U5
4gl/SgvLFtHxyY9fQJwKoI/S6tkmEypDZu4S+IqdhuNhNjSvZeytZqBjeYbm04jc
qYSi5qa/iRRMyHy/DOVq7Z7wWDh6AuxzGml7GkvFYpyZSR+gXkfWgpkgcw1J6u4H
1hXKkLKT494XWf8/J/Vp88eYeUmR10Opakai+AvgqYUCUDo6cqKIG7wFUKhXF2bh
G2Y9QyF1ap6Rt1iX30vDApup4yGUKofRH7n3iAh1TfD59gTugaHUybBRGEtEH59l
PqMTNmL0IqTT+Rb37RFmFKcLii5mmcl1nghOapSfgo4ouVhU+J9mlZVdYWllQ54h
eQtumm68QQdAS5OtNYYfKbPOkCfDzcvW+7/HpPzvIsmfHPUeTpHkoP+brILHVlG2
8/3QVYyo8sV9cq6dzinXfvGGP+0d+8+40pF12CiHT1ME44YMTNStTphz9DzKlP2V
aIrdbPEkL/MN8T/qhPKl
=IWj0
-----END PGP SIGNATURE-----

--fKtH0JUtvN5p2ETH--
