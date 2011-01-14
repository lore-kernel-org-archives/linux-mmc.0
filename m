From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: mmci: U300 "sync with blockend" broken for multi-block?
Date: Fri, 14 Jan 2011 21:13:05 +0100
Message-ID: <AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
	<20110105164344.GD8638@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57756 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1ANUNG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jan 2011 15:13:06 -0500
Received: by pzk35 with SMTP id 35so428997pzk.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jan 2011 12:13:05 -0800 (PST)
In-Reply-To: <20110105164344.GD8638@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin@rab.in>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ulf Hansson <Ulf.Hansson@stericsson.com>, Sebastian Rasmussen <Sebastian.Rasmussen@stericsson.com>, linux-mmc@vger.kernel.org

2011/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> Any chance of pr_debug'ing the complete status register each time you
> service an interrupt? =A0You'll probably need to set the kernel log
> buffer fairly large to ensure that you capture everything.

I did this test now.

Typical read/write test:
dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D16384 count=3D16 of=3D/dev/nul=
l
dd if=3D/dev/zero of=3D/dev/mmcblk0 bs=3D16384 count=3D16

The MCI_DATABLOCKENDMASK is set in both modes so it should appear
after every block (512 bytes) no matter whether you're using DMA
or not. In this case you would expect 0x80 x MCI_DATABLOCKEND
followed by MCI_DATAEND, repeated 16 times.

But this is what happens:

TEST WITH PIO ON U8500 READ:
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0018 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0028 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND

So MCI_DATABLOCKEND only appear if MCI_DATAEND appear
at the same time or soon thereafter.

TEST WITH PIO ON U8500 WRITE:
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000100
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND
mmci-pl18x sdi2: MCI_DATABLOCKEND && MCI_DATAEND

Note: too few MCI_DATABLOCKEND, 32 of them, while
you're expecting 128 of them. This would lead you
to think that maybe you get MCI_DATABLOCKEND for every
fourth block, which has some kind of twisted logic
to it. But in reality this varies: there are sometimes
things like this
for a very large number of blocks:

mmci-pl18x sdi4: START DATA: blksz 0200 blks 01e2 flags 00000100
mmci-pl18x sdi4: MCI_DATABLOCKEND
mmci-pl18x sdi4: MCI_DATABLOCKEND
mmci-pl18x sdi4: MCI_DATABLOCKEND
mmci-pl18x sdi4: MCI_DATABLOCKEND
mmci-pl18x sdi4: MCI_DATABLOCKEND && MCI_DATAEND

Just 4 MCI_DATABLOCKEND for 0x1e2 blocks!
Totally unpredictable.

TEST WITH DMA ON U8500 READ:
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0008 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0038 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000200
mmci-pl18x sdi2: MCI_DATAEND

TEST WITH DMA ON U8500 WRITE:
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0018 flags 00000100
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000100
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000100
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0080 flags 00000100
mmci-pl18x sdi2: MCI_DATAEND
mmci-pl18x sdi2: START DATA: blksz 0200 blks 0068 flags 00000100
mmci-pl18x sdi2: MCI_DATAEND

No sign of MCI_DATABLOCKEND when using DMA. It's not there.

TEST WITH PIO ON U300 READ:
[  699.219323] mmci-pl18x mmci: START DATA: blksz 0200 blks 0080 flags =
00000200
[  699.226623] mmci-pl18x mmci: MCI_DATABLOCKEND
[  699.231085] mmci-pl18x mmci: MCI_DATABLOCKEND
(.. 0x80 in total ...)
[  699.236598] mmci-pl18x mmci: MCI_DATABLOCKEND
[  699.759572] mmci-pl18x mmci: MCI_DATABLOCKEND && MCI_DATAEND
(repeat x16)

WRITE looks the same, just flags=3D00000100 instead
So yes, MCI_DATABLOCKEND indeed does work if you're not
using DMA. Haven't been able to provoke READ nor WRITE
to get the flags after each other, they always seem to appear
simultaneously.

What it problematic with the reads *and* writes is that
sometimes there us a MCI_DATABLOCKEND missing, so the
blocks simply don't add up! This is the real bug that
the sync code was trying to solve, and not in a very
good way.

TEST WITH DMA ON U300 READ:
[   43.402718] mmci-pl18x mmci: START DATA: blksz 0200 blks 0040 flags =
00000200
[   43.414096] mmci-pl18x mmci: MCI_DATAEND
[   43.424922] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.439449] mmci-pl18x mmci: MCI_DATAEND
[   43.449258] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.463692] mmci-pl18x mmci: MCI_DATAEND
[   43.474446] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.488953] mmci-pl18x mmci: MCI_DATAEND
[   43.498793] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.513341] mmci-pl18x mmci: MCI_DATAEND
[   43.524605] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.539141] mmci-pl18x mmci: MCI_DATAEND
[   43.547262] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.561702] mmci-pl18x mmci: MCI_DATAEND
[   43.569592] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000200
[   43.584066] mmci-pl18x mmci: MCI_DATAEND
[   43.591893] mmci-pl18x mmci: START DATA: blksz 0200 blks 0038 flags =
00000200
[   43.602723] mmci-pl18x mmci: MCI_DATAEND

TEST WITH DMA ON U300 WRITE:
[   40.266289] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.301415] mmci-pl18x mmci: MCI_DATAEND
[   40.310951] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.325644] mmci-pl18x mmci: MCI_DATAEND
[   40.334980] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.349552] mmci-pl18x mmci: MCI_DATAEND
[   40.358561] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.373245] mmci-pl18x mmci: MCI_DATAEND
[   40.382234] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.396811] mmci-pl18x mmci: MCI_DATAEND
[   40.406151] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.420838] mmci-pl18x mmci: MCI_DATAEND
[   40.430276] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.444852] mmci-pl18x mmci: MCI_DATAEND
[   40.453939] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.468638] mmci-pl18x mmci: MCI_DATAEND
[   40.477697] mmci-pl18x mmci: START DATA: blksz 0200 blks 0078 flags =
00000100
[   40.492269] mmci-pl18x mmci: MCI_DATAEND
[   40.501770] mmci-pl18x mmci: START DATA: blksz 0200 blks 003b flags =
00000100
[   40.512910] mmci-pl18x mmci: MCI_DATAEND
[   40.522388] mmci-pl18x mmci: START DATA: blksz 0200 blks 0001 flags =
00000100
[   40.529674] mmci-pl18x mmci: MCI_DATAEND
[   40.537511] mmci-pl18x mmci: START DATA: blksz 0200 blks 0001 flags =
00000100
[   40.544790] mmci-pl18x mmci: MCI_DATAEND
[   40.552528] mmci-pl18x mmci: START DATA: blksz 0200 blks 0001 flags =
00000100
[   40.559804] mmci-pl18x mmci: MCI_DATAEND

These tests were done using a file rather than dd but
the pattern is the same as on the U8500: you only get
MCI_DATAEND when using DMA on U300.

So in conclusion:

- The sync code (to make sure both MCI_DATAEND and
  MCI_DATABLOCKEND both arrived) is not necessary.

- Both U300 and Ux500 (and presumably also their
  sibling Nomadik) should be marked as
  .broken_blockend =3D true, it is simply broken, for
  PIO as well as for DMA.

So we should fix a patch that simplifies the code
accordingly: remove the sync and drop the
=2Ebroken_blockend_dma flag for U300, it's simply just
broken, all agree?

Yours,
Linus Walleij
