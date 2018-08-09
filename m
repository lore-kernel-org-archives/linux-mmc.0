From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: mmc: Add DQS trim value to Tegra SDHCI
Date: Thu, 9 Aug 2018 15:46:48 +0200
Message-ID: <20180809134648.GD21639@ulmo>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
 <1533650404-18125-2-git-send-email-avienamo@nvidia.com>
 <20180809113609.GI21639@ulmo>
 <20180809144515.06089abe@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aDj5WtVma0yWCzS8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809144515.06089abe@dhcp-10-21-25-168>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--aDj5WtVma0yWCzS8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 02:45:15PM +0300, Aapo Vienamo wrote:
> On Thu, 9 Aug 2018 13:36:09 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Tue, Aug 07, 2018 at 04:59:57PM +0300, Aapo Vienamo wrote:
> > > Document HS400 DQS trim value device tree property.
> > >=20
> > > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 3 +=
++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdh=
ci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > index 3c7960a..7d294f3 100644
> > > --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> > > @@ -72,6 +72,7 @@ Optional properties for Tegra210 and Tegra186:
> > >    trimmer value for non-tunable modes.
> > >  - nvidia,default-trim : Specify the default outbound clock trimmer
> > >    value.
> > > +- nvidia,dqs-trim : Specify DQS trim value for HS400 timing
> > > =20
> > >    Notes on the pad calibration pull up and pulldown offset values:
> > >      - The property values are drive codes which are programmed into =
the
> > > @@ -88,6 +89,8 @@ Optional properties for Tegra210 and Tegra186:
> > >      - The values are programmed to the Vendor Clock Control Register.
> > >        Please refer to the reference manual of the SoC for correct
> > >        values.
> > > +    - The DQS trim values are only used on controllers which support
> > > +      HS400 timing. =20
> >=20
> > One of these additions says "DQS trim values", the other says "DQS trim
> > value". It is unclear from the above how many values there are. I think
> > this should be more explicit. Also, I don't see why the note about which
> > controllers the DQS trim value(s) applies to is in a separate paragraph.
> > Couldn't it be moved to the property description?
>=20
> It's a single value. The plural form is a mistake.
>=20
> > Also, I think the bindings should specify which generations of Tegra do
> > support HS400. Where else are people supposed to find that information?
>=20
> This property is under the "Optional properties for Tegra210 and
> Tegra186" section and it only applies for the said generations.

What's the point of specifying that they are only used on controllers
which support HS400? Are you saying that only a subset of the SDHCI
controllers on Tegra210 and Tegra186 support HS400?

Thierry

--aDj5WtVma0yWCzS8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltsRcgACgkQ3SOs138+
s6GKGA/8CdIrC2ZwPCoGAeZaGzJRhdKYMMhZA3mE2cY0PR5ir5mTrTcUPZiS6VlR
9bwTq08preNTV7EHStY/5m36vCAqLnB765y9nBiUrHOGQqP3xJRUoQvgyaXOm7+o
7Gk7lxSgWu8oMjWXLUVbzXHGWmVkLEPPFG/xbMqcDT517Us6Ss4jY6qU+V7okGU7
+uBGQVmLWGcuc3Bp+swRAU7OhigiJa73DtMg5Z5hejXf98eexmNANBGrmRV0KUeJ
GfKBrzCYtC2eujvL0Dw6xUT98FJV3QTLQ2brr5uoecj5FR2uP4gQ30nmJbv0KCtQ
4RHVJpA/ygeBp1/3U7LK3VEzLiv2axKhK5dEcem9BfOn+P0Aew6JErQrCiS2XVsU
FVSglbNRabjgm97HCyxafRiQaHYCrqR6/ZhmZ6XpC7D3+F6aBTDMGc7gANjNei0U
J3uQO4lWq0g4JJPMZ+wkdGz11AOBAU0XQrndfoZj3tz8d6q6dbYclhLaEccbggHt
RK/IIQntRyb2W/54bAoQa3imDVyp2aKlENfcguzt+S/4ReFbzIgmUGvL0lrRc5wB
i2ZxIhEY1qgZ4xxlWidzEG/iFQE+gZJ4HRpyzDyNIGt49KZYvF4gurr0835ezVXt
EsGvP9ViMUZQSOj2OS/zPlDnAzMvMM8AqPUy2MS3ZhI/8gM4IhE=
=qr0G
-----END PGP SIGNATURE-----

--aDj5WtVma0yWCzS8--
