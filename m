From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/27] add pm_runtime_last_busy_and_autosuspend() helper
Date: Wed, 24 Sep 2014 15:32:19 -0500
Message-ID: <20140924203219.GZ17997@saruman>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <6374313.I12loOK9hA@vostro.rjw.lan>
 <20140924201558.GX17997@saruman>
 <2322320.9rETJijE2n@vostro.rjw.lan>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1918471114=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <2322320.9rETJijE2n@vostro.rjw.lan>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wolfram Sang <wsa@the-dreams.de>, Dave Airlie <airlied@redhat.com>, Ulf Hansson <ulf.hansson@li>
List-Id: linux-mmc@vger.kernel.org

--===============1918471114==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V6LUty14dADzmtgW"
Content-Disposition: inline

--V6LUty14dADzmtgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 10:46:17PM +0200, Rafael J. Wysocki wrote:
> On Wednesday, September 24, 2014 03:15:58 PM Felipe Balbi wrote:
> > On Wed, Sep 24, 2014 at 10:28:07PM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, September 24, 2014 09:44:50 PM Vinod Koul wrote:
> > > > This patch series adds a simple macro pm_runtime_last_busy_and_auto=
suspend()
> > > > which invokes pm_runtime_mark_last_busy() and pm_runtime_put_autosu=
spend()
> > > > sequentially. Then we do a tree wide update of current patterns whi=
ch are
> > > > present. As evident from log below this pattern is frequent in the
> > > > kernel.
> > > >=20
> > > > This series can be found at
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git
> > > > topic/pm_runtime_last_busy_and_autosuspend
> > > >=20
> > > > Fengguang's kbuild has tested it so it shouldn't break things for a=
nyone.
> > > > Barring one patch (explictyly mentioned in its changelog) rest are =
simple
> > > > replacements.
> > > >=20
> > > > If all are okay, this should be merged thru PM tree as it depends o=
n macro
> > > > addition.
> > > >=20
> > > > Subhransu S. Prusty (1):
> > > >   PM: Add helper pm_runtime_last_busy_and_autosuspend()
> > > >=20
> > > > Vinod Koul (26):
> > > >   dmaengine: ste_dma: use pm_runtime_last_busy_and_autosuspend help=
er
> > > >   extcon: arizona: use pm_runtime_last_busy_and_autosuspend helper
> > > >   drm/i915: use pm_runtime_last_busy_and_autosuspend helper
> > > >   drm/nouveau: use pm_runtime_last_busy_and_autosuspend helper
> > > >   drm/radeon: use pm_runtime_last_busy_and_autosuspend helper
> > > >   vga_switcheroo: use pm_runtime_last_busy_and_autosuspend helper
> > > >   i2c: designware: use pm_runtime_last_busy_and_autosuspend helper
> > > >   i2c: omap: use pm_runtime_last_busy_and_autosuspend helper
> > > >   i2c: qup: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mfd: ab8500-gpadc: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mfd: arizona: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mei: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mmc: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mmc: mmci: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mmc: omap_hsmmc: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mmc: sdhci-pxav3: use pm_runtime_last_busy_and_autosuspend helper
> > > >   mmc: sdhci: use pm_runtime_last_busy_and_autosuspend helper
> > > >   NFC: trf7970a: use pm_runtime_last_busy_and_autosuspend helper
> > > >   pm2301-charger: use pm_runtime_last_busy_and_autosuspend helper
> > > >   spi: omap2-mcspi: use pm_runtime_last_busy_and_autosuspend helper
> > > >   spi: orion: use pm_runtime_last_busy_and_autosuspend helper
> > > >   spi: ti-qspi: use pm_runtime_last_busy_and_autosuspend helper
> > > >   spi: core: use pm_runtime_last_busy_and_autosuspend helper
> > > >   tty: serial: omap: use pm_runtime_last_busy_and_autosuspend helper
> > > >   usb: musb: omap2430: use pm_runtime_last_busy_and_autosuspend hel=
per
> > > >   video: fbdev: use pm_runtime_last_busy_and_autosuspend helper
> > > >=20
> > > >  Documentation/power/runtime_pm.txt          |    4 ++
> > > >  drivers/dma/ste_dma40.c                     |   30 ++++---------
> > > >  drivers/extcon/extcon-arizona.c             |    6 +--
> > > >  drivers/gpu/drm/i915/intel_pm.c             |    3 +-
> > > >  drivers/gpu/drm/nouveau/nouveau_connector.c |    3 +-
> > > >  drivers/gpu/drm/nouveau/nouveau_drm.c       |    9 +---
> > > >  drivers/gpu/drm/radeon/radeon_connectors.c  |   15 ++----
> > > >  drivers/gpu/drm/radeon/radeon_drv.c         |    5 +-
> > > >  drivers/gpu/drm/radeon/radeon_kms.c         |    6 +--
> > > >  drivers/gpu/vga/vga_switcheroo.c            |    7 +--
> > > >  drivers/i2c/busses/i2c-designware-core.c    |    3 +-
> > > >  drivers/i2c/busses/i2c-omap.c               |    6 +--
> > > >  drivers/i2c/busses/i2c-qup.c                |    3 +-
> > > >  drivers/mfd/ab8500-gpadc.c                  |    6 +--
> > > >  drivers/mfd/arizona-irq.c                   |    3 +-
> > > >  drivers/misc/mei/client.c                   |   12 ++----
> > > >  drivers/mmc/core/core.c                     |    3 +-
> > > >  drivers/mmc/host/mmci.c                     |   12 ++----
> > > >  drivers/mmc/host/omap_hsmmc.c               |   19 ++-------
> > > >  drivers/mmc/host/sdhci-pxav3.c              |    6 +--
> > > >  drivers/mmc/host/sdhci.c                    |    3 +-
> > > >  drivers/nfc/trf7970a.c                      |    3 +-
> > > >  drivers/power/pm2301_charger.c              |    3 +-
> > > >  drivers/spi/spi-omap2-mcspi.c               |    9 +---
> > > >  drivers/spi/spi-orion.c                     |    3 +-
> > > >  drivers/spi/spi-ti-qspi.c                   |    5 +-
> > > >  drivers/spi/spi.c                           |    6 +--
> > > >  drivers/tty/serial/omap-serial.c            |   60 +++++++++------=
------------
> > > >  drivers/usb/musb/omap2430.c                 |    6 +--
> > > >  drivers/video/fbdev/auo_k190x.c             |    9 +---
> > > >  include/linux/pm_runtime.h                  |    6 +++
> > > >  31 files changed, 97 insertions(+), 177 deletions(-)
> > >=20
> > > OK, I guess this is as good as it gets.
> > >=20
> > > What tree would you like it go through?
> >=20
> > Do we really need this new helper ? I mean, the very moment when we
> > decide to implement ->runtime_idle() we will need to get rid of this
> > change. I wonder if it's really valid...
>=20
> I'm not sure I'm following?  This seems to simply implement what drivers
> have been doing already as one function.  Why would it be invalid to redu=
ce
> code duplication?

