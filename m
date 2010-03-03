From: Wolfgang =?iso-8859-1?q?M=FCes?= <wolfgang.mues@auerswald.de>
Subject: Re: [PATCH 4/7] mmc: at91_mci: use DMA buffer for read
Date: Wed, 3 Mar 2010 08:34:31 +0100
Message-ID: <201003030834.31457.wolfgang.mues@auerswald.de>
References: <20100302133434.761df661.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100302133434.761df661.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, avictor.za@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hi Andrew,

Am Dienstag, 2. M=E4rz 2010 schrieb Andrew Morton:
> Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
>=20
> It's a feature of kunmap_atomic() that it will accept a pointer to an=
y
> location in the page.  So the subtraction isn't strictly needed.
>=20
> And if the subtraction is removed, the (void*) cast can also be remov=
ed.

I did not know this. Thank you for pointing this out. So this part of t=
he=20
patch (which was purely cosmetic because I have seen no error without t=
he=20
subtraction) can be omitted.

best regards
=20
i. A. Wolfgang M=FCes
--=20
Auerswald Gesellschaft f=FCr Datensysteme mbH
Hardware Development
Telefon: +49 (0)5306 9219 562
Telefax: +49 (0)5306 9219 94=20
E-Mail: Wolfgang.Mues@Auerswald.de
Web: http://www.auerswald.de
=20
--------------------------------------------------------------
Auerswald Gesellschaft f=FCr Datensysteme mbH
Vor den Grash=F6fen 1, 38162 Cremlingen
Registriert beim AG Braunschweig HRB 7499
Gesch=E4ftsf=FChrer: Dipl-Ing. Gerhard Auerswald
