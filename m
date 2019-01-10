From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Properly set DMA mask
Date: Thu, 10 Jan 2019 17:01:57 +0100
Message-ID: <20190110160157.GA27895@ulmo>
References: <20190104104753.3383-1-thierry.reding@gmail.com>
 <a960e9a7-ff86-b000-1319-df85741fb380@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a960e9a7-ff86-b000-1319-df85741fb380@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 10, 2019 at 04:11:33PM +0200, Adrian Hunter wrote:
> On 4/01/19 12:47 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > The implementation of sdhci_set_dma_mask() is conflating two things: on
> > one hand it uses the SDHCI_USE_64_BIT_DMA flag to determine whether or
> > not to use the 64-bit addressing capability of the controller and on the
> > other hand it also uses that flag to set a DMA mask for the controller's
> > parent device.
> >=20
> > However, a controller supporting 64-bit addressing doesn't mean that it
> > needs to support addressing 64 bits of address range. It's perfectly
> > acceptable to use 64-bit addressing for a 32-bit address range or even
> > smaller, even if that makes little sense, considering the extra overhead
> > of the 64-bit addressing descriptors.
> >=20
> > But it is fairly common for hardware to support somewhere between 32 and
> > 64 bits of address range. Tegra124 and Tegra210, for example, support 34
> > bits and the newer Tegra186 and Tegra194 support 40 bits. The latter can
> > also use an IOMMU for address translation, which has an input address
> > range of 48 bits. This causes problems with the current algorithm in the
> > SDHCI core for choosing the DMA mask. If the DMA mask is set to 64 bits,
> > the DMA memory allocations can (and usually do because the allocator
> > starts from the top) end up beyond the 40 bit boundary addressable by
> > the SDHCI controller, causing IOMMU faults.
> >=20
> > For Tegra specifically this problem is currently worked around by
> > setting the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk. This causes the DMA
> > mask to always be set to 32 bits and therefore all allocations will fit
> > within the range addressable by the controller.
> >=20
> > This commit reworks the code in sdhci_set_dma_mask() to fix the above
> > issue. The rationale behind this change is that the SDHCI controller
> > driver should be the authoritative source of the DMA mask setting. The
> > SDHCI core has no way of knowing what the individual SDHCI controllers
> > are capable of. So instead of overriding the DMA mask depending on
> > whether or not 64-bit addressing mode is used, the DMA mask is only
> > modified if absolutely necessary. On one hand, if the controller can
> > only address 32 bits of memory or less, we disable use of 64-bit
> > addressing mode because it is not needed. On the other hand, we also
> > want to make sure that if we don't support 64-bit addressing mode, such
> > as in the case where the BROKEN_64_BIT_DMA quirk is set, we do restrict
> > the DMA mask to fit the capabilities. The latter is an inconsistency by
> > the driver, so we warn about it to make sure it will be addressed in the
> > driver.
>=20
> sdhci_set_dma_mask() was added because people did want sdhci to set the D=
MA
> mask.  Also using 64-bit DMA even with 32-bit systems has the advantage of
> reducing exposure to problems i.e. the same logic is used with the same S=
oC
> irrespective of whether or not it is in 32-bit compatibility mode.  So the
> policy for sdhci is always to use 64-bit DMA if it is supported.
>=20
> I suggest we add a new sdhci op for ->set_dma_mask() and call that instead
> of sdhci_set_dma_mask() if it is not NULL.

Some drivers are already doing something similar by overriding the DMA
mask again in ->enable_dma(). I had briefly considered doing that for
Tegra, but after thinking about it, it just became clear to me that we
shouldn't need to override this in every driver. I just don't think it's
correct for the MMC core to muck with the DMA mask. Just because the
hardware supports the SDHCI 64-bit addressing mode doesn't mean that all
64 bits can be addressed by the hardware. The DMA mask defines what the
valid address range is for the device and it's already conventional for
drivers to set this early in their ->probe() implementation (or have the
bus set it up). It seems wasteful to have to redo that in a custom
callback.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw3bHEACgkQ3SOs138+
s6E+6RAAo9MUU0egJn3CJ3V1aQt88FFoh/K8sq/6CWkSiEGgkZ9yl1eHE5KS5a7l
jZ/UD9Q6mtU2DgdGO/k7as8Up2f2/OhSgJQR3sKGuph6D5shSChThqsO/wT0fODY
wja5kmbFNhzi+U9Ernu+jj/E7DSnFDZ6q1V9KAyxDagxVsPNSgKItkOZQoLbrVdo
i3yx81yaSEUV33FYx64dQGj/YGJ655lxo+Y2EMEc212kqeLRurCWlJqoz/iLQGEn
hS+uwgNo55LvvI1BziNlWXHnMMiD/Xr3n9LAOppKpg5w1ZBIqln5GPLEr58O0SVF
MFHmi3BRSvv/Fy5YaN7nJDO3UWvP1/airrHnM9dkOL3WVEmQJaz99pEpecd8ENtG
yQKO71lQ0TdS0f311MZg+78Vp4zysmzTEXB6Ossf7nGNDdiJAKFnVss79qJG7oKk
sT+Ayha478Eib/NAvWTezkWbUwKqdTX0e/9Vj/7gXZeIUQ/S4LrzapkknqjssDnG
Mr0jmG/o+/CgLD3x2fOmcHLuGvnxRBfmpqAf9qRTCg+8B0txG12cPvN03oY3mUPF
Nd+W0D8jllrge/B5/ota0+j+mFWOc7d0PMFoe04KgeBEnJxGRhgTXuWI6+XgJHMI
/WXWaRaCRxfeFLROwiF+lDs6ZSGbORO1IXDQXuLifU31vDtlJ7U=
=mm9/
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