For two reasons:

1) the helper has no inteligence whatsoever. It just calls the same
functions.

2) the duplication will vanish whenever someone implements
->runtime_idle() and have that call pm_runtime_autosuspend() (like PCI
and USB buses are doing today). This will just be yet another line that
needs to change.

Frankly though, no strong feelings, I just think it's a commit that
doesn't bring that any benefits other than looking like one line was
removed.

--=20
balbi

--V6LUty14dADzmtgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUIypTAAoJEIaOsuA1yqREhhUQAJ2WaYWvb7rl4SU7xaBhUE+i
tSFHnm2/E7xs3/WVQrg4UE+MgRKu+QeEQXg7menmOImQV5xNxAfH4gJcx6dEJgle
oEz0ZCyCGf+eE7DQZ980y37TodiosiIx2BB89cMmJkuOhicdWoTx9B++xJprobwK
p3C1z8ZQXcqegkQSGWNv0WRNktRq0DOuBpr3Djjg4MiidMFsqfLry4onOCHfrgU6
PdBfg/xQvzX4RTTGeLY3Q/FrpBoF0HmO5jH+aCcG+1tEWqBFadAvMroAx9s9yZlG
GngD3T2bR4Hux0Nk+c722H5vKvV3ikvO3uCcpNBTn0xxbJJn8PJ/TZvhuL+CVD3A
iJRTtPjRPlK4FGsmdcxz+22dQZbhNFt5uSW6ErpyZc+UY1lPJKIhucT6KoXn0Xm3
td6o4hLXIh/4VWQ+9tTSzGR6k0HJLxnP7VrY7pibiSbTXtmckYqUuYY/syAZofRi
YB0eO9+GhMwXB24wbH6zY0/RfkVkHbtJMxrR3IcG4vCZP+K4Bo3PKIu0EdyaB+pq
Bhy6EZOGiGusiLGaOB7XMdRdLfz/ri/C2EnXyEsTEmSERV4msRYasGV74Xrqw/10
QDoyndUsasu1TmjdpOdB12QCx8aYJjl8AR1Di2ElNAmcwKoJADv3b0w4a+CQnmoP
b4+0XxaohdfEZYxiI8RD
=zLG6
-----END PGP SIGNATURE-----

--V6LUty14dADzmtgW--

--===============1918471114==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1918471114==--
