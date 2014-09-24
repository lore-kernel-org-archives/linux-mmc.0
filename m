From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 00/27] add
	pm_runtime_last_busy_and_autosuspend() helper
Date: Wed, 24 Sep 2014 22:46:17 +0200
Message-ID: <2322320.9rETJijE2n@vostro.rjw.lan>
References: <1411575342-31048-1-git-send-email-vinod.koul@intel.com>
 <6374313.I12loOK9hA@vostro.rjw.lan> <20140924201558.GX17997@saruman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0393600678=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20140924201558.GX17997@saruman>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: balbi@ti.com
Cc: linux-wireless@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, patches@opensource.wolfsonmicro.com, linux-doc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Chris Ball <chris@printf.net>, dri-devel@lists.freedesktop.org, Marcin Wojtas <mw@semihalf.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Herrmann <dh.herrmann@gmail.com>, Shinya Kuribayashi <skuribay@pobox.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Jingoo Han <jg1.han@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Jani Nikula <jani.nikula@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Ben Skeggs <bskeggs@redhat.com>, Bjorn Andersson <bjorn.andersson@sonymobile.com>, Wolfram Sang <wsa@th>
List-Id: linux-mmc@vger.kernel.org


--===============0393600678==
Content-Type: multipart/signed; boundary="nextPart6179953.7iorWyWTok"; micalg="pgp-sha256"; protocol="application/pgp-signature"


--nextPart6179953.7iorWyWTok
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, September 24, 2014 03:15:58 PM Felipe Balbi wrote:
> On Wed, Sep 24, 2014 at 10:28:07PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, September 24, 2014 09:44:50 PM Vinod Koul wrote:
> > > This patch series adds a simple macro pm_runtime_last_busy_and_au=
tosuspend()
> > > which invokes pm_runtime_mark_last_busy() and pm_runtime_put_auto=
suspend()
> > > sequentially. Then we do a tree wide update of current patterns w=
hich are
> > > present. As evident from log below this pattern is frequent in th=
e
> > > kernel.
> > >=20
> > > This series can be found at
> > > git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git=

> > > topic/pm_runtime_last_busy_and_autosuspend
> > >=20
> > > Fengguang's kbuild has tested it so it shouldn't break things for=
 anyone.
> > > Barring one patch (explictyly mentioned in its changelog) rest ar=
e simple
> > > replacements.
> > >=20
> > > If all are okay, this should be merged thru PM tree as it depends=
 on macro
> > > addition.
> > >=20
> > > Subhransu S. Prusty (1):
> > >   PM: Add helper pm_runtime_last_busy_and_autosuspend()
> > >=20
> > > Vinod Koul (26):
> > >   dmaengine: ste_dma: use pm_runtime_last_busy_and_autosuspend he=
lper
> > >   extcon: arizona: use pm_runtime_last_busy_and_autosuspend helpe=
r
> > >   drm/i915: use pm_runtime_last_busy_and_autosuspend helper
> > >   drm/nouveau: use pm_runtime_last_busy_and_autosuspend helper
> > >   drm/radeon: use pm_runtime_last_busy_and_autosuspend helper
> > >   vga_switcheroo: use pm_runtime_last_busy_and_autosuspend helper=

> > >   i2c: designware: use pm_runtime_last_busy_and_autosuspend helpe=
r
> > >   i2c: omap: use pm_runtime_last_busy_and_autosuspend helper
> > >   i2c: qup: use pm_runtime_last_busy_and_autosuspend helper
> > >   mfd: ab8500-gpadc: use pm_runtime_last_busy_and_autosuspend hel=
per
> > >   mfd: arizona: use pm_runtime_last_busy_and_autosuspend helper
> > >   mei: use pm_runtime_last_busy_and_autosuspend helper
> > >   mmc: use pm_runtime_last_busy_and_autosuspend helper
> > >   mmc: mmci: use pm_runtime_last_busy_and_autosuspend helper
> > >   mmc: omap_hsmmc: use pm_runtime_last_busy_and_autosuspend helpe=
r
> > >   mmc: sdhci-pxav3: use pm_runtime_last_busy_and_autosuspend help=
er
> > >   mmc: sdhci: use pm_runtime_last_busy_and_autosuspend helper
> > >   NFC: trf7970a: use pm_runtime_last_busy_and_autosuspend helper
> > >   pm2301-charger: use pm_runtime_last_busy_and_autosuspend helper=

> > >   spi: omap2-mcspi: use pm_runtime_last_busy_and_autosuspend help=
er
> > >   spi: orion: use pm_runtime_last_busy_and_autosuspend helper
> > >   spi: ti-qspi: use pm_runtime_last_busy_and_autosuspend helper
> > >   spi: core: use pm_runtime_last_busy_and_autosuspend helper
> > >   tty: serial: omap: use pm_runtime_last_busy_and_autosuspend hel=
per
> > >   usb: musb: omap2430: use pm_runtime_last_busy_and_autosuspend h=
elper
> > >   video: fbdev: use pm_runtime_last_busy_and_autosuspend helper
> > >=20
> > >  Documentation/power/runtime_pm.txt          |    4 ++
> > >  drivers/dma/ste_dma40.c                     |   30 ++++---------=

