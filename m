From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 5/8] arm64: dts: tegra186: Add SDMMC4 DQS trim value
Date: Thu, 9 Aug 2018 15:52:16 +0200
Message-ID: <20180809135216.GF21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-6-git-send-email-avienamo@nvidia.com>
 <20180809114922.GN21639@ulmo>
 <20180809150226.64657f56@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="py13wRIzy9nU46ee"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809150226.64657f56@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--py13wRIzy9nU46ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 03:02:26PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:49:22 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 05:00:01PM +0300, Aapo Vienamo wrote:
> > > Add the HS400 DQS trim value for Tegra186 SDMMC4.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra186.dtsi
> > > index 6e9ef26..9e07bc6 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> > > @@ -313,6 +313,7 @@
> > >  		nvidia,pad-autocal-pull-down-offset-1v8-timeout =3D <0x0a>;
> > >  		nvidia,default-tap =3D <0x5>;
> > >  		nvidia,default-trim =3D <0x9>;
> > > +		nvidia,dqs-trim =3D <63>;
> > >  		status =3D "disabled";
> > >  	};
> > >   =20
> >=20
> > Isn't this technically dependent on the board layout and as such would
> > belong in the board DTS file? Or does this value work on all existing
> > Tegra186 platforms?
>=20
> This value is specified as part of the controller initialization
> sequence in the TRM. I've understood that this (and other tap and trim)
> value(s) are used for compensating the propagation delay differences
> that are caused by the internal SoC layout.

Hmm... it would seem to me like the routing on a board would have a more
significant impact than the SoC internal routing. But perhaps the board-
specific routing is actually what the automatic calibration is used for?

Anyway, if it ever turns out that we need slightly different values on a
given board, we can always override the value in the board DTS file.

Thierry

--py13wRIzy9nU46ee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRxAACgkQ3SOs138+
s6GlhxAAj/a6meiHIxY5TFAsnZb/aNtRSgkDmy2CGv4Bpdl4HUedX4+bflQcv66a
IoNqAApjYRXVdBNZfkAH78MQV157U99U5hone+1RHzJFsybW7cXem+qSACQBXFLV
378VghbCmtZspJ9afGAFxdkkkPKorK9uMmip3PUS0Wz8c2RKf5YL113FrkUoOJDE
cbkjYrj3WYz0wL3o9n1/FyYKeNfFg12fN1zO7afmxHag+f6IeWzynb2kqEUwBniC
Em1F1vVfNdI4gbREXFfQOESkJQzG42hWACYCm86EQ57IbtVrP4e3cyi4BDIeEG93
bhy2TuhL+ETmp2HYhgq/0lXELb727jmrwfQ/E3vVTpHf0+sbPrxBaeKf2k9cmNM2
BadcdjXAPrLwJ4oe7jib5iX61+aXz1DBfGJnATe9hg9YvdNgF8R/460Ql2W/g+T+
Io3Vwke6nQc8OJQgpiruQ5IBYSpzp9iHMT7yw8K44jf4fLcno97dfg1kOrcayF9q
5L93aawL3ZHuGT+Tml0v52u2OfOfsrloV4Tnqj6yWe6/6quVXmHrObf1xK8IYO6a
U1l5uaQcZX221F+5Bia6hnEQfkoR4JfhOUaU5bjKNA6ReKt08bSxaFkQZ9ARy6h7
X8dqmoU2EMO3uYDCdHlWC/b8YN0KLAyfps8banXV4mRzUDuBz5M=
=q8pn
-----END PGP SIGNATURE-----

--py13wRIzy9nU46ee--
