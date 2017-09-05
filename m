From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Distinguish eMMC and uSD in userspace
Date: Tue, 5 Sep 2017 16:19:03 +0200
Message-ID: <201709051619.03417@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2467708.NcMWabavBP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38113 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbdIEOTH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Sep 2017 10:19:07 -0400
Received: by mail-wm0-f49.google.com with SMTP id 187so19976294wmn.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Sep 2017 07:19:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Vratislav Podzimek <vpodzime@redhat.com>

--nextPart2467708.NcMWabavBP
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

I would like to ask... if I get /dev/mmcblk device, how to check in=20
userspace if it is non-removable eMMC memory or it is removable SD card?

udisks project would like to report correct information and provides=20
correct "icon" to GUI file managers about state if device is removable=20
or not.

See reported ticket:
https://github.com/storaged-project/udisks/issues/358

Apparently RM filed in lsblk nor removable sysfs entry=20
(/sys/block/mmcblk0/removable) could not be used as both of them could=20
not be used for distinguish between eMMC or uSD card.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2467708.NcMWabavBP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlmuslcACgkQi/DJPQPkQ1L+RwCfXpxEESDIDo3sWgvJR8xiv8HD
dMwAn35FGlxb/h5C7z1M7vS+DXpaWaLo
=qOjS
-----END PGP SIGNATURE-----

--nextPart2467708.NcMWabavBP--
