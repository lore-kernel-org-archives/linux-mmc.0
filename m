From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH V7 1/2] arm64: dtsi: Fix SDMMC address range
Date: Thu, 10 Jan 2019 15:47:31 +0100
Message-ID: <20190110144731.GA25353@ulmo>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-2-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1546457808-18270-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 11:36:47AM -0800, Sowjanya Komatineni wrote:
> This patch fixes the SDMMC Controllers address space to be exact
> defined register address range as per the design.
>=20
> SDMMC Controller supporting Command Queue has CQHCI registers at
> offset 0xF000.
>=20
> This fix helps to identify the Tegra SDMMC Controllers supporting
> Command Queue based on the size of address space.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 +++---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

After applying these patches I'm having second thoughts about the DT
aspect of this. I know you and Timo had originally argued to advertise
the capability via an extra property in DT instead of updating the reg
property. In retrospect, I think that's the right thing to do, after
all.

The problem I'm running into is that if I apply patch 2/2 without the
first patch, then both Jetson TX2 and Jetson AGX Xavier crash on boot
because they try to access these registers (the I/O memory size is
0x10000 for all controllers). So we're effectively breaking ABI with
existing device trees.

I don't know of a way to work around that other than the separate
property. Would you mind changing the series to contain:

	1) a patch updating the device tree bindings with the new
	   optional property that would mark SDMMC4 as CQE capable
	   (make sure to Cc devicetree@vger.kernel.org on that patch)

	2) replace this patch by one which only adds the new
	   "supports-cqe" property

	3) update the second patch to make the decision based on the
	   flag rather than the I/O memory size

Sorry for the back and forth on this. I evidently hadn't thought this
through.

Thierry

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3WwAACgkQ3SOs138+
s6Er5hAAjcqLKJlSzT0ipK8NA2g937YzOBD4HRe/jMLXTbDcpjYTzndQVNGCttsY
Zjw4SPTxjZRBEOZsb3DKmYWCbriqVJpi3Ym2JiG6afv/BVw0UlYmOhp9uBOlzp+Z
MSXtkkwA5QKMUT+BYwhnTR50SzA0EBD/LCrCJKRX9Gr7d7XrZjgaGVMo/yIp9isj
xYVZbg3+iKdf+U3bEQOYKWw53mg8+Zb91voWX/M+yEfRwjTPOH4Wu4B8geHQxCgo
TX6uMZrJQvJX0N3puGaxZp/SzE8qficNnJXXPRSXQjXqRm5P73BN3D/1GZxJUlcb
sIx0hte4/B9R/9N9OvpSsQAYPZzTXwG1khOcpU3lIzfozsttDCOvWoJCSXegaWFv
BaKcwYj76luUxtiP39Fboe/aYROA+c1m5wl7uMz2/Gh921LbAuVCundN5f7VzH7g
fiHcDX5DRtIF9qBHA5pXOueM6DXZS2Fh2StJBoqcVv9efFF5bogOoP/GgCJmjk7Z
fvZu/KJkqitcNUAg3HuQ+JndDSz3s79ddU5zN7E7EAcHQxXX2HICPx5fhK4RDXei
WK8WMU5kZmCN6xHBtAKYJgdZhjv3ySc1XNnJTSzcrcfZdE8KrwwNorMCALNfy3hU
bam38+6lFyHNxrnSG+7CF0ySc6nZ07P/8XCFl+ZIP+YGDiD0ILQ=
=JW8s
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
