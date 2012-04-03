From: Hanspeter Spalinger <hanfi@spahan.ch>
Subject: [REGRESSION][3.4-rc1] mmc0: Timeout waiting for hardware interrupt.
Date: Tue, 03 Apr 2012 17:58:46 +0200
Message-ID: <4F7B1E36.1030509@spahan.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig270CF25D3D554DA0DA208469"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.spahan.ch ([88.198.81.77]:60647 "EHLO mail.spahan.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082Ab2DCQH2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Apr 2012 12:07:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig270CF25D3D554DA0DA208469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
My Laptop (HP Elitebook 8560p) started throw
" mmc0: Timeout waiting for hardware interrupt." at updating from
3.3-rc7 to 3.4-rc1 and is no longer able to mount my SD-card.

I bisected this and found the culprit to be:
e6039832bed9a9b967796d7021f17f25b625b616 is the first bad commit
commit e6039832bed9a9b967796d7021f17f25b625b616
Author: Alexander Stein <alexander.stein@systec-electronic.com>
Date:   Tue Mar 13 18:16:40 2012 +0100

    mmc: sdhci-pci: Add MSI support

    Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com=
>
    Signed-off-by: Chris Ball <cjb@laptop.org>

:040000 040000 f8c9958a7d3c6b3aa2f42055d8606e7aac7da8f2
4879d38f9aa4bd526bd561de36833190fa616d36 M	drivers

Kernel information:
$ more /proc/version
Linux version 3.3.0+ (root@lisa) (gcc version 4.6.2 (Gentoo 4.6.2 p1.4,
pie-0.5.0) ) #17 SMP PREEMPT Tue
 Apr 3 17:15:37 CEST 2012
$ scripts/ver_linux
Linux lisa 3.3.0+ #17 SMP PREEMPT Tue Apr 3 17:15:37 CEST 2012 x86_64
Intel(R) Core(TM) i7-2760QM CPU @ 2.40GHz GenuineIntel GNU/Linux

Gnu C                  4.6.2
Gnu make               3.82
binutils               2.21.1
util-linux             2.20.1
mount                  support
module-init-tools      3.16
e2fsprogs              1.42
PPP                    2.4.5
Linux C Library        2.13
Dynamic linker (ldd)   2.13
Procps                 3.2.8
Net-tools              1.60_p20110409135728
Kbd                    1.15.3wip
Sh-utils               8.14
wireless-tools         29
Modules Loaded         ipv6 uvcvideo videobuf2_core videodev
v4l2_compat_ioctl32 videobuf2_vmalloc videobuf2_memops tpm_infineon arc4
xhci_hcd 8250_pci snd_hda_codec_hdmi radeon fbcon tileblit font bitblit
softcursor ttm drm_kms_helper iwlwifi drm ehci_hcd fb snd_hda_codec_idt
mousedev tpm_tis tpm 8250_pnp hp_wmi video usbcore fbdev mac80211
i2c_algo_bit i2c_core firewire_ohci snd_hda_intel firewire_core
cfbcopyarea cfg80211 snd_hda_codec 8250 sparse_keymap hp_accel cfbimgblt
snd_pcm rfkill serial_core wmi lis3lv02d psmouse intel_agp intel_gtt
agpgart e1000e tpm_bios backlight cfbfillrect usb_common coretemp
snd_timer evdev hwmon input_polldev serio_raw snd sr_mod sg cdrom
soundcore snd_page_alloc crc32c_intel ghash_clmulni_intel sha256_generic
sd_mod ahci libahci

Hardware information:
$ lspci -v (cutted to the JMicron device in use)
24:00.0 FireWire (IEEE 1394): JMicron Technology Corp. IEEE 1394 Host
Controller (rev 30) (prog-if 10 [O
HCI])
	Subsystem: Hewlett-Packard Company Device 1618
	Flags: bus master, fast devsel, latency 0, IRQ 18
	Memory at d4200000 (32-bit, non-prefetchable) [size=3D2K]
	Memory at d4205000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [44] Power Management version 3
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [94] MSI: Enable- Count=3D1/1 Maskable- 64bit-
	Kernel driver in use: firewire_ohci
	Kernel modules: firewire-ohci

24:00.1 System peripheral: JMicron Technology Corp. SD/MMC Host
Controller (rev 30)
	Subsystem: Hewlett-Packard Company Device 1618
	Flags: bus master, fast devsel, latency 0, IRQ 47
	Memory at d4204000 (32-bit, non-prefetchable) [size=3D256]
	Expansion ROM at d4700000 [disabled] [size=3D32K]
	Capabilities: [a4] Power Management version 3
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [94] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
	Kernel driver in use: sdhci-pci

24:00.2 SD Host controller: JMicron Technology Corp. Standard SD Host
Controller (rev 30) (prog-if 01)
	Subsystem: Hewlett-Packard Company Device 1618
	Flags: fast devsel, IRQ 18
	Memory at d4203000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [a4] Power Management version 3
	Capabilities: [80] Express Endpoint, MSI 00
	Capabilities: [94] MSI: Enable- Count=3D1/1 Maskable- 64bit-


I posted the full dmesg output at http://pastebin.com/DFPZigKq
Please cc me, as i am not on the mailing list.
If you need more information, let me know.

Greetings
Hanspeter Spalinger


--------------enig270CF25D3D554DA0DA208469
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk97HjYACgkQjLvx8ViUjYKKUgCfbLs6WC8vJbW+DMG3fqCZqyym
WjEAnjHQ5Oibv0LpL6cQkmAJpUSYnWus
=snN/
-----END PGP SIGNATURE-----

--------------enig270CF25D3D554DA0DA208469--
