From: Mike Kelly <pioto@pioto.org>
Subject: Re: [Bugme-new] [Bug 18602] New: mmc_block / tifm_sd not completely
 registering when a new sd card is inserted
Date: Sat, 18 Sep 2010 05:01:27 -0400
Message-ID: <20100918050127.39ab1e8b@aether.home.pioto.org>
References: <20100917135414.GB11462@console-pimps.org>
	<198229.26049.qm@web37602.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zsv1eHYJ8JUwqFmVDp7Z9vV"; protocol="application/pgp-signature"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.pioto.org ([207.192.71.235]:36632 "EHLO
	everglades.pioto.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755307Ab0IRJIC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Sep 2010 05:08:02 -0400
In-Reply-To: <198229.26049.qm@web37602.mail.mud.yahoo.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Dubov <oakad@yahoo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

--Sig_/zsv1eHYJ8JUwqFmVDp7Z9vV
Content-Type: multipart/mixed; boundary="MP_/6CF=pvs4e/0GWnKdg=giSVz"

--MP_/6CF=pvs4e/0GWnKdg=giSVz
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 18 Sep 2010 00:23:55 -0700 (PDT)
Alex Dubov <oakad@yahoo.com> wrote:

> > > >=20
> > > >=20
> > > >=A0=A0=A00f:06.3 SD Host controller:
> > Texas Instruments PCIxx12 SDA Standard Compliant
> > > > SD Host Controller
> > > >=20
> > > > Any advice would be appreciated. Thanks.
> > > >=20
> > >=20
>=20
> From what I recollect, these controllers (the xx12 ones) were never
> that well tested (there are some differences between xx21 and xx12
> and I only had the former). I suppose, compiling tifm_* module with
> DEBUG enabled and posting the trace may help to diagnose the problem.

Log is attached. It seems that this time, no entry shows up in /dev at
all, even if I modprobe mmc_block manually.

--=20
Mike Kelly


--MP_/6CF=pvs4e/0GWnKdg=giSVz
Content-Type: text/x-log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=tifm.log

Sep 18 04:56:54 aether kernel: [  459.091171] tifm_core: MMC/SD card detect=
ed in socket 0:1
Sep 18 04:56:54 aether kernel: [  459.203406] mmc0: clock 0Hz busmode 1 pow=
ermode 0 cs 0 Vdd 0 width 0 timing 0
Sep 18 04:56:54 aether kernel: [  459.203418] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 0, vdd =3D 0, bus_mode =3D 1, chip_select =3D 0, power_mode =3D 0, bu=
s_width =3D 0
Sep 18 04:56:54 aether kernel: [  459.203480] mmc0: clock 0Hz busmode 1 pow=
ermode 1 cs 0 Vdd 21 width 0 timing 0
Sep 18 04:56:54 aether kernel: [  459.203491] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 0, vdd =3D 15, bus_mode =3D 1, chip_select =3D 0, power_mode =3D 1, b=
us_width =3D 0
Sep 18 04:56:54 aether kernel: [  459.214312] mmc0: clock 400000Hz busmode =
1 powermode 2 cs 0 Vdd 21 width 0 timing 0
Sep 18 04:56:54 aether kernel: [  459.214325] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 400000, vdd =3D 15, bus_mode =3D 1, chip_select =3D 0, power_mode =3D=
 2, bus_width =3D 0
Sep 18 04:56:54 aether kernel: [  459.225087] mmc0: starting CMD52 arg 0000=
0c00 flags 00000195
Sep 18 04:56:54 aether kernel: [  459.225102] tifm_sd tifm_sd0:1: executing=
 opcode 0x34, arg: 0xc00, mask: 0x2140
Sep 18 04:56:54 aether kernel: [  459.225433] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:54 aether kernel: [  459.225449] mmc0: req done (CMD52): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:54 aether kernel: [  459.226080] mmc0: starting CMD52 arg 8000=
0c08 flags 00000195
Sep 18 04:56:54 aether kernel: [  459.226091] tifm_sd tifm_sd0:1: executing=
 opcode 0x34, arg: 0x80000c08, mask: 0x2140
Sep 18 04:56:54 aether kernel: [  459.226431] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:54 aether kernel: [  459.226447] mmc0: req done (CMD52): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:54 aether kernel: [  459.226468] mmc0: clock 400000Hz busmode =
1 powermode 2 cs 1 Vdd 21 width 0 timing 0
Sep 18 04:56:54 aether kernel: [  459.226477] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 400000, vdd =3D 15, bus_mode =3D 1, chip_select =3D 1, power_mode =3D=
 2, bus_width =3D 0
Sep 18 04:56:54 aether kernel: [  459.228051] mmc0: starting CMD0 arg 00000=
000 flags 000000c0
Sep 18 04:56:54 aether kernel: [  459.228061] tifm_sd tifm_sd0:1: executing=
 opcode 0x0, arg: 0x0, mask: 0x40
Sep 18 04:56:54 aether kernel: [  459.228222] tifm_sd tifm_sd0:1: host even=
t: host_status 1, flags 0
Sep 18 04:56:54 aether kernel: [  459.228274] mmc0: req done (CMD0): 0: 000=
00000 00000000 00000000 00000000
Sep 18 04:56:54 aether kernel: [  459.231054] mmc0: clock 400000Hz busmode =
1 powermode 2 cs 0 Vdd 21 width 0 timing 0
Sep 18 04:56:54 aether kernel: [  459.231064] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 400000, vdd =3D 15, bus_mode =3D 1, chip_select =3D 0, power_mode =3D=
 2, bus_width =3D 0
