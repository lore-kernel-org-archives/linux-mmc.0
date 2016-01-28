From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 0/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Thu, 28 Jan 2016 14:19:56 -0800
Message-ID: <87mvrpfisz.fsf@eliezer.anholt.net>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com> <87bn8hcmjr.fsf@eliezer.anholt.net> <374314185.237972.d69bddce-8c03-4cf7-b6d6-f0cbd113f569.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:44967 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933533AbcA1WT7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 17:19:59 -0500
In-Reply-To: <374314185.237972.d69bddce-8c03-4cf7-b6d6-f0cbd113f569.open-xchange@email.1und1.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Jon Mason <jonmason@broadcom.com>
Cc: kernel@martin.sperl.org, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

>> Eric Anholt <eric@anholt.net> hat am 19. Januar 2016 um 22:00 geschrieben:
>>
>>
>> Stefan Wahren <stefan.wahren@i2se.com> writes:
>>
>> > This patch series based on the suggestion of Scott Branden to implement
>> > bcm2835 support into sdhci-iproc [1].
>> >
>> > These changes provide the following advantages:
>> > * no need to maintain a separate driver for bcm2835
>> > * improve support and test coverage of bcm2835 mmc support
>> > * get the rid of SDHCI_CAPABILITIES hack in bcm2835_sdhci_readl
>> > * increase write performance by avoiding delays in write ops
>> >
>> > Patch 1 and 2 adopt two sdhci-bcm2835 fixes to sdhci-iproc. The third patch
>> > tries to specify as much quirks as possible in the bcm283x.dtsi as possible.
>> > Patch 4 and 5 are the actually changes for bcm2835 support.
>> >
>> > These series has been tested on Raspberry Pi B with dd (direct I/O):
>> >
>> > sdhci-bcm2835
>> >
>> > 378 kB/s WRITE
>> > 10,6 MB/s READ
>> >
>> > sdhci-iproc (after applying patch series)
>> >
>> > 881 kB/s WRITE
>> > 10,8 MB/s READ
>>
>> I started a while ago at looking at merging the sdhost driver (for the
>> other controller on these boards that you can use instead), since
>> apparently the hardware's a better choice to use. This looks like a
>> really nice simplification for us for the Arasan mode, though. Would
>> you also want to delete the old 2835 driver after this series?
>
> Yes, that would be a necessary step. I don't know when it's the right time.
>
> What is the usual procedure for such a necessary driver?

If the kernel still supports the hardware, just in a different source
file, I don't see any problem with removing it immediately.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWqpQMAAoJELXWKTbR/J7oLcYP/RRvTz+ZgT7ACTGP8BnkSctM
e1zZNEd4ciQY+LCwbALj0USVBMqoiBgCmJ1ISXabbGnSInvjIgSG/Rjg2iWaKjy7
NyM6d+z+5wqy2czOVOv0HGWMptTfNSvGBqk1uvHb+u5oy5G395RfD16P2lBnPn5o
rHzlrnTjFih1rLgoOk3f9ksSS2bGaT34d8s/ljRj+/MzLtQNH/k1WI51ymGCJ1D3
ORR+pVbYHOHnb+s4NYDKWs/718eNNmbH+jKN/Jrjo/aVeq6xbPPJ1vPnlzWPY0Cg
q90WiBZyCclDod3chz1ZUe9xestlSOcMWAYgbRcs0bMoGX8gJNRZ5wCgaHun0gFC
HIH/6CeicR79bjZ2glB2565p4yDb/A5bQXVxHiiso7l274Ksty2h0uNh7OLU4efz
Js0LVgF0q1ZEtMVGRAHcoRb4Zuyv1EGJDczvwpE4phSHv97y3LYiOgDx/FJAY5Ou
uIqGyW9igzePjkylpnUZJnDPSvTPaqTZhYLds2yR3JfUJz+270HT8bf/Q0RAVOuH
G+RcoLDFyUwsS/9GWaMzLL2kzw2ByHmeDPOcK6b+ybxdlKVgDJb+tgJqQojsdB9b
SPqLcUvfnBzxvihPiwgpAetyV5hw5qEbHFesKBGs+poYDwH4y4JxoeO5tjnuhrV7
psWtTdLnl3IRwY1YUzfR
=sww6
-----END PGP SIGNATURE-----
--=-=-=--
