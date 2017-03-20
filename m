From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: tegra: Fix setting of Tegra SDHCI module
 clock
Date: Mon, 20 Mar 2017 17:52:50 +0100
Message-ID: <20170320165250.GB14787@ulmo.ba.sec>
References: <1489742732-7722-1-git-send-email-jonathanh@nvidia.com>
 <1489742732-7722-2-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33022 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755167AbdCTQw7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 12:52:59 -0400
Content-Disposition: inline
In-Reply-To: <1489742732-7722-2-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 09:25:32AM +0000, Jon Hunter wrote:
> Commit a8e326a911d3 ("mmc: tegra: implement module external clock change")
> implemented the SDHCI 'set_clock' handler for Tegra in order to change
> the module clock for the Tegra SDHCI controller by using the common
> clock framework API clk_set_rate(). The problem is the clk_set_rate()
> may sleep and the 'set_clock' handler is always called from within the
> context of a spinlock. Hence, occasionally, 'scheduling while atomic'
> errors are seen. Fix this by moving the setting of the module clock to
> the new 'set_parent_clock' handler which is not called from within the
> context of a spinlock.
>=20
> Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>=20
> Changes since V1:
> - None
>=20
>  drivers/mmc/host/sdhci-tegra.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljQCOIACgkQ3SOs138+
s6Gb+xAAiwRTpKEy69t6J613MGEJN0uGcdKdFoQqxHliucluCIX/kkIoot80oEXx
24qfikmACEd2Ud0ZnPD4ULB787/0bmZUDhsjlmMgn8KzCAhGgn9AGCv3F7CeGati
xGJ75ny0A9oWAWR+UIRWoVdURiszEfS5dn5EjIam92+zKuOdUUqAU4lI7I9o6wUJ
WaQ6C2P8F47+2ZZPIaBeXXzO2xJeAsQgRxRY6JAZhFsU7FtpOnrEEMiqePrrqPzb
FqA50dbGqzwHCyqMthbBV9C70CexQVfzVz2H0KXBX+pdVE0nJK8OcmE/MQbsQ3m/
KKzDFucOoeWNK0CMlbDbUwmQfcQo4PFTH1YOTvIA2zayzNg3WtlJT7mzExfiH/c9
KXBff3qTFKmbM98rvQGzdLooGCX5vlEMQ0uD/80DUNnqd1VpZqrjlMBAtee6NSY6
x3qtUfk+wWpauwhvWqYQTKv6GBLfwTJr/iSEB1D7PLa/V4GMN9JkOaG7o28+90z4
DMUi2bI/ZQVqC74TOFvRjIgnsFGtTL1cs+nMkj0u9WdYl7qP0rugay9JBzHePQUL
NzgiJ+43A7D/xhbFpKkx/E6bRAqLU598rk2i5kiigsXaJShyIQJ5E2GDDEEzaSco
BiSJ6jqxtS28KFYNxpx+4N8CUkaSL89Doe8foXzVKOPH9s/9yKc=
=y1Qa
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
