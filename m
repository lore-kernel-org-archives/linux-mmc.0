From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
Date: Fri, 1 Sep 2017 17:23:22 +0100
Message-ID: <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="55ep6jw3bdsl2j5j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ravikumar Kattekola <rk@ti.com>, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--55ep6jw3bdsl2j5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2017 at 03:18:03PM +0200, Ulf Hansson wrote:
> On 31 August 2017 at 15:50, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Aug 31, 2017 at 05:37:34PM +0530, Kishon Vijay Abraham I wrote:

> >> This patch should be merged along with the 1st patch of the series "mmc: host:
> >> omap_hsmmc: Remove setting PBIAS voltage". Or else it'll break MMC with
> >> omap_hsmmc driver.

Hang on, how can this break anything?  If it breaks things shouldn't
there be bugfixes for incorrect constraints somewhere?

> > I can sign a tag if it's needed for a cross tree merge.

> Easier if you could drop it and instead just provide an ack.

> Unless you believes there may conflict in your regulator tree?

My main goal is to get it in during this merge window, this way either
it goes in via my tree and the rest of the series can go in the next
release or the whole thing makes this merge window.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-pbias-variants

for you to fetch changes up to 27eae9d4b9d4cd9c204ef81f46078d91362ed41c:

  regulator: pbias: Select voltage table based on max-voltage (2017-08-31 11:55:40 +0100)

----------------------------------------------------------------
regulator: Add support for different OMAP variants in the pbias regulator

----------------------------------------------------------------
Ravikumar Kattekola (1):
      regulator: pbias: Select voltage table based on max-voltage

 drivers/regulator/pbias-regulator.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--55ep6jw3bdsl2j5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmpiXkACgkQJNaLcl1U
h9DmgAf+MzEBF/Wa45kAX36L/OhlYNU/HDKLh2Cn4sjl4uzReK33+gX4Ildlg2t/
nmXqx5rZu0eMcGOo+mjVrPFaqGML3R0w/0ulgTxyl5obwR/CzKBK08H6PhXa9sJT
K5F49zQ6H1m/h7pAjLhtoS0iKh5uwKGcg08h4AWrTrghrDjzNvdCVCo+SFDCg9tU
99vJZTwn05shxUhdZEW0mdKTn19l5buHvs7l+iXkbtuTi0KTn7LXZdoHzPy+7mla
Uw8W4xL46jLElm+1l0wejg3MRKOEoSnIasJNAJ6ADfmVQ7bYjhi47H/WfHZucXun
RifnH+872K4WNQgwN072i2rTPh7WgA==
=2Dti
-----END PGP SIGNATURE-----

--55ep6jw3bdsl2j5j--
