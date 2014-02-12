From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Wed, 12 Feb 2014 18:33:01 +0000
Message-ID: <20140212183301.GL28112@sirena.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <52E700F0.7040708@gmail.com>
 <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
 <201401281148.10670.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3E9L5busH6ECpa9r"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41023 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbaBLSdg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2014 13:33:36 -0500
Content-Disposition: inline
In-Reply-To: <201401281148.10670.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, mark.rutland@arm.com, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--3E9L5busH6ECpa9r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2014 at 11:48:10AM +0100, Arnd Bergmann wrote:

> I think there is another option, which does have its own pros and cons:
> We could move all the power handling back into the sdio function driver
> if we allow a secondary detection path using DT rather than the probing
> of the SDIO bus. Essentially you'd have to list the class/vendor/device
> ID for each function that cannot be autodetected in DT, and have the
> SDIO core pretend that it found the device just by looking at the
> device nodes, and register the struct sdio_func so it can be bound to
> the driver. The driver then does all the power handling in a device
> specific way. At some point the hardware gets registered at the=20
> mmc host, and the sdio core connects the bus state to the already present
> sdio_func, possibly notifying the function driver that it has become
> usable.

> Obviously, this can only work for CAP_NONREMOVABLE devices, but those
> are exactly the ones we are worried about here. The advantage is that
> the power sequencing for a particular device can then be in device
> specific code and can have an arbitrarily complex in the driver without
> needing the mmc code to handle all possible corner cases.

I think this is going to be the most generic solution overall, it's
going to work with other buses and it's going to allow the device to
fully power itself off while running (I don't know if it's useful for SD
but that's definitely common with some other buses).

--3E9L5busH6ECpa9r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+75aAAoJELSic+t+oim9eXcQAJ5wIcdY61T/v04L85BmoTH8
ABn1oFcF04aHWya4JAor+LMdBnlgmvhdbpNhNLqIGNy8PMUoJIvac1AakXWci6MG
wdQPGit0OJ2RQvaRNynb2Zc4XExkGeaRn9q0MjRyVa288iQZgojLzAZ+v7tfarEp
6UMGU/geh+gB3gCSv4zwuBuM9q/IcBfTEXaR8sNtmKKm91HdkAqKqp92IfsJe3pC
RvoejQF4q2BN/MMo3J+iWbCnyrYu5+7a9Jycb9TB+FW/rrx1Lq0tndwWgKYQ9a+v
A6oRBUmxKrxiV+cmticfDuKNpdOWlotTsIUb8nsnhlXjO/DKzzPj146KjFBP+Va5
nUu5TWdF+BAcYeMCJQxs6mxBq7GBm9EVg25kW6AjNBTWgZt2bAO04ocgf3Vbh7VD
t+FRDifMjM2Kk/7cB8R1mMV/IE19OBhrUW8y5zKjoZVU38UyhabLbDWDxBY+3GUB
irXxgQU+JIDPdSCS3nVSzkFZu53j6w0ZmfnQuxVudPiDVbYMaFh9QO+9FI18jXai
rPDFdaIwYkUx7zVIXte24/hE+Bm7aD50i6Aqllku8kfPujzGUtDY1iK5HA1plejW
2rAbMmsIU37aFVEehQz9ojIXI5dMTkyUtDNXQVko/qBidaYMufVVuloq/Mocblyu
ckE2V/NW8t++o5Ot4M8o
=bp91
-----END PGP SIGNATURE-----

--3E9L5busH6ECpa9r--
