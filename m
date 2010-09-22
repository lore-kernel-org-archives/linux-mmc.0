From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Wed, 22 Sep 2010 16:12:23 +0200
Message-ID: <20100922141223.GF2693@pengutronix.de>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de>
 <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de>
 <4C9A0518.3090904@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41245 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0IVOM1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2010 10:12:27 -0400
Content-Disposition: inline
In-Reply-To: <4C9A0518.3090904@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peppe CAVALLARO <peppe.cavallaro@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peppe,

> 1) I've already a patch to add the suspend/resume in the sdhci_pltfm
>    driver. Please note this is mandatory for me.

Great, improvements to the generic pltfm-driver are most welcome!

>    Note: I'd like to look at the wake-up on card that should be nice to
>    have in the future. IIUC, it is missing in the sdhci. Please correct
>    me if I'm wrong.

It is not in sdhci yet. Please make sure to send very early RFC-patches
here, so we can see what you are aiming for.

> 2) sdhci_pltfm_data has a "quirk" flag but IMO the quirk macros, that
>    currently are in linux-2.6/drivers/mmc/host/sdhci.h, should be
>    moved in a separate file:
>=20
>     include/linux/mmc/sdhci.h or
>     include/linux/mmc/sdhci-quirk.h or ...
>=20
>    I don't know if it has been already done but I could create a patch
>    for this too. Let me know the name convention you like, eventually.
>=20
>    Otherwise, in my platforms, where I need to set this flag (e.g. the
>    sdhci-stm needs: SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC), I should include
>    drivers/mmc/host/sdhci.h?!? I don't like it :-(
>    Please, correct me if I've missed something.

You are correct. So far, all users of the quirk-flags happened to be
inside the host-directory. If you happen to have a controller which only
needs quirk-flags and no custom functions (congrats! ;)), then those
quirk-flags really need to be moved, so your platform code can find it.

I'd go for sdhci.h as the name. Be sure to catch all users of the quirks
to include your new file.

> 3) In the end, another hook could be added in the sdhci_pltfm_data to
>    invoke specific own functions for claiming resources etc.
>    For example, I need an extra callback to invoke the STM pad manager
>    that's used for managing clocks, PIO lines and syscfg registers.
>=20
>    I'm thinking about something like this:
>=20
>    struct sdhci_pltfm_data {
>         struct sdhci_ops *ops;
>         unsigned int quirks;
>         int (*init)(struct sdhci_host *host);
>         void (*exit)(struct sdhci_host *host);
>         int (*claim_resource)(struct platform_device *pdev);
>                  |
>                  |_ we can use another name.
>    };

And init() is too late?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyaDscACgkQD27XaX1/VRu+IgCdGM5aBNikS7X3J+n8sZFXbU8Q
KM0AoIIEQTTSY0hP5I280JUZRrd/L3Ve
=Qjxh
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
