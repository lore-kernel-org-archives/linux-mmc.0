From: Wolfgang =?iso-8859-15?q?M=FCes?= <wolfgang.mues@auerswald.de>
Subject: [PATCH] mmc_spi: fail gracefully if host or card do not support the switch command
Date: Wed, 9 Sep 2009 14:02:30 +0100
Message-ID: <200909091502.30345.wolfgang.mues@auerswald.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.auerswald.de ([212.185.163.234]:42031 "EHLO
	mail.auerswald.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752522AbZIINMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 09:12:43 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

=46rom: Wolfgang Muees <wolfgang.mues@auerswald.de>

Some time ago, I have send a patch to the mmc_spi subsystem changing th=
e error=20
codes. This was after a discussion with Pierre about using EINVAL only =
for=20
non-recoverable errors. This patch was accepted as

http://git.kernel.org/linus/fdd858db7113ca64132de390188d7ca00701013d

Unfortunately, several weeks later, I realized that this patch has open=
ed a=20
little can of worms because there are SD cards on the market which

a) claim that they support the switch command
AND
b) refuse to execute this command if operating in SPI mode.

So, such a card would get unusuable in an embedded linux system in SPI =
mode,=20
because the init sequence terminates with an error.

This patch adds the missing error codes to the caller of the switch com=
mand
and restores the old bahaviour to fail gracefully if these commands can=
 not
execute.

This patch should go into 2.6.31 to show up in embedded systems ASAP.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>

---
diff -uprN 2_6_31_rc8/drivers/mmc/core/mmc.c 2_6_31_rc8_switch/drivers/=
mmc/core/mmc.c
--- 2_6_31_rc8/drivers/mmc/core/mmc.c	2009-08-28 02:59:04.000000000 +02=
00
+++ 2_6_31_rc8_switch/drivers/mmc/core/mmc.c	2009-09-09 14:44:45.000000=
000 +0200
@@ -180,11 +180,11 @@ static int mmc_read_ext_csd(struct mmc_c

 	err =3D mmc_send_ext_csd(card, ext_csd);
 	if (err) {
-		/*
-		 * We all hosts that cannot perform the command
-		 * to fail more gracefully
-		 */
-		if (err !=3D -EINVAL)
+		/* If the host or the card can't do the switch,
+		 * fail more gracefully. */
+		if ((err !=3D -EINVAL)
+		 && (err !=3D -ENOSYS)
+		 && (err !=3D -EFAULT))
 			goto out;

 		/*
diff -uprN 2_6_31_rc8/drivers/mmc/core/sd.c 2_6_31_rc8_switch/drivers/m=
mc/core/sd.c
--- 2_6_31_rc8/drivers/mmc/core/sd.c	2009-08-28 02:59:04.000000000 +020=
0
+++ 2_6_31_rc8_switch/drivers/mmc/core/sd.c	2009-09-09 14:45:34.0000000=
00 +0200
@@ -210,11 +210,11 @@ static int mmc_read_switch(struct mmc_ca

 	err =3D mmc_sd_switch(card, 0, 0, 1, status);
 	if (err) {
-		/*
-		 * We all hosts that cannot perform the command
-		 * to fail more gracefully
-		 */
-		if (err !=3D -EINVAL)
+		/* If the host or the card can't do the switch,
+		 * fail more gracefully. */
+		if ((err !=3D -EINVAL)
+		 && (err !=3D -ENOSYS)
+		 && (err !=3D -EFAULT))
 			goto out;

 		printk(KERN_WARNING "%s: problem reading switch "
---
regards

i. A. Wolfgang M=FCes
--=20
Auerswald GmbH & Co. KG
Hardware Development
Telefon: +49 (0)5306 9219 0
Telefax: +49 (0)5306 9219 94=20
E-Mail: Wolfgang.Mues@Auerswald.de
Web: http://www.auerswald.de
=A0
--------------------------------------------------------------
Auerswald GmbH & Co. KG, Vor den Grash=F6fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRA 13289
p.h.G Auerswald Gesch=E4ftsf=FChrungsges. mbH
Registriert beim AG Braunschweig HRB 7463
Gesch=E4ftsf=FChrer: Dipl-Ing. Gerhard Auerswald
