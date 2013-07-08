From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/4] mmc: omap_hsmmc: Enable SDIO IRQ using a GPIO in
 idle mode
Date: Mon, 8 Jul 2013 12:02:54 +0300
Message-ID: <20130708090254.GH29100@arwen.pp.htv.fi>
References: <20130607214557.18581.75288.stgit@localhost>
 <20130607214952.18581.90049.stgit@localhost>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130607214952.18581.90049.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: cjb@laptop.org, Balaji T K <balajitk@ti.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 02:49:52PM -0700, Tony Lindgren wrote:
> From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
>=20
> Without functional clock the omap_hsmmc module can't forward SDIO IRQs to
> the system. This patch reconfigures dat1 line as a gpio while the fclk is
> off. When the fclk is present it uses the standard SDIO IRQ detection of
> the module.
>=20
> The gpio irq is managed via the 'disable_depth' ref counter of the irq
> subsystem, this driver simply calls enable_irq/disable_irq when needed.
>=20
>                       sdio irq    sdio irq
>                       unmasked     masked
>    -----------------------------------------
>     runtime default  |    1     |   2
>     runtime suspend  |    0     |   1
>=20
>                   irq disable depth
>=20
>=20
> only when sdio irq is enabled AND the module is idle, the reference
> count drops to zero and the gpio irq is effectively armed.
>=20
> Patch was tested on AM335x/Stream800. Test setup was two modules
> with sdio wifi cards. Modules where connected to a dual-band AP, each
> module using a different band. One of module was running iperf as server
> the other as client connecting to the server in a while true loop. Test
> was running for 4+ weeks. There were about 60 Mio. suspend/resume
> transitions. Test was shut down regularly.
>=20
> Cc: Andreas Fenkart <afenkart@gmail.com>
> Cc: Balaji T K <balajitk@ti.com>
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> [tony@atomide.com: updated and separated out pin muxing]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

right, as I discussed before the gpio part should also be split to a
separate patch. That's a workaround for broken HW anyway.

--=20
balbi

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR2oA+AAoJEIaOsuA1yqREMUYP/3RWprILOArHlDQ/e3Jc4b91
QLKpsBAcDnL5UdyYJ5tRVEZYLl5WFga0EgVrtE8ht8RmlbrueF1oausC2fAMVCDy
oe7L2EecKyZ2n86I8EgT9Lh1CpLcLeHoZKMtInyEjO7Krti1Vp7lXhVH+IY62Qc9
M893TsO0HZUjnyWDJs5h+VhTeT6xtiOKz6MqL1DSt0tV70PTGor1WqenwMgPvylY
fbWM1KX6GDQqhN3uM0UbAe5GeaI4Mq4dEqDArf0ZgfVpOXSsBa8s/9DY8NSNR1dN
lZjnG5UyiKmYwRHTBPprww15qlNRfMadyiT0SeFN7dIZXxxdqhaRn5FtZnqWgnoD
X/hw/tIIBS7IZZS/XMs4K0c8zue7qMO64+DSYFw5Iu0KQMFJFGTgkShn/jPhW59l
tHo0XGijaHT9kJ63TcpmfnJ8Q3TnYKEs6gsrXpRjkhvW/+k6DGOEOfvhJkKWO1Fy
YA9qE9k+Ovqb6P4H1ZJjLbkgotSEngOuC//5HUt0lhxnNt6RpAvITdzu8S/c/usY
7NlmHX7PBSDnNUMVFcHZmwMEP140CfLbS6kcqxrBVD5fDjDzmcJgSLJnbjiRwl7s
h1hMFcs8RjYbeRhmYU+wGAEi0qbndzb9TBg4TaxYTSxjAY13tXRy3SJM8NkB/OJB
4ZnbNFzjj5J9B/09eVXX
=QGGf
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
