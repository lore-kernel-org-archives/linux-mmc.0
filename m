From: =?iso-8859-2?q?=A3ukasz_Ma=B6ko?= <ed@yen.ipipan.waw.pl>
Subject: R5C822 SD-card reader not working under kernels 3.7.x
Date: Mon, 14 Jan 2013 17:26:35 +0100
Message-ID: <201301141726.35394@laptok.ed.pl>
Reply-To: ed@yen.ipipan.waw.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from yen.ipipan.waw.pl ([213.135.36.121]:51615 "EHLO
	yen.ipipan.waw.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3ANQg7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jan 2013 11:36:59 -0500
Received: from laptok.localnet (semi.ipipan.waw.pl [213.135.36.104])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by yen.ipipan.waw.pl (Postfix) with ESMTPSA id 4951CFE63
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jan 2013 17:26:40 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello.
I hope, that this is the good plate to write to :-) This is my first po=
st to=20
this forum.

I have a Dell D430 laptop, which has as SD(HC) card reader using Ricoh =
chip:

02:01.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Ho=
st=20
Adapter (rev 18) (prog-if 01)
        Subsystem: Dell Device 0201
        Flags: medium devsel, IRQ 18
        Memory at efbff700 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [80] Power Management version 2

I've been using it for a very long time. The last kernel, where it work=
s=20
(from the ones I've been using) is 3.5.7. Then, I've tried kernel 3.6.1=
0 and=20
then 3.7.{1,2} and the reader is not working there. Simply - nothing ha=
ppens=20
after I inserd a card.

=46or kernels up to 3.5.7 I get some "unwanted" messages like this one:

[128997.817307] sdhci-pci 0000:02:01.2: could not set regulator OCR (-2=
2)

but then everything works. So, although there are such "errors", I'd pr=
efere=20
such behavior to not working at all :-/ I've tried to read some threads=
 from=20
the archive of the list, but all I've found was that it was related to=20
"regulator". It tells me nothing and does not help to make my reader wo=
rk.

Is it possible to make it somehow work at the current state of kernel? =
If=20
not, do you plan to fix it? I can provide you with necessary informatio=
n, of=20
course.
--=20
=A3ukasz Ma=B6ko                                                       =
     _o)
Lukasz.Masko(at)ipipan.waw.pl                                          =
 /\\
Registered Linux User #61028                                           =
_\_V
Ubuntu: staroafryka=F1skie s=B3owo oznaczaj=B1ce "Nie umiem zainstalowa=
=E6 Debiana"
