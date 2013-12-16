From: David =?ISO-8859-1?Q?Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: Re: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
Date: Mon, 16 Dec 2013 22:54:21 +0100
Message-ID: <2899559.jbTzDM2qtE@dizzy-6.site>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com> <20131215045116.23538.4@quantum> <52AF68DB.7090105@elopez.com.ar>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1746214.k84VvJb5iH"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kolab.o2s.ch ([77.109.136.180]:46924 "EHLO kolab.o2s.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059Ab3LPWAs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Dec 2013 17:00:48 -0500
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
Cc: Mike Turquette <mturquette@linaro.org>, zhangfei <zhangfei.gao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com, mark.rutland@arm.com, devicetree@vger.kernel.org, dinh.linux@gmail.com, heiko@sntech.de, pawel.moll@arm.com, bzhao@marvell.com, tgih.jun@samsung.com, Peter De Schrijver <pdeschrijver@nvidia.com>, linux-mmc@vger.kernel.org, dianders@chromium.org, rob.herring@calxeda.com, jh80.chung@samsung.com, alim.akhtar@samsung.com, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>


--nextPart1746214.k84VvJb5iH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi
> that takes the MMC clock (and only the MMC clock) and does the setup
> (it's basically configuring two values, "sample" and "output", into the
> clock register). I really don't know what does this do/why is it
> required/when is it used; I'm cc'ing Hans and David who can hopefully
> explain that part.
Since the read/write operations have to happen asynchronously and in a manner
so that the data provided by the SD-Card can be fetched on time, a specific
clock phase shift is required as you can see in the linked picture[1].
That's what the function is doing: It accesses the special registers of the
MMC clock device and configures this phase offset.

> I also saw a similar requirement from the gmac people (on cc too), who
> needed to set the phy type (or something like that) on one of the clock
> registers; so I'm thinking maybe a generic "tune something" approach
> that lets users configure some clock-dependent, arbitrary aspect of the
> clock is the way forward. Otherwise, we're going to end up bloating the
> clock framework with a lot of callback pointers that are going to be
> used in one or two clocks out of potentially hundreds on the whole system.
It totally makes sense, since GMAC will be doing asynchrous
operations as well.

-David

[1] http://www.chipestimate.com/techtalk/images/11022010_fig2_3.JPG
--nextPart1746214.k84VvJb5iH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlKvdpsACgkQAeZw77btGjp6VACffO0XyCXMbqncH9UQew5KHmSA
9yoAnjOECP4k3JH/6DVWq2pMSLz7E5bq
=m79i
-----END PGP SIGNATURE-----

--nextPart1746214.k84VvJb5iH--

