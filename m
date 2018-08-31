From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 11/38] mmc: tegra: Reconfigure pad voltages during
 voltage switching
Date: Fri, 31 Aug 2018 15:59:45 +0200
Message-ID: <20180831135945.GA7926@ulmo>
References: <20180830150639.21048-1-avienamo@nvidia.com>
 <20180830150639.21048-12-avienamo@nvidia.com>
 <CAPDyKFpnoWq36RoJKSDHD7Wtn-x1iqbD_Jy1kg2ncewe-HV0OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpnoWq36RoJKSDHD7Wtn-x1iqbD_Jy1kg2ncewe-HV0OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aapo Vienamo <avienamo@nvidia.com>, Thierry Reding <treding@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 03:16:17PM +0200, Ulf Hansson wrote:
> On 30 August 2018 at 17:06, Aapo Vienamo <avienamo@nvidia.com> wrote:
> > Parse the pinctrl state and nvidia,only-1-8-v properties from the device
> > tree. Validate the pinctrl and regulator configuration before unmasking
> > UHS modes. Implement pad voltage state reconfiguration in the mmc
> > start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
> > and add set it for Tegra210 and Tegra186.
> >
> > The pad configuration is done in the mmc callback because the order of
> > pad reconfiguration and sdhci voltage switch depend on the voltage to
> > which the transition occurs.
> >
> > Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
>=20
> Applied this one the rest of the mmc changes, up and to patch27.
>=20
> Those changes I haven't picked in this series, I am assuming those
> will go through some another tree? Thierry, will you pick them up?

Yes, I can pick up the non-MMC patches into the Tegra tree. Can you also
look at the following two series and pick them up if you don't have any
further comments?

	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D7351
	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D9537

For the former, patches 1-4 should go into the MMC tree, and for the
latter you already picked up patch 1, so only patch 2 remains.

Thanks,
Thierry

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAluJSc0ACgkQ3SOs138+
s6Hm9RAAle9Tm1bRz9/oTHcre/zL6ZDYptbEClBH002obyyQZCDuznOBXbujTYLA
uX5YDTpBE07AAaTQO1n74nrldZN0WmGVrs9coOi+be0E+3Am+Dgrj2vn/GuMeU6T
rlN38SDeoTTjPP/qC6Mhw+6v2wRa2bn/JuVvShmND9u8bAOeqx/tG+GVY3b0rW0q
oou+8HpQaGEdN9BNqLTI2aej2zczqSNI0BdTlqYDUJoA2iovWkdUrJMz5okEiCc4
s45HvaYrnRfo2oKWap8cCnwVzXF/0glJRNJAXFM9bZLo52q58KeK1tPtwyfOJaIR
OdA0viIXGMpjU4cc4QqDxujgf5nKfE2r2p+RqWVOTEawi02ECw4v1WZGLbx0o+KO
npXaTD3OQIrJtGOtIT0WEHmI3FVDo72yYpsNAbxoGdhnHRaO/E99Pp4WqTsWxaTw
re+iXcOcESoOpAKkNyUkwkFS0tY7qfr4+zVLslRS1fpCOZeKikKvR64QPjwx558Y
MdKE8zdfDuWcgfq6fHuhCW96jXe0WzqtADzem5oU8ZP76KsX5yYxf9JilbCJpfkO
MLJUKIaKGx2dVQ36/S33ugIKx5VZ0OgmlUUyQKdui4X1e6sfuTvY71TTqkxyCpeS
tiUCE4tlkGeICKjKL5Eyri1kzRGDx5l9jB/hSexEsHLrh/Mvo7s=
=d2pb
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
