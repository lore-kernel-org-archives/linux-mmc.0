From: Sebastian Reichel <sre@ring0.de>
Subject: SD card timeout problems on Nokia N900 (omap_hsmmc on OMAP3)
Date: Wed, 26 Feb 2014 00:47:46 +0100
Message-ID: <20140225234746.GA13866@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:46712 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752732AbaBYXrt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Feb 2014 18:47:49 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have problems with the SD-card initialization on my Nokia N900
using a 3.14-rc1 based kernel in DT boot mode. The bug is can be
circumvented by changing the kernel slightly (e.g. remove some DT
nodes or mark them as disabled). So the SD card's timeout problems
seem to derive from kernel timing problems. I'm pretty sure, that
the problems are not originating from a broken SD card, since

 1. The SD card worked quite good before and still does depending
    on unrelated DTS changes (=> loading less drivers).
 2. The SD card works flawlessly on my notebook using a USB adapter
 3. Another SD card showed the same problem

I tried to git bisect the problem, but I just get shown some
unrelated driver additions.

Anyways, this is the error I get during boot:

[    3.896820] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
...
[    5.956237] mmc0: error -110 whilst initialising SD card

I added some debug prints to trace the error:

 * mmc_sd_init_card()
 * mmc_sd_get_cid()
 * mmc_send_app_op_cond()

Can you give me any hints how to find & fix the problem's source?

-- Sebastian

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDSuiAAoJENju1/PIO/qaQUEP/0hKExggHT/zi7I7MdJcUGhs
VKJN+nEAB6XzYfnW1cQimP56cUUk8NT05IYVHipH3iD0oh6MZ5UpxNxYG6810jbv
W8thtRqck0a0Wi5cJ/DTuyo5SSHyWqOVC4BAfYgdAwX5Vi9tEAYSApKNW1+gCPE6
DcAHqJdlj+I37qH/QxhzLCnLZpjhankHagfVoBiRBNy4wtkWEpOJaTGmt63UQN6g
py3pekjo6fl8fPsVOTqoU+rPNRfgtqwRA0xmwPi6E3Pu2+K36CuxaCyheA6Gzysn
BRm5zS8UQ4goHMz/zzIiHkGKfJLntG3aSn/RNKFgGvZBaOpNFhiAstGKA12hdk4P
OJ+BqW6Is7/pzvRQwRGa1nKTFhxXBI+VTc9huqdd8K8l5i5Me0CJ4l3jMqiLyIx/
iykX6H37oJRil2xrpuWFRE+8q+PhNvbMPtek/11vC2QxKVzSC9gcndjiUzW9FI8Q
K+AUPbh+yt5BA7cAScooS+EGePVL51U3o/h1PVFMtVzhUA5NcsjptIJwbG0kcbbl
tZkm3KQ6eFZawgBpHW4+wNHFe6f3Raz7ONOOj7tlF+RMDNxIUF/+uXXTXlJloEQD
V9EJJ8W1+qfndXuLWB2YrBxEjZZhnR6FDYdFAOfzQ+quWMU9anFBQRof6BlkF5pn
x2hNqySsKFN/EaAxR9xn
=GLXc
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