Sep 18 04:56:54 aether kernel: [  459.233310] mmc0: starting CMD8 arg 00000=
1aa flags 000002f5
Sep 18 04:56:54 aether kernel: [  459.233321] tifm_sd tifm_sd0:1: executing=
 opcode 0x8, arg: 0x1aa, mask: 0x1140
Sep 18 04:56:54 aether kernel: [  459.233673] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:54 aether kernel: [  459.233688] mmc0: req done (CMD8): -110: =
00000000 00000000 00000000 00000000
Sep 18 04:56:54 aether kernel: [  459.233702] mmc0: starting CMD5 arg 00000=
000 flags 000002e1
Sep 18 04:56:54 aether kernel: [  459.233711] tifm_sd tifm_sd0:1: executing=
 opcode 0x5, arg: 0x0, mask: 0x1340
Sep 18 04:56:54 aether kernel: [  459.234040] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:54 aether kernel: [  459.234054] mmc0: req failed (CMD5): -110=
, retrying...
Sep 18 04:56:54 aether kernel: [  459.234064] tifm_sd tifm_sd0:1: executing=
 opcode 0x5, arg: 0x0, mask: 0x1340
Sep 18 04:56:54 aether kernel: [  459.234390] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.234403] mmc0: req failed (CMD5): -110=
, retrying...
Sep 18 04:56:55 aether kernel: [  459.234412] tifm_sd tifm_sd0:1: executing=
 opcode 0x5, arg: 0x0, mask: 0x1340
Sep 18 04:56:55 aether kernel: [  459.234738] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.234752] mmc0: req failed (CMD5): -110=
, retrying...
Sep 18 04:56:55 aether kernel: [  459.234761] tifm_sd tifm_sd0:1: executing=
 opcode 0x5, arg: 0x0, mask: 0x1340
Sep 18 04:56:55 aether kernel: [  459.235088] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.235103] mmc0: req done (CMD5): -110: =
00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.236465] mmc0: starting CMD55 arg 0000=
0000 flags 000000f5
Sep 18 04:56:55 aether kernel: [  459.236475] tifm_sd tifm_sd0:1: executing=
 opcode 0x37, arg: 0x0, mask: 0x1140
Sep 18 04:56:55 aether kernel: [  459.236809] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.236823] mmc0: req done (CMD55): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.236837] mmc0: starting CMD55 arg 0000=
0000 flags 000000f5
Sep 18 04:56:55 aether kernel: [  459.236846] tifm_sd tifm_sd0:1: executing=
 opcode 0x37, arg: 0x0, mask: 0x1140
Sep 18 04:56:55 aether kernel: [  459.237175] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.237190] mmc0: req done (CMD55): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.237214] mmc0: starting CMD55 arg 0000=
0000 flags 000000f5
Sep 18 04:56:55 aether kernel: [  459.237223] tifm_sd tifm_sd0:1: executing=
 opcode 0x37, arg: 0x0, mask: 0x1140
Sep 18 04:56:55 aether kernel: [  459.237550] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.237564] mmc0: req done (CMD55): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.238600] mmc0: starting CMD55 arg 0000=
0000 flags 000000f5
Sep 18 04:56:55 aether kernel: [  459.238610] tifm_sd tifm_sd0:1: executing=
 opcode 0x37, arg: 0x0, mask: 0x1140
Sep 18 04:56:55 aether kernel: [  459.238939] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.238954] mmc0: req done (CMD55): -110:=
 00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.238973] mmc0: starting CMD1 arg 00000=
000 flags 000000e1
Sep 18 04:56:55 aether kernel: [  459.238983] tifm_sd tifm_sd0:1: executing=
 opcode 0x1, arg: 0x0, mask: 0x1340
Sep 18 04:56:55 aether kernel: [  459.239311] tifm_sd tifm_sd0:1: host even=
t: host_status 80, flags 0
Sep 18 04:56:55 aether kernel: [  459.239326] mmc0: req done (CMD1): -110: =
00000000 00000000 00000000 00000000
Sep 18 04:56:55 aether kernel: [  459.239345] mmc0: clock 0Hz busmode 1 pow=
ermode 0 cs 0 Vdd 0 width 0 timing 0
Sep 18 04:56:55 aether kernel: [  459.239353] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 0, vdd =3D 0, bus_mode =3D 1, chip_select =3D 0, power_mode =3D 0, bu=
s_width =3D 0

Sep 18 04:58:07 aether kernel: [  531.283599] tifm0 : demand removing card =
from socket 0:1
Sep 18 04:58:07 aether kernel: [  531.283649] mmc0: clock 0Hz busmode 1 pow=
ermode 0 cs 0 Vdd 0 width 0 timing 0
Sep 18 04:58:07 aether kernel: [  531.283659] tifm_sd tifm_sd0:1: ios: cloc=
k =3D 0, vdd =3D 0, bus_mode =3D 1, chip_select =3D 0, power_mode =3D 0, bu=
s_width =3D 0
Sep 18 04:58:07 aether kernel: [  531.283888] tifm_sd tifm_sd0:1: after rem=
ove


--MP_/6CF=pvs4e/0GWnKdg=giSVz--

--Sig_/zsv1eHYJ8JUwqFmVDp7Z9vV
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAkyUf+sACgkQokMzJ47YCzpYOgCgkePQV2LpwcEWIYuNR5wSmo7a
wtoAnRng8k3aRrZ876dM0PEYoXDE95cg
=tDLs
-----END PGP SIGNATURE-----

--Sig_/zsv1eHYJ8JUwqFmVDp7Z9vV--
