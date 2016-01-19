From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 0/5 RFC] mmc: sdhci-iproc: add bcm2835 support
Date: Tue, 19 Jan 2016 13:00:08 -0800
Message-ID: <87bn8hcmjr.fsf@eliezer.anholt.net>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:40776 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbcASVAL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 16:00:11 -0500
In-Reply-To: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>

--=-=-=
Content-Type: text/plain

Stefan Wahren <stefan.wahren@i2se.com> writes:

> This patch series based on the suggestion of Scott Branden to implement
> bcm2835 support into sdhci-iproc [1].
>
> These changes provide the following advantages:
>   * no need to maintain a separate driver for bcm2835
>   * improve support and test coverage of bcm2835 mmc support
>   * get the rid of SDHCI_CAPABILITIES hack in bcm2835_sdhci_readl
>   * increase write performance by avoiding delays in write ops
>
> Patch 1 and 2 adopt two sdhci-bcm2835 fixes to sdhci-iproc. The third patch
> tries to specify as much quirks as possible in the bcm283x.dtsi as possible.
> Patch 4 and 5 are the actually changes for bcm2835 support.
>
> These series has been tested on Raspberry Pi B with dd (direct I/O):
>
> sdhci-bcm2835
>
> 378 kB/s WRITE
> 10,6 MB/s READ
>
> sdhci-iproc (after applying patch series)
>
> 881 kB/s WRITE
> 10,8 MB/s READ

I started a while ago at looking at merging the sdhost driver (for the
other controller on these boards that you can use instead), since
apparently the hardware's a better choice to use.  This looks like a
really nice simplification for us for the Arasan mode, though.  Would
you also want to delete the old 2835 driver after this series?

These patches are all:

Acked-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWnqPYAAoJELXWKTbR/J7oT74P/Ax4kgCcgPMOlc8iG3mR6iHu
BmWtYAScqp6vFIbA8tM4CRK+oKx7Lh4tLmLLkqU12wBN573r2jAeUDstEbOiebmF
JmKtlRB/fSkaMwPRek41wYBYYEiWODVPQW92FArupafpMtyiYVX+hISdaJwZ6GCJ
3+EGfLSobk2ODzcjqQII6JV9J06Tagb2852h4xmoJW85Drg82yBA0RbHDuFwptzq
XyhcyzL0Dkx9toWlcxiUy6aZ9wdNQBzykv0Xv17Gt1gjdU1ZqNIg9KBzVZimvhl7
X0Vx4BcXrX/WOX0AsGtYYoGw+2axuR4rHylHTng94rNJIEU7rw01hkyRwbxx/wOy
Pw6QQunYTkW73YCTmqmE/CH2xPKcTTcWOznAAM0tbR4Q9SYcuecju6WWn7sQJlzw
ukLyyWOWR1vlYLcY47fj2wlQGuuRoPG/lmJKYkVsEy8x5BqErbjAjLSs9WwiB22s
5X0ZW5IIb+8nDqTY/bjVlYO00AJVs7LciJR02hz15aWFj9AbnKzPwQCopx43BCbX
TCWlFNGglWG50dPF5RtcfVSbX3aZM1dZ5dJ4Ut3Mqj6h46/2zXbwJM0rEV6PG5F2
THIJqA/bRPYre4KT8E4Zxc+kPlXqEAeob8u+Qr+LJq/qBdlqiLcvYs7lMfJ3lSVq
Eo0l8gslvCuwELK4cUp7
=lNTC
-----END PGP SIGNATURE-----
--=-=-=--
