From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] mmc: sunxi: mask all Response Timeout error messages
Date: Tue, 7 Mar 2017 11:10:14 +0100
Message-ID: <20170307101014.qic65pply3c4yxzq@lukather>
References: <20170305164535.36259-1-icenowy@aosc.xyz>
 <20170306100437.sr7mrvssdwnt7aaz@lukather>
 <1597991488796361@web24m.yandex.ru>
 <20170306155313.nqxnhtsl4o5yrv33@lukather>
 <364721488821322@web5o.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4488588910909797555=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <364721488821322@web5o.yandex.ru>
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


--===============4488588910909797555==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xiua3pnhj7i7ty6p"
Content-Disposition: inline


--xiua3pnhj7i7ty6p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2017 at 01:28:42AM +0800, Icenowy Zheng wrote:
>=20
>=20
> 06.03.2017, 23:53, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> > On Mon, Mar 06, 2017 at 06:32:41PM +0800, Icenowy Zheng wrote:
> >> =A006.03.2017, 18:04, "Maxime Ripard" <maxime.ripard@free-electrons.co=
m>:
> >> =A0> Hi,
> >> =A0>
> >> =A0> On Mon, Mar 06, 2017 at 12:45:35AM +0800, Icenowy Zheng wrote:
> >> =A0>> =A0Response Timeout is very usual: it will happen when trying to=
 run some
> >> =A0>> =A0commands that do not belong to the card; it will happen when =
some SDIO
> >> =A0>> =A0card transfer beyond its SDIO bandwidth; and when the MMC con=
troller is
> >> =A0>> =A0set to poll the card with "broken-cd" property (the Lichee Pi=
 series of
> >> =A0>> =A0boards do this), it will flood to the console and make the co=
nsole
> >> =A0>> =A0unusable.
> >> =A0>>
> >> =A0>> =A0Mask all response-timeout-only error messages, only show it w=
hen another
> >> =A0>> =A0error happens.
> >> =A0>>
> >> =A0>> =A0Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> =A0>> =A0---
> >> =A0>> =A0=A0drivers/mmc/host/sunxi-mmc.c | 13 +++++++++----
> >> =A0>> =A0=A01 file changed, 9 insertions(+), 4 deletions(-)
> >> =A0>>
> >> =A0>> =A0diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/=
sunxi-mmc.c
> >> =A0>> =A0index 6ffcd2838272..7828e1f57cf0 100644
> >> =A0>> =A0--- a/drivers/mmc/host/sunxi-mmc.c
> >> =A0>> =A0+++ b/drivers/mmc/host/sunxi-mmc.c
> >> =A0>> =A0@@ -483,10 +483,15 @@ static void sunxi_mmc_dump_errinfo(stru=
ct sunxi_mmc_host *host)
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mmc_command *cmd =3D host->=
mrq->cmd;
> >> =A0>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct mmc_data *data =3D host->mr=
q->data;
> >> =A0>>
> >> =A0>> =A0- /* For some cmds timeout is normal with sd/mmc cards */
> >> =A0>> =A0- if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D
> >> =A0>> =A0- SDXC_RESP_TIMEOUT && (cmd->opcode =3D=3D SD_IO_SEND_OP_COND=
 ||
> >> =A0>> =A0- cmd->opcode =3D=3D SD_IO_RW_DIRECT))
> >> =A0>> =A0+ /*
> >> =A0>> =A0+ * Reading timeout is usually normal, especially when doing
> >> =A0>> =A0+ * card-polling with "broken-cd" in device tree.
> >> =A0>> =A0+ * If do not mask it, the RTO error message will flood the c=
onsole
> >> =A0>> =A0+ * and even hide useful error messages.
> >> =A0>> =A0+ *
> >> =A0>> =A0+ * Some SDIO commands will also normally timeout with non-SD=
IO cards.
> >> =A0>> =A0+ */
> >> =A0>> =A0+ if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D SDXC_=
RESP_TIMEOUT)
> >> =A0>
> >> =A0> We really shouldn't silence legit errors.
> >> =A0>
> >> =A0> The actual problem here is that we log them as error, we could
> >> =A0> probably reduce it to debug.
> >>
> >> =A0Even if it's reduced to debug, it will still flush dmesg buffers.
> >
> > No, it will not even be compiled by default.
> >
> >> =A0Or make it only visible when "debug" parameter is present in kernel
> >> =A0cmdline?
> >
> > debug messages are visible in dmesg only if DEBUG is defined, which is
> > only happening if CONFIG_MMC_DEBUG is set. This won't affect the
> > general case in any way.
> >
> > And it is output only if loglevel is set higher than 7.
>=20
> Should I make all error messages debug level or only make "RTO"-only
> error to debug level like I currently do?

I'd say just change the level of the log of the line coming below that
one. It doesn't provide any useful clue about what's going on anyway,
there's nothing the user will be able to do to prevent that, and
someone willing to debug it will have to turn on the debug options
anway.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--xiua3pnhj7i7ty6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvocBAAoJEBx+YmzsjxAgSG0P/j38PqCRda5guan0vd4xNiZV
JTvq/RDCiXy1gXiY/QmZPXXMXdEf+vDb7G3cFzxs/n88xjqdxggld6M5eM71YFN3
b944Wegn2o8CzHqKQDINy3i8Wa3y99dZCWVNTLpR4U13nEz2wi18bRzb5ryxxFEb
lzlwsv+DMvgdXwxPzoBJGLXi7FVEdMMv9XJ0nzSqpI6JF/9Ap0zOq3j2o1tTRJiI
CPWAtqblfqET5q3SAn3Wr6oE1R2cX61wQIFE+ngE/ZPiyEwf71EPww6UVUQDirfx
NQVw2AOTYnrIwqcwhEgUyInA3s3bEV2Q5fcamj8cDNUxEEGmo7NFuaq6UrnHGOch
si1sGHxUJKi31QRwSEuOjx+80bnT4ySgHRpda8fyBdBX6CwdzvmmUL8fpi5p2axI
bKecQ8+JcWO8mXe3w2Oe/7m4gsVWdcbYW1F+PW9KVFMCGJT6ZFimlfc2BAJGUBn7
HMpznfxA/ZLIrMT9tq0aWk4mCOwO+W+XYx40F1Emj4Q8y2crReWgY0KCVG3bZPSS
Hstn++l21SkoHaLGee7/1SPVbC0z4BBXiH+cpV8JkXPp1PTxy35NazNMP/q10VS4
owmi70vik91vHFx+6QoInDd/K3aFJJrt3pCd2pwKkBLjhNOpowr2mwCclaTkM8EW
UrROJiylJ9EvwfTIX1WA
=e/3r
-----END PGP SIGNATURE-----

--xiua3pnhj7i7ty6p--


--===============4488588910909797555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4488588910909797555==--
