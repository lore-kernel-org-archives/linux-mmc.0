From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/7] mmc: bcm2835: Add new driver for the sdhost controller.
Date: Wed, 01 Mar 2017 10:00:55 -0800
Message-ID: <87tw7c27xk.fsf@eliezer.anholt.net>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com> <1487668026-7100-3-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:60476 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbdCASA6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Mar 2017 13:00:58 -0500
In-Reply-To: <1487668026-7100-3-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>

--=-=-=
Content-Type: text/plain

Gerd Hoffmann <kraxel@redhat.com> writes:

> From: Eric Anholt <eric@anholt.net>
>
> The 2835 has two SD controllers: The Arasan sdhci controller (supported
> by the iproc driver) and a custom sdhost controller.  This patch adds a
> driver for the latter.
>
> The sdhci controller supports both sdcard and sdio.  The sdhost
> controller supports the sdcard only, but has better performance.  Also
> note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
> controller allows to use the sdhci controller for wifi support.
>
> The configuration is done by devicetree via pin muxing.  Both SD
> controller are available on the same pins (2 pin groups = pin 22 to 27 +
> pin 48 to 53).  So it's possible to use both SD controllers at the same
> time with different pin groups.
>
> The code was originally written by Phil Elwell in the downstream
> Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
> out of the original 2055) for inclusion.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Ulf, what do you need done to this driver patch before it can go in?
The commit message seems like it could use some rewriting at this point
(Personally I would drop the detailed changelogs from Stefan and Gerd,
updating the last paragraph here to give them credit), but what's
important to me is getting the driver in so that distros don't have to
carry this patch for wifi support.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAli3DFcACgkQtdYpNtH8
nuhmQQ/+KcTfXLSfCfr5vKCaHOtvahSSA6uS8r4KOQ3Dvnjzc+j5riPHFGKNPnh4
I44JjGJw0KlAacdF1gJZl0DUmJ6iTR/je55iP7Qad52m6XPNos9LHbpZGSc+YFUG
vabRNCoR2i+tbsZqzafudkgrdo+iup4PUmGt6iYji0YdEl3GUMgID95Pfqt2SEwy
1vWIghXcRF5GHTutYx0B76ncb3uGzpMWjw9Y+qqCTJfdfezPrW8TgTLNXb97jrgk
ApQ8qoLTB7C7QOfCYT1EzWkR0THEHVWKyIoUGwri4usvgIvf+rLvAxBYxSJ8U9Gi
e3k/SmM1YPvd0Roh7Ti/l77kLy7pbSRYXfpT8rvPxZdAQ1+u02TofoXarYnG6Jhk
4cyp7xlzi7xj5DDEmHv9xcEe9txYOMTyJuPnTydRfihG6NifyM30naAvIXNbc8Ir
+9MjC6+lbJCet1B5Np23k+KXADrgslGug1qQ5jswWzGigmSDaP1rSQxwqTEEg/Rk
tcynIlKrBLpBNyFAoLJYlbV9hvb3ZQI3DzWuZSUBdNLclNwMlJNyHQfjYJ9RSDCs
LTKrgkJtrh/YFjHwOT9liZcXD1ECjfREsFkenyJvBM6TeG/RTfnku6/XLD3w4cSu
iXN7zlbv1XJlvGl9Uq0vQFu+DQrmv6PtZRJyUVwJ/h9eDXB3dKs=
=Buu5
-----END PGP SIGNATURE-----
--=-=-=--
