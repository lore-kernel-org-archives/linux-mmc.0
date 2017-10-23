From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.14-rc2 on thinkpad x220: out of memory when inserting mmc card
Date: Mon, 23 Oct 2017 11:31:09 +0200
Message-ID: <20171023093109.GI32228@amd>
References: <20170905194739.GA31241@amd>
 <20171001093704.GA12626@amd>
 <20171001102647.GA23908@amd>
 <201710011957.ICF15708.OOLOHFSQMFFVJt@I-love.SAKURA.ne.jp>
 <72c93a69-610f-027e-c028-379b97b6f388@intel.com>
 <20171002084131.GA24414@amd>
 <CACRpkdbatrt0Uxf8653iiV-OKkgcc0Ziog_L4oDVTJVNqtNN0Q@mail.gmail.com>
 <20171002130353.GA25433@amd>
 <184b3552-851c-7015-dd80-76f6eebc33cc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <184b3552-851c-7015-dd80-76f6eebc33cc@intel.com>
Sender: owner-linux-mm@kvack.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-mmc@vger.kernel.org


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Did you use bounce buffers? Those were improving performance on
> >> some laptops with TI or Ricoh host controllers and nothing else was
> >> ever really using it (as can be seen from the commit).
> >=20
> > Thinkpad X220... how do I tell if I was using them? I believe so,
> > because I uncovered bug in them before.
>=20
> You are certainly using bounce buffers.  What does lspci -knn show?

Here is the output:
									Pavel

00:00.0 Host bridge [0600]: Intel Corporation 2nd Generation Core Processor=
 Family DRAM Controller [8086:0104] (rev 09)
	Subsystem: Lenovo Device [17aa:21da]
00:02.0 VGA compatible controller [0300]: Intel Corporation 2nd Generation =
Core Processor Family Integrated Graphics Controller [8086:0126] (rev 09)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: i915
00:16.0 Communication controller [0780]: Intel Corporation 6 Series/C200 Se=
ries Chipset Family MEI Controller #1 [8086:1c3a] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
00:19.0 Ethernet controller [0200]: Intel Corporation 82579LM Gigabit Netwo=
rk Connection [8086:1502] (rev 04)
	Subsystem: Lenovo Device [17aa:21ce]
	Kernel driver in use: e1000e
00:1a.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chips=
et Family USB Enhanced Host Controller #2 [8086:1c2d] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: ehci-pci
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series Chipset=
 Family High Definition Audio Controller [8086:1c20] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: snd_hda_intel
00:1c.0 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset F=
amily PCI Express Root Port 1 [8086:1c10] (rev b4)
	Kernel driver in use: pcieport
00:1c.1 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset F=
amily PCI Express Root Port 2 [8086:1c12] (rev b4)
	Kernel driver in use: pcieport
00:1c.3 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset F=
amily PCI Express Root Port 4 [8086:1c16] (rev b4)
	Kernel driver in use: pcieport
00:1c.4 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset F=
amily PCI Express Root Port 5 [8086:1c18] (rev b4)
	Kernel driver in use: pcieport
00:1d.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chips=
et Family USB Enhanced Host Controller #1 [8086:1c26] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: ehci-pci
00:1f.0 ISA bridge [0601]: Intel Corporation QM67 Express Chipset Family LP=
C Controller [8086:1c4f] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
00:1f.2 SATA controller [0106]: Intel Corporation 6 Series/C200 Series Chip=
set Family 6 port SATA AHCI Controller [8086:1c03] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: ahci
00:1f.3 SMBus [0c05]: Intel Corporation 6 Series/C200 Series Chipset Family=
 SMBus Controller [8086:1c22] (rev 04)
	Subsystem: Lenovo Device [17aa:21da]
03:00.0 Network controller [0280]: Intel Corporation Centrino Wireless-N 10=
00 [Condor Peak] [8086:0084]
	Subsystem: Intel Corporation Centrino Wireless-N 1000 BGN [8086:1315]
	Kernel driver in use: iwlwifi
0d:00.0 System peripheral [0880]: Ricoh Co Ltd PCIe SDXC/MMC Host Controlle=
r [1180:e823] (rev 07)
	Subsystem: Lenovo Device [17aa:21da]
	Kernel driver in use: sdhci-pci


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnttt0ACgkQMOfwapXb+vLqXgCfaIFUz7qLZCB0/U9SaBZ82hUr
r5MAnj6hXymhFTkY860ps3dku4LXlMTw
=IRor
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
