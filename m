From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 1/2] mmc: sdhci: Add support for setting parent clock
Date: Mon, 20 Mar 2017 17:52:18 +0100
Message-ID: <20170320165218.GA14787@ulmo.ba.sec>
References: <1489742732-7722-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489742732-7722-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 09:25:31AM +0000, Jon Hunter wrote:
> It is common for SD/MMC host controllers to set the parent clock that
> drives the SD/MMC interface in order to support various operating
> speeds. Typically, this is performed by calling common clock framework
> APIs such as clk_set_rate(). The problem is that these APIs may sleep
> and must not be called from within atomic sections and therefore, these
> functions cannot be called within the existing 'set_clock' SDHCI
> operator because they are called from within the context of a spinlock.
> Add a new 'set_parent_clock' operator for the SDHCI driver that is
> called early during the SDHCI 'set_ios' before the spinlock is aquired
> to give the platform driver the opportunity to set the parent clock
> rate.
>=20
> Please note that the Tegra and MSM SDHCI drivers currently appear to
> mis-use the 'set_clock' operator by calling clk_set_rate(). In the case
> of Tegra, occasionally but not always, 'scheduling while atomic' errors
> are reported (so most of the time we are getting lucky). In the of the
> MSM SDHCI driver, it is releasing and re-acquiring the spinlock which is
> bad.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Changes since V1:
> - Fixed idiotic copy-paste error and testing thoroughly!
>=20
>  drivers/mmc/host/sdhci.c | 3 +++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 5 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljQCL4ACgkQ3SOs138+
s6HyIg//YxnQMIQVmFmTvURzNnEmcZdwzX7mhdKEGx8T73wuSntPt0SZwZWcakmA
RVvFfnaTPACCcBLTKDY30L0BtDFvVHtM3GUYu1b7L/1hYnKm0GwrgVLctlql4zG+
q5c/6yPFlJ5ZeSdTIkSsd7/4gPQQIdMbB7TkvmpxqLIgYIZ/sWxBLrxcYHT4CZoz
SbdTVeVh7s2K0fYx8NIC+SEyfWE2PsNurfjy7aBEBWqXxcNkt9e4U6y33bqzyTm8
Mu5M4kwEGY+0lAYVeihBFDEh5l8Szge8Dm3vSzw6qp2317aJjQ5gDZiYmVvV7GDy
F0JI7fZYoG5UXE0EaU7f2dmwU5UlOnq1tOLr0oUwj5XytoSH0GFZGvQxMQ6SqIKu
n8Tczvdc5zQGkpJOXI1eu5JNO/1q6NRIo5A8pLUBmR5FoQEFSY5UFCt47qB32qvE
FViBMmHV+N8i+YPDkvJC92SYlggDLX84HCv84qBVjfDAJwsCGlPmT8IwzqgXHfqk
TZHTU+FdEXs5QIKaHGJT4uTp8kevsqlXFSXGBE53SVRdICq5q8vwvgyakXA39Wil
vbkb/bNMm3y1wGTINL6qSlKk7QMZyPPlUngxKGQ9YjYViNH6EmDrzInkkvkmX3J+
8XdPWwruUnk/k/ffCEbEMYpLq9AdQxPp9orEbpptE93+GRUr4Tw=
=bffC
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
