From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/7] mmc: bcm2835: Add new driver for the sdhost controller.
Date: Wed, 01 Mar 2017 11:31:31 -0800
Message-ID: <87varsequk.fsf@eliezer.anholt.net>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com> <1487668026-7100-3-git-send-email-kraxel@redhat.com> <87tw7c27xk.fsf@eliezer.anholt.net> <68761051.37200.1488396112552@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68761051.37200.1488396112552@email.1und1.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>, linux-rpi-kernel@lists.infradead.org
Cc: will.deacon@arm.com, linux@armlinux.org.uk, lee@kernel.org, rjui@broadcom.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, sbranden@broadcom.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, mark.rutland@arm.com, f.fainelli@gmail.com, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Eric Anholt <eric@anholt.net> hat am 1. M=C3=A4rz 2017 um 19:00 geschrie=
ben:
>>=20
>>=20
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>=20
>> > From: Eric Anholt <eric@anholt.net>
>> >
>> > The 2835 has two SD controllers: The Arasan sdhci controller (supported
>> > by the iproc driver) and a custom sdhost controller.  This patch adds a
>> > driver for the latter.
>> >
>> > The sdhci controller supports both sdcard and sdio.  The sdhost
>> > controller supports the sdcard only, but has better performance.  Also
>> > note that the rpi3 has sdio wifi, so driving the sdcard with the sdhost
>> > controller allows to use the sdhci controller for wifi support.
>> >
>> > The configuration is done by devicetree via pin muxing.  Both SD
>> > controller are available on the same pins (2 pin groups =3D pin 22 to =
27 +
>> > pin 48 to 53).  So it's possible to use both SD controllers at the same
>> > time with different pin groups.
>> >
>> > The code was originally written by Phil Elwell in the downstream
>> > Rasbperry Pi tree, and I did a major cleanup on it (+319, -707 lines
>> > out of the original 2055) for inclusion.
>> >
>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>>=20
>> Ulf, what do you need done to this driver patch before it can go in?
>> The commit message seems like it could use some rewriting at this point
>> (Personally I would drop the detailed changelogs from Stefan and Gerd,
>> updating the last paragraph here to give them credit), but what's
>> important to me is getting the driver in so that distros don't have to
>> carry this patch for wifi support.
>
> I'm still working on 3 small patches for this driver:
>
> 1. trivial error in a register comment
> 2. ignore SDCMD_FAIL_FLAG during bcm2835_finish_command (downstream [1])
> 3. remove unnecessary call to bcm2835_reset_internal
>
> I plan to submit them on Friday.
>
> [1] - https://github.com/raspberrypi/linux/commit/711cade866c9f865f9b283c=
9369e9486f27d1fec

Should any of those changes block merging the current code, though?  It
doesn't sound like it to me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAli3IZMACgkQtdYpNtH8
nuirAA/7BrFYXS8eOtoDt0P02mqQhWXj0PuZBkCr5iMU2Z7mQQBr8s0GPj5SPSto
QThZ5InUw+fl0X4La0O8mNcCRV/ntyZgCNVT60yvkhHzvzQaQMAo/pe/+Zy2rWpj
BN3SuzFp3Gh0k5tKnkzaS5agsDR2mpyjBq1jdrMzOCAto3NhBSDPYRGBQE9Fz1gJ
+AsjcWBDhbJWbemGkD/Fd6uDQVQjXD+mUgcMt7K6ZklL23ARA+gkJjKAUuspARCS
v+goQguCUNesVFym1oZEdrqLyDXJxX5cIOcmscD/USocz5Km054x8/LWtn+fPfY0
fnXedxDoKk5ahHfKCmJKimHjYX5ge0Cf+cW5Ya/bF5W95HMPv3+udih7Am9deut3
w7rq64JwajAlcQ0NOYl9DkXrwb+hcgslp5i88Lt4kxNOKgG+QH7TDJ+yMLOX3sll
IKaWYS6IaLqgJuBUoL1icaCdCi3gXY824o1Y8mOHaVL9CYONYwTCTx+O3OSszDsT
jgMzN1D9MNQ5Aalilnvgnqnt0fCglSg7vki3MrW/VCtHxn772draHkFhpjecHdVN
IuGM1vlTEKpVuQT1RPKEAkJ5D5tvzjsTZPjtoBVLjpX42H4VIuI4rT6wAgILqGqk
lc7hzm+3CVJ9riTWHXpZQu0UpOo9Dq/Yof0SrAVDnXkq4852u/o=
=UZQ5
-----END PGP SIGNATURE-----
--=-=-=--
