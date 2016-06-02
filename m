From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 32/32] mmc: bcm2835: Import bcm2835-mmc and switch to it
Date: Thu, 02 Jun 2016 14:40:13 -0700
Message-ID: <87d1nze0ci.fsf@eliezer.anholt.net>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com> <1464817421-8519-33-git-send-email-kraxel@redhat.com> <e16936ee-3b0d-3798-72e0-8969c2c1a309@i2se.com> <87oa7j314j.fsf@eliezer.anholt.net> <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:38041 "EHLO anholt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998AbcFBVkk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 2 Jun 2016 17:40:40 -0400
In-Reply-To: <2100811505.238666.65d5fa25-985a-4a30-86e2-3a7bebb5caaf.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>, Lee Jones <lee@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>, open list <linux-kernel@vger.kernel.org>, "open list:MULTIMEDIA CARD MMC, SECURE DIGITAL SD AND..." <linux-mmc@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, linux-rpi-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
>> Eric Anholt <eric@anholt.net> hat am 2. Juni 2016 um 20:18 geschrieben:
>>=20
>>=20
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>=20
>> > Hi Gerd,
>> >
>> > Am 01.06.2016 um 23:43 schrieb Gerd Hoffmann:
>> >> From: Eric Anholt <eric@anholt.net>
>> >>
>> >> With this we can get wifi (brcmfmac) to probe.  Without it we're stuck
>> >> with timeouts from sdio.c when it tries to set the bus width to 4.
>> >
>> > adding a new MMC driver to fix a wifi issue is really weird.
>> >
>> > Beside that there are already two MMC drivers (sdhci-bcm2835.c and
>> > sdhci-iproc.c) in the Kernel which are compatible to BCM2835. Why shou=
ld
>> > we add two new ones?
>>=20
>> Despite the fact that this is my commit, I don't think it should be
>> merged.  We should figure out why sdhci-iproc.c isn't working, instead.
>
> so it doesn't work with sdhci-bcm2835 on RPi 3, too?

Correct.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXUKe9AAoJELXWKTbR/J7ofNkP/1Qezzdo8bwkjlhqFVq/PRs8
3PKczEw38J71lAWDoFJz8Mjm+QIZ4cB4sbdGN+5FTYDS9E7pzDmr+xNrfJMsuUio
qxs8SUdanAEGFFQz3bojQhn0zYhKNIFgPmXu0h9TccQ5g6hJLzxe1qk09X3DPfug
GdMRi+29HSram8C2Ux5NYNHlBjs5BkbqZwnQ2VfzoGea2bmUUMPTzx7IZCtEfQK1
RZhQ+O2buyCjmG/DAfvYu8FQg240IrD2kZkzB5UERow0f9az2Xy95af0kQDF7igO
JMVVAafVDtchM5OQOqOjSCLkOJThatU7gje/P0v51jTy7lCXPOHnYS+ibzsPFASl
DtfT3g4uXUpaDh8NRh5JCNG4kNh0JK/BiOuXMCBFaujHrOtDoyyjWUFSEksVmu39
twp6WfsAjEdMpX69TU2oX0XVVTy63kGJ8TeOhnY4ERUBWCkKuKFY9IeeUOWrxPJB
eOEnzQaytTMpLQLMLumQriNy3AYGA5+rDTAD8AR64WKgwk/w1n5ZGKOkELOYecmh
OfZUUkIomZlfI+yOV6tomKIsv/5aKCEw+5bPUf/J7eb3apE/jhY4tWHdoDE4COwn
HyHxW/kamOidKg4huqiPt1DQ+eFQuZ/qcLVF6J68PCMQAYKLfGH+hxICFzNe5Ez/
rcwrhTCScZY5x3UpMUfw
=Yi0S
-----END PGP SIGNATURE-----
--=-=-=--
