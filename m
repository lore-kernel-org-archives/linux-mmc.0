From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] RFC: mmc: core: Increase delay for voltage to stabilize
 from 3.3V to 1.8V
Date: Wed, 13 May 2015 12:09:15 +0100
Message-ID: <20150513110915.GG3066@sirena.org.uk>
References: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k040vn1t/h12DMPO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37005 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242AbbEMMQY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 08:16:24 -0400
Content-Disposition: inline
In-Reply-To: <1431467171-12937-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, johan.rudholm@axis.com, adrian.hunter@intel.com, tim.kryger@gmail.com, javier.martinez@collabora.co.uk, andrew_gabbasov@mentor.com, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org


--k040vn1t/h12DMPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 02:46:11PM -0700, Doug Anderson wrote:
> Since the regulator used for the SDMMC IO voltage is not expected to
> draw a lot of current, most systems will probably use an inexpensive
> LDO for it.  LDO regulators apparently have the feature that they
> don't actively drive the voltage down--they wait for other components
> in the system to drag the voltage down.  Thus they will transition
> faster under heavy loads and slower under light loads.

What a LDO is doing is basically just charging up a capacitor - the
regulation consists of monitoring the voltage on the capacitor and
opening a transistor to charge the capacitor when the voltage droops too
much.

> From experimental evidence, we've seen the voltage change fail if the
> card doesn't detect that the voltage fell to less than about 2.3V when
> we turn on the clock.  On one device (that admittedly had a 47K CMD
> pullup instead of a 10K CMD pullup) we saw that the voltage was just
> about 2.3V after 5ms and thus the voltage change would sometimes fail.
> Doubling the delay gave margin and made the voltage change work 100%
> of the time, despite the slightly weaker CMD pull.

> At the moment submitting this as an RFC patch since my problem _could_
> be fixed by increasing the pull strength (or using a smaller
> capacitor).  However being a little bit more lenient to strange
> hardware could also be a good thing.

Right, and this is probably going beyond the delays that the regulator
API is handling since it's not something the regulator hardware is
actively managing.

--k040vn1t/h12DMPO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzDaAAoJECTWi3JdVIfQ02MH/RBbB6L4fYSA4ddDd6GFT05k
/fUrtUEgd1uLXg+P8zzgPYVAPwrPB8ySNwZUvIkwy/VI7AFqVkYbKR5u9v3MGc0t
xuhLhmOlgVug/HKiyBL3/3RQqeLgR3FI66q7OzoXG7FPOQtvvTsHuUjcrMEmm0sJ
/h2PtwraKSW+EN0zyKevEFV5+b/llzImkCPHtaMMdKWDRS7DQ4cq1s72tU1Ojj5g
yhQO+bZzW1FnXMotlJZ9x6wD+nA+TLPHIjIOQNFTYIDVhMYH8o6ka6JIP50G/p4H
iXdmWgAsqJ5Igb6RDjw6pLc2DxDR2wG02B7Sj7ubmnlu/4F2knLMKbqZBUXXF+E=
=PYud
-----END PGP SIGNATURE-----

--k040vn1t/h12DMPO--
