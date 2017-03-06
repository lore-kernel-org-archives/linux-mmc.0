From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] mmc: sunxi: mask all Response Timeout error messages
Date: Mon, 6 Mar 2017 16:53:13 +0100
Message-ID: <20170306155313.nqxnhtsl4o5yrv33@lukather>
References: <20170305164535.36259-1-icenowy@aosc.xyz>
 <20170306100437.sr7mrvssdwnt7aaz@lukather>
 <1597991488796361@web24m.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6212305526612579342=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1597991488796361@web24m.yandex.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--===============6212305526612579342==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uryps4l2lrenzfo6"
Content-Disposition: inline


--uryps4l2lrenzfo6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 06:32:41PM +0800, Icenowy Zheng wrote:
> 06.03.2017, 18:04, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Mon, Mar 06, 2017 at 12:45:35AM +0800, Icenowy Zheng wrote:
> >> =A0Response Timeout is very usual: it will happen when trying to run s=
ome
> >> =A0commands that do not belong to the card; it will happen when some S=
DIO
> >> =A0card transfer beyond its SDIO bandwidth; and when the MMC controlle=
r is
> >> =A0set to poll the card with "broken-cd" property (the Lichee Pi serie=
s of
> >> =A0boards do this), it will flood to the console and make the console
> >> =A0unusable.
> >>
> >> =A0Mask all response-timeout-only error messages, only show it when an=
other
> >> =A0error happens.
> >>
> >> =A0Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> =A0---
> >> =A0=A0drivers/mmc/host/sunxi-mmc.c | 13 +++++++++----
> >> =A0=A01 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> =A0diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-=
mmc.c
> >> =A0index 6ffcd2838272..7828e1f57cf0 100644
> >> =A0--- a/drivers/mmc/host/sunxi-mmc.c
> >> =A0+++ b/drivers/mmc/host/sunxi-mmc.c
> >> =A0@@ -483,10 +483,15 @@ static void sunxi_mmc_dump_errinfo(struct sun=
xi_mmc_host *host)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mmc_command *cmd =3D host->mrq->c=
md;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mmc_data *data =3D host->mrq->dat=
a;
> >>
> >> =A0- /* For some cmds timeout is normal with sd/mmc cards */
> >> =A0- if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D
> >> =A0- SDXC_RESP_TIMEOUT && (cmd->opcode =3D=3D SD_IO_SEND_OP_COND ||
> >> =A0- cmd->opcode =3D=3D SD_IO_RW_DIRECT))
> >> =A0+ /*
> >> =A0+ * Reading timeout is usually normal, especially when doing
> >> =A0+ * card-polling with "broken-cd" in device tree.
> >> =A0+ * If do not mask it, the RTO error message will flood the console
> >> =A0+ * and even hide useful error messages.
> >> =A0+ *
> >> =A0+ * Some SDIO commands will also normally timeout with non-SDIO car=
ds.
> >> =A0+ */
> >> =A0+ if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D SDXC_RESP_T=
IMEOUT)
> >
> > We really shouldn't silence legit errors.
> >
> > The actual problem here is that we log them as error, we could
> > probably reduce it to debug.
>=20
> Even if it's reduced to debug, it will still flush dmesg buffers.

No, it will not even be compiled by default.

> Or make it only visible when "debug" parameter is present in kernel
> cmdline?

debug messages are visible in dmesg only if DEBUG is defined, which is
only happening if CONFIG_MMC_DEBUG is set. This won't affect the
general case in any way.

And it is output only if loglevel is set higher than 7.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uryps4l2lrenzfo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvYXlAAoJEBx+YmzsjxAgXRIQALbRDu75EaIt0pA/TnSA6uY9
Smu/JPixxCLOM3AVfxM38a4VKO/1wAVBt17o/IM2IrC5w5KXlzK7kYrPX8ZPl2Af
O+xTFps5I9uEJPm46PEOyvqbuciQiNr5KssBxhC3wrf6JlVCtzn2Tqd8c8mjUZJ0
6vnjHH0ECvHonILCuXft/idmbvRM+t2I99bIpC+LIFK+dOcTMr3Owi3XhvIXD1DF
uR6ojrnI+s/cRG0yyv87BXXarL8EvsjPjsDpC7lLEkHmvRR1mpHjYiUf9GgmDN4w
jfHccl+g1w7wMWlTLZB0zZHuq+z4S+rt7ztYuJLsR/VLkg1HVxllWk2ycgCMj2KW
wD4Iv3JsiCeYA+E7ixyB8XW57VKANEesWYz4BP+VkSDalEYXPb/xynXGEHlVp0Bk
cI4ZM+qRFAMlK8mUBArI67LpxV2RBvOGxvpAQJlt8Wl0J0zskJdLN3EYdQLlZyIs
FzK3TOhoVynNh6eEdxOVeT/vhSTSn7Azs6oVcihQTXMtlQyFBQSTXYwiZ25dwCN+
lwgHC9P4nFwpNnmhYI/tbTS81CaVaJEzhCqiveGHqz1lgs12ioL/Jarn3+gaOtzd
jfUroybKeETsZDgcqYx9J3ImSA7Ngjr8RBA52zKxUhZSzxNWVyulMSz+4P4qfO27
9qqP7LG0bl2QD7+4IXbM
=bs7Y
-----END PGP SIGNATURE-----

--uryps4l2lrenzfo6--


--===============6212305526612579342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6212305526612579342==--
