From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: Q: mmc au size
Date: Fri, 28 Jun 2013 16:46:21 -0700
Message-ID: <201306281646.21319.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cjb@laptop.org, hsweeten@visionengravers.com
List-Id: linux-mmc@vger.kernel.org

Hello all,

I have a question concerning the "au" size of a SD Card.

I have an old Kingston 64MB SD-Card and lately I have noticed this
kernel message when I use the card:

mmc0: SD Status: Invalid Allocation Unit size.

This is due to the following commit:

commit b63b5e819d5b21ae493c17c356018ffa98d3ee1c
Author: Alan Cox <alan@linux.intel.com>
Date: =C2=A0 Mon Jul 2 18:55:13 2012 +0100

=C2=A0 =C2=A0 mmc: core: correct invalid error checking


=46rom the "SD Specifications, Part 1, Physical Layer Specification",

* AU_SIZE
This 4-bit field indicates AU Size and the value can be selected from
16 KB.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
=C2=A0 AU_SIZE =C2=A0Value Definition
=C2=A0 ------- =C2=A0----------------
=C2=A0 =C2=A0 0h =C2=A0 =C2=A0 Not Defined
=C2=A0 =C2=A0 1h =C2=A0 =C2=A0 16 KB
=C2=A0 =C2=A0 2h =C2=A0 =C2=A0 32 KB
=C2=A0 =C2=A0 3h =C2=A0 =C2=A0 64 KB
=C2=A0 =C2=A0 4h =C2=A0 =C2=A0 128 KB
=C2=A0 =C2=A0 5h =C2=A0 =C2=A0 256 KB
=C2=A0 =C2=A0 6h =C2=A0 =C2=A0 512 KB
=C2=A0 =C2=A0 7h =C2=A0 =C2=A0 1 MB
=C2=A0 =C2=A0 8h =C2=A0 =C2=A0 2 MB
=C2=A0 =C2=A0 9h =C2=A0 =C2=A0 4 MB
=C2=A0 =C2=A0 Ah =C2=A0 =C2=A0 8 MB
=C2=A0 =C2=A0 Bh =C2=A0 =C2=A0 12 MB
=C2=A0 =C2=A0 Ch =C2=A0 =C2=A0 16 MB
=C2=A0 =C2=A0 Dh =C2=A0 =C2=A0 24 MB
=C2=A0 =C2=A0 Eh =C2=A0 =C2=A0 32 MB
=C2=A0 =C2=A0 Fh =C2=A0 =C2=A0 64 MB

Also in the specification is this note:

Sector: is the unit that is related to the erase commands. Its size
is the number of blocks that will be erased in one portion. The size
of a sector is fixed for each device. The information about the sector
size (in blocks) is stored in the CSD. Note that if the card specifies
AU size, sector size should be ignored.

And this:

* SECTOR_SIZE
This field is fixed to 7Fh, which indicates 64 KBytes. This value does
not relate to erase operations. High Capacity and Extended Capacity
cards indicate memory boundary by AU size and this field should not
be used.


So, if an au size of 0 is reported wouldn't the erase size be the
sector size? If nothing else I think the test needs to be adjusted to
not report the error for an au size of 0.

Regards,
Hartley
