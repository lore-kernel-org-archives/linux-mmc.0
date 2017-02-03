From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 4/8] arm: set CONFIG_MMC_BCM2835=y in bcm2835_defconfig
Date: Fri, 03 Feb 2017 09:26:14 -0800
Message-ID: <87inorp4nd.fsf@eliezer.anholt.net>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com> <1486123913-31705-5-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:50002 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdBCR0R (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 3 Feb 2017 12:26:17 -0500
In-Reply-To: <1486123913-31705-5-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>

--=-=-=
Content-Type: text/plain

Gerd Hoffmann <kraxel@redhat.com> writes:

> ---
>  arch/arm/configs/bcm2835_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
> index 4b89f4e..3767c24 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -92,6 +92,7 @@ CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_IPROC=y
> +CONFIG_MMC_BCM2835=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y

If you end up resubmitting this, could you extend the commit message of
the defconfig changes to explain why it's being done?  Something like:

"We need to enable this controller so that we can switch the SD card's
pinmux over to it by default, which will improve storage read/write
speed."

(even better if we have some sort of stats on how much better it is).

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAliUvTYACgkQtdYpNtH8
nuhnwhAArIo0CGRhU4Vvixs04z84mvIhxontaANi7PBo2ulrtOhdqhAYakf5kYOh
5oIHhpkAgBjwTWpL0FtPyzJ3Gj1qdUMxb3sCF9ZHk6How79qDk/inbN9If4ppbY5
wrTX8rVc3Spefa3hY2aDXeNiDhMwhx6i/NAE18l6d2VGAjSpOfiismW7/QLu0Ti+
H5CBPT/RfJMX+PMEq5izUAJoiMPJwDzy43ac314GQrMmcJ2zoN4RKBtdFPQbvnAt
JaBr8xjDUYolluwXfyjGgzs/VZfZNCR6U7kelrVbV+1GtKSuhF3GxUii1bs9ob8j
bhwtiiIJFMf5sXZUxmmyUlzaPOb0RobpR5CDFQV4Ebfs9Pq6mA3t4uSR/XAxxspI
1CShsprzuumcHGCPWuuPz7nbyMvyJoY11pO3mrz0PfaZpTHN3GyRR+rlx2p6YDDS
IUL9kn6iZAfEp9lWtvrI0b5BFwTce5DT1huvXILgYLBYwtYQqTu7aDnAzPeZYtyz
g+9u/gZRg/ILXcbTcadhiwl2QLzpxNW+dAKCqpW8DrnGhddlOOywz9RT7wH3Ebqt
Yo2reTmhodyJYC/FxdDMUWmIoe1UQWJFtGda/ZMwhIGigc7qfxoszDVNWC2pyJdg
8TuAkfJpB1jmUo3SRQjyTgp+xgA0hSTdIIRP7y84mDmdSK103HA=
=1TEz
-----END PGP SIGNATURE-----
--=-=-=--
