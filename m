From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] MMC: mmci: Seperate ARM variants from generic code
Date: Sat, 17 Mar 2012 21:30:23 +0000
Message-ID: <20120317213022.GE3315@opensource.wolfsonmicro.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <201203151823.32882.arnd@arndb.de>
 <20120315203037.GA2311@n2100.arm.linux.org.uk>
 <201203161248.15490.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43809 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754921Ab2CQVa0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Mar 2012 17:30:26 -0400
Content-Disposition: inline
In-Reply-To: <201203161248.15490.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 12:48:15PM +0000, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Russell King - ARM Linux wrote:

> > We _do_ need a solution for GPIO-controlled voltage regulators, as these
> > are actually quite common - see the various soc-common using PCMCIA
> > drivers.

> > So I think actually a bit more thought is required here, and there's a
> > need to use some of the facilities such as regulator which are now present
> > that weren't when the driver was originally written some 9 years ago.

> Ok. Let's see what Mark has to say about this.

There's the gpio-regulator driver in mainline which should be able to
support a fairly wide range of these simple regulators, and also the
fixed voltage regulator for extremely simple cases.

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZQI/AAoJEBus8iNuMP3dTS4P/22Z1wFzVwClvFC+piJGqNP0
zppDqp7luGW0hSwOVwicnij5NSMdyMo9DyYFPIrBeF/RIzsY6y/nc/mp4bTuIsIA
b/W8JICfQfFa8kk2DzsD7yGVPPSsSRneHZyxNPkhNtZAI/EIdz33PADBgGyRl7ch
TA3RNaoezlbYkBqOnmq6Goy06YaWdlQgBwTVAT0BogME/r8j9nUMdaZ9Dn8vwKTM
bZ9KsyQTdVS5ssGwnbugMzsV2XhZZ/7/bCxDz9+ADOhbvTN7UuZZP1nvauBUmBTr
xDA/H+aNSq7lO+KiuVULjAnzU9KyNlbjEUN27RNQvja4d7f8ovG73jjuZlki47cz
6HQt0tk3IvIAEPIgy6Vwi6KMA84swOoKD7KG9kVFUtO1/L/t5sGQfWZ1G7XGYNFI
jMOkjnLIjYouMoCOjt09FTDyIoYkIEBrE3j93mWNtv3Ak3BWjN9mHEk17QKs2biO
7i7DlgErsEIQ1PFcG2XEBgLwiLJtriZ5ni1Vh+VI6wJA/DvnwfJctXLDDGIWm4UN
dDQ7vjNme1MHAm23ENulScgl2grTKiYziwke5YsTQn+qzIXIwqQztrBMpQ2q1RFu
gT+yHnb7z5fQh1uhzM1FnWz4BlVoOYmK1YakVbZ9KTpTaq9o6jx8o0M1NhqYAyf+
TDXbpzAmMsGHfkxC/xvO
=QH6C
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