> > >  drivers/extcon/extcon-arizona.c             |    6 +--
> > >  drivers/gpu/drm/i915/intel_pm.c             |    3 +-
> > >  drivers/gpu/drm/nouveau/nouveau_connector.c |    3 +-
> > >  drivers/gpu/drm/nouveau/nouveau_drm.c       |    9 +---
> > >  drivers/gpu/drm/radeon/radeon_connectors.c  |   15 ++----
> > >  drivers/gpu/drm/radeon/radeon_drv.c         |    5 +-
> > >  drivers/gpu/drm/radeon/radeon_kms.c         |    6 +--
> > >  drivers/gpu/vga/vga_switcheroo.c            |    7 +--
> > >  drivers/i2c/busses/i2c-designware-core.c    |    3 +-
> > >  drivers/i2c/busses/i2c-omap.c               |    6 +--
> > >  drivers/i2c/busses/i2c-qup.c                |    3 +-
> > >  drivers/mfd/ab8500-gpadc.c                  |    6 +--
> > >  drivers/mfd/arizona-irq.c                   |    3 +-
> > >  drivers/misc/mei/client.c                   |   12 ++----
> > >  drivers/mmc/core/core.c                     |    3 +-
> > >  drivers/mmc/host/mmci.c                     |   12 ++----
> > >  drivers/mmc/host/omap_hsmmc.c               |   19 ++-------
> > >  drivers/mmc/host/sdhci-pxav3.c              |    6 +--
> > >  drivers/mmc/host/sdhci.c                    |    3 +-
> > >  drivers/nfc/trf7970a.c                      |    3 +-
> > >  drivers/power/pm2301_charger.c              |    3 +-
> > >  drivers/spi/spi-omap2-mcspi.c               |    9 +---
> > >  drivers/spi/spi-orion.c                     |    3 +-
> > >  drivers/spi/spi-ti-qspi.c                   |    5 +-
> > >  drivers/spi/spi.c                           |    6 +--
> > >  drivers/tty/serial/omap-serial.c            |   60 +++++++++----=
=2D-------------
> > >  drivers/usb/musb/omap2430.c                 |    6 +--
> > >  drivers/video/fbdev/auo_k190x.c             |    9 +---
> > >  include/linux/pm_runtime.h                  |    6 +++
> > >  31 files changed, 97 insertions(+), 177 deletions(-)
> >=20
> > OK, I guess this is as good as it gets.
> >=20
> > What tree would you like it go through?
>=20
> Do we really need this new helper ? I mean, the very moment when we
> decide to implement ->runtime_idle() we will need to get rid of this
> change. I wonder if it's really valid...

I'm not sure I'm following?  This seems to simply implement what driver=
s
have been doing already as one function.  Why would it be invalid to re=
duce
code duplication?

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart6179953.7iorWyWTok
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJUIy2fAAoJEILEb/54YlRxOgQP+waU9FQ5z1PkyYj/kHwCuPAL
T/U2Ix7dQPCoCAUxW+5cBP2XwSchFJBw/1OzheEfi2FdNniCBQkCgBdfljEutcZ7
gOEp9INXAu8zWu7im1zrRU5JOa87+I2+WzwZLv1vpGbNmLT0fp7lZiVuNK+80W+s
7UN0G5u+dAooc5TfHC4v/NeMjxAFnCQECQbNRUWeJf/fmFINejBQOcFvnf0uyD/O
/cPmwzY757+uMa0aX95y0TSWzOHvMpNVzdUvc1IE1Qou9OojDUMH9dkVBdmKbm/y
WLwvEQ6Owh0wpRbgbXpTEDO5uXxFu2M7aqd2m4W/CUEfOSR6K86S9RFWxzBZGzIx
MDyodZ0omfvMfLF/6Q5+YQdPClUfUe97/cd1/ab2V5pdwZ/mwrBXVJo1WIsKtcDG
Oj7E3YidiksznIxjYKv88x+Cdg6NvgAlb9XwbHh7+9W7VTN+SU9ARzIA8FhIx7ZG
UAOm95++IRKnZCMQc9mriXSaOgEI7JUyaJW/wnOJhOWYUG3Hja0JTK0zLmiuzjYl
0OEkPYrZi7zpn71/irE6rCM12KhyxCxTNlw96eBUsF2QNw75xz/vvZVwq4Gs2Op2
K6VS0QlmoxgRcHkUw0/LQ4p4encBIGgJSrkpV+lf5gijNGLNYletSYyJYldL4ixl
wEd7dt+IWCz0azYiAWd4
=lTpr
-----END PGP SIGNATURE-----

--nextPart6179953.7iorWyWTok--


--===============0393600678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0393600678==--
