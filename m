From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V10 3/4] mmc: sdhci: Add ADMA3 DMA support for V4 enabled
 host
Date: Wed, 23 Jan 2019 10:15:32 +0100
Message-ID: <20190123091532.GB24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
 <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548186993-6229-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:32AM -0800, Sowjanya Komatineni wrote:
> Below are the supported DMA types in Host Control1 Register
> with Version 4 enable
> b'00 - SDMA
> b'01 - Not Used
> b'10 - ADMA2
> b'11 - ADMA2 or ADMA3
>=20
> ADMA3 uses Command Descriptor to issue an SD command.
> A multi-block data transfer is performed by using a pair of CMD
> descriptor and ADMA2 descriptor.
>=20
> ADMA3 performs multiple of multi-block data transfer by using
> Integrated Descriptor which is more suitable for Command Queuing
> to fetch both Command and Transfer descriptors.
>=20
> Host Capabilities register indiactes the supports of ADMA3 DMA.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
> 	into seperate patch=20
>=20
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMLQACgkQ3SOs138+
s6EavhAAudFsfnYNJZTEr8sMOY/ebBedQ38LJY9rBEVW8M4STWhN6P3wpbFT/nF0
6K42ZkR0sogXsKpvmX+OrLE6nEK3rm/4jQnAa1VWgDXyPFb7up0oevMQ2vQ7Z6aM
D1wJ/swiIfptDmI8jOAZg79giOHsSLCJ7LA4kq91nD/PZI7RCHUNpd6DIOd4nB3a
pKE7XEOT8h9/voL9kt5KZuEPSo4rTnRssQvxn/e+63ovzeU9TljYpJ4vCRxC+EPT
ClUDSbHzK/0FeAIG0mTR32v3OHlssrOFUDD1To6b48hVP7o5/WHwG+olkYTR2RhS
GYDooX41OFuBFF7g491fYcJpXdoiCO0XdTqrLhPW0Oooe64DpFX/BHqA6yrotvBW
nQ0L7mzhfTFXSlfXo4NcnnTPDvCw7dbKmv6SaS75p5MiJ6t4vGdSj+ZGJv3LntVw
cGpPJ4y6MDZ6LCrEpZm5eV514tHezPMklY2DVKRJKPOqZF03mS06RQlSuNNbtpN2
mJFdaL68fP41jY1+jUIdSLzbCIeX1uieHgLo9/VxbYHoqmWaWa0edTIhyvsUarHC
cypLR6z649URlZLGgGf4lO9C14N6l5foFpPU5ucxvoxfpHpKiKXmYYvgsBy0buuW
v9HLYwxiIcMzBmWbEh2cRfcsUGmATAGy0riLVcae2FL90L745q4=
=FPU6
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
