From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
Date: Mon, 4 Sep 2017 17:48:09 +0100
Message-ID: <20170904164809.5coe6vhgyc7iwy6q@sirena.org.uk>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
 <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
 <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5bvgvhkxf5hn5ix"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39922 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdIDQsb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Sep 2017 12:48:31 -0400
Content-Disposition: inline
In-Reply-To: <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--r5bvgvhkxf5hn5ix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2017 at 11:16:54AM +0530, Kishon Vijay Abraham I wrote:
> On Friday 01 September 2017 09:53 PM, Mark Brown wrote:

> > Hang on, how can this break anything?  If it breaks things shouldn't
> > there be bugfixes for incorrect constraints somewhere?

> omap_hsmmc sets the pbias voltage to 3V. But here we program the volt table to
> support either 1.8V or 3.3V (Initially the volt table was programmed to support
> 3V because of a bug in TRM). So set_voltage of pbias voltage in omap_hsmmc will
> fail.

Oh, that's appauling.  I guess this is some voltage that doesn't get
presented to cards because otherwise I'm surprised nobody noticed.
Anyway I've dropped the commit from my pull request for now, it'll not
go for v4.14, but the pull request is still there.

--r5bvgvhkxf5hn5ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtg8gACgkQJNaLcl1U
h9B5Zgf/TDLrsvs7hGxL/iwhRobHGhAMdZYWPpy8z1g4OC2XUYp95pT50Ebw6JS2
R/3Rv6EDJzUHgcA77yWLVqgC9w906a3bbTigKaRY2s+c0I90LwxkXgzOXujlIgQh
rzebytXHdAEj2EYRu/XdlNtXhsuIcS/OF/28nt5qsFslIp0ZIkh2M4ycXHp5ktn1
jNu08aZ0mOVH6woHS7w8ZmjCqYXvudIja/4/Rw8GHWAdkAxe147mL9zqx3R0oCe9
d5Qe1AE0b8Z9l9pmHzARNAcoXfQhSUNYc0e+ZE+LgUk8idE7HhI9i3YSyS7kIv02
3DBD60YtXVzCrLTCI0XD3UNHvITAQg==
=PRU/
-----END PGP SIGNATURE-----

--r5bvgvhkxf5hn5ix--
