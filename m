From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 1/2] mmc: sdhci-iproc: Apply caps from bcm2835-mmc driver
Date: Wed, 04 Jan 2017 10:16:06 -0800
Message-ID: <871swi8zdl.fsf@eliezer.anholt.net>
References: <1483111474-29907-1-git-send-email-stefan.wahren@i2se.com> <1483111474-29907-2-git-send-email-stefan.wahren@i2se.com> <87lgusngn7.fsf@eliezer.anholt.net> <1751352115.251342.1483474996021@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:48420 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757840AbdADSXi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Jan 2017 13:23:38 -0500
In-Reply-To: <1751352115.251342.1483474996021@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, Jon Mason <jonmason@broadcom.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 3. Januar 2017 um 19:27 geschrieben:
>>=20
>>=20
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>=20
>> > Since the mmc module on bcm2835 neither provide a capabilities registe=
r nor=20
>> > free documentation we must rely on the downstream implementation [1].
>>=20
>> Yeah, caps reg is wired to 0, but it can do high speed.
>>=20
>> Since we're VDD_330 only, I'm not sure the driver type flags do
>> anything, but I'm still good with having consistency.
>
> yes, the driver type flags currently have no benefit.
>
>>=20
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>>=20
>> Interested in porting over the DMA support? :)
>
> AFAIK the sdhci doesn't support external DMA (required for bcm2835).
> So DMA support would result in a new driver, which i'm currently not inte=
rested.
>
> But i've prepared a fixup patch series for the sdhost driver i want to se=
nd to Gerd.
>
>>=20
>> I also noticed that the emmc wrapper module claims it can run with a
>> clock from 50-100mhz, and the arasan says it can run at up to 50, 52, or
>> 208mhz depending on SD/MMC mode.  Could we get a boost from running the
>> module at a higher clock rate?
>
> Sorry, i can't follow. Do you mean DDR mode?

Apparently I what I was reading about was SDR104 mode, which also
requires 1.8V.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlhtO+YACgkQtdYpNtH8
nui/jxAAsDJ8FUnizuI4gNzeB8J4cJIS+IylkdVBLl9htXqNxoxWIToieUC5Q42C
xaECcCQFJaPtG9YxDrTsG8etVPnAVOuRySkePRm3QftCeNUf6Yzhf7r3ZUGeIGEj
+19jS21nxP8Vndlu3kI+5K/oJF+Yve4/YxXGdln1DFQwm2kmuUK0NJwY56vWGbOM
uHl5NVJoWApvUx6omTui40nqmtcy/mnvfJPKSiqvzkHgT3z98v9gU6bOrtS/9i4g
i8VSXvQg7wyoxYx5ofHblsj4QU+L6m4B+3FRCKhQK2f7zzeG3ej4ktnVOJzRMAS0
lXPVHk7Bp6uFdpFT47KzIt5awENoQ3tYps6UNBzVzObmi/C/TEKJScmm1/29O1ve
BEh3/EuRM3Xdzidj/ZHJaXIslle19ahQyNxM3CLaj1EuouBhOSDDhKZbAGb/N3NP
8j5J5qcHk+r+PMaKu/FeYhJZtUtVEPKECOWiqN/GInTIA36XMAXNYHkpQcijz3dO
9NiV0+t+6ECQeBUzsVkTQ2zOYm713klPEBPDhTGXsybXFN+w3T9pFL/cWo7Ispvw
NpMaT3Lff7HUsOplKmnMIA+puP97u4KF/sTu4LoVKcFsdVHSWnLgq+/8RQZXrWNl
0bnmQuFSDy7zFQZTs/QMZF/1WgK9owy3H178qY6Un2P7IZS8l4A=
=zE9V
-----END PGP SIGNATURE-----
--=-=-=--
