From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for
 pm_runtime_reinit
Date: Fri, 12 Feb 2016 19:43:36 +0100
Message-ID: <20160212184335.GF1520@katana>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455145370-20301-3-git-send-email-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-mmc@vger.kernel.org


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 03:02:45PM -0800, Tony Lindgren wrote:
> Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind") introduced pm_runtime_reinit() that is used
> to reinitialize PM runtime after -EPROBE_DEFER. This allows shutting
> down the device after a failed probe.
>=20
> However, for drivers using pm_runtime_use_autosuspend() this can cause
> a state where suspend callback is never called after -EPROBE_DEFER.
> On the following device driver probe, hardware state is different from
> the PM runtime state causing omap_device to produce the following
> error:
>=20
> omap_device_enable() called from invalid state 1
>=20
> And with omap_device and omap hardware being picky for PM, this will
> block any deeper idle states in hardware.
>=20
> The solution is to fix the drivers to follow the PM runtime documentation:
>=20
> 1. For sections of code that needs the device disabled, use
>    pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
>    been set.
>=20
> 2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
>    pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
>    set.
>=20
> Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind")
> Cc: linux-i2c@vger.kernel.org
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to for-current, thanks!


--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWvifXAAoJEBQN5MwUoCm2u3gP/0siHYGbBX7efB637S6GialN
ufvgD31ukWw1xebwQy02EEi2d4/JU/Th2XkhulqC435TEbC2KaDKurauJ++iXIeC
qJX8tYaiZDT2w+OEzRAheoUsGBeF6bVbSUX1kLNJwXRDKBh2OOm4apr363F2xp/F
l3asdMzvthXLw38oxB/YpC5baHKNcIz59aWJKtdMmTreobvZ9ygU40iNtJsaGjdE
8UbAXFt2Ncf3vNAzVLwGfcMfxl/zbnSdSgj0VInmNe3Akt3MLo6bZZcseaky7u8q
AU6SqCrk/xr1mWi9pJBKCEqYzCMspqYOapHpa6f8uLaaTQCpUDUzWgxrbN95CTSb
FkWW4kDrc2GSHAACs7cv5uNNqbAuLmmUarej82V96VIqATPpIHYJq4bpot5EjH8K
99/2rsVAgZuHGw4j7/AuuV64FmAnTUwsVGA59VGKQIpi8Ew/Xyl3+8HFECYhl7Y/
dnxyEI4TGnAwbhgmcw/Zt4idlw9YBtuFAELAkqcFU0qMyFDm7Pm3Bz+8KaW2Dx5J
ZBX99K1zStqVS+sBoRN1bmZgDcdAh4qAxrwgnivJlxG9I+I4WqumcqsQDbnpRqE2
5M+noBKtdByQKdEgcSVmUv4LQVPFan5Jqh4kQ6FDkc+gAA4KBOLN5fyC20mWmZoV
hQkZTE6ZbbccnGLlhkX3
=Jr//
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
