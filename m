From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: SDHCI I/O errors
Date: Mon, 20 Jun 2011 17:25:08 -0400
Message-ID: <BANLkTi=Dh6N670GfHWXtUnqX+62C9MHmLg@mail.gmail.com>
References: <BANLkTik5wsSaLp_U1uCkoo5D68zBzH31PA@mail.gmail.com>
 <m2y60wxpzy.fsf@bob.laptop.org> <m2pqm8xpdn.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63686 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1FTVZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 17:25:28 -0400
Received: by pvg12 with SMTP id 12so1075937pvg.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 14:25:28 -0700 (PDT)
In-Reply-To: <m2pqm8xpdn.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 3:40 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Andy,
>
> On Mon, Jun 20 2011, Chris Ball wrote:
>> On Mon, Jun 20 2011, Andrew Lutomirski wrote:
>>> I have an SDHC card that works fine in a camera and in several
>>> different USB-based readers. =A0On my sdhci reader (the integrated =
one
>>> on a Lenovo X220), though, it spews stuff like:
>>>
>>> [ =A0306.103556] mmcblk0: error -110 sending read/write command,
>>> response 0x0, card status 0x400b00
>>> [ =A0306.103559] end_request: I/O error, dev mmcblk0, sector 410272
>>> [ =A0306.103595] mmc0: Got data interrupt 0x00600000 even though no=
 data
>>> operation was in progress.
>>> [ =A0306.103597] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER =
DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [ =A0306.103602] sdhci: Sys addr: 0xf9253200 | Version: =A00x000005=
02
>>> [ =A0306.103607] sdhci: Blk size: 0x00007200 | Blk cnt: =A00x000000=
01
>>> [ =A0306.103613] sdhci: Argument: 0x000642a1 | Trn mode: 0x00000013
>>> [ =A0306.103618] sdhci: Present: =A00x01cf0000 | Host ctl: 0x000000=
03
>>> [ =A0306.103623] sdhci: Power: =A0 =A00x0000000f | Blk gap: =A00x00=
000000
>>> [ =A0306.103628] sdhci: Wake-up: =A00x00000000 | Clock: =A0 =A00x00=
000107
>>> [ =A0306.103634] sdhci: Timeout: =A00x00000009 | Int stat: 0x000000=
00
>>> [ =A0306.103639] sdhci: Int enab: 0x02ff00cb | Sig enab: 0x02ff00cb
>>> [ =A0306.103644] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>>> [ =A0306.103649] sdhci: Caps: =A0 =A0 0x21e8c8b2 | Caps_1: =A0 0x00=
008073
>>> [ =A0306.103654] sdhci: Cmd: =A0 =A0 =A00x0000113a | Max curr: 0x00=
000040
>>> [ =A0306.103655] sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>
>>> all over the logs and fails some (but not all) attempts to read it.
>>> The startup messages are:
>>>
>>> [ =A0830.308403] sdhci-pci 0000:0d:00.0: SDHCI controller found
>>> [1180:e823] (rev 4)
>>> [ =A0830.308632] sdhci-pci 0000:0d:00.0: PCI INT A -> GSI 16 (level=
,
>>> low) -> IRQ 16
>>> [ =A0830.308720] sdhci-pci 0000:0d:00.0: setting latency timer to 6=
4
>>> [ =A0830.308730] mmc0: no vmmc regulator found
>>> [ =A0830.308802] Registered led device: mmc0::
>>> [ =A0830.309059] mmc0: SDHCI controller on PCI [0000:0d:00.0] using=
 DMA
>>>
>>> and lspci says:
>>>
>>> 0d:00.0 System peripheral: Ricoh Co Ltd Device e823 (rev 04)
>>>
>>> I see this on 2.6.39.1 and 3.0 git from today.
>>
>> Any idea whether this is present in previous kernels too? =A0It'd be
>> great if you can test a few earlier ones and find out whether we're
>> looking at a regression or just new hardware to add quirks for.

2.6.37 doesn't recognize the reader, and if I add the PCI id via
new_id, the driver fails with a different error.  I'll post that in a
bit.

I tried a 2.6.38 Fedora 15 kernel but it didn't boot (dracut bug).  I
can fiddle with it and get a .38 kernel working if you like.

>
> Ah, could you try this patch, please?
>
> http://thread.gmane.org/gmane.linux.kernel.mmc/8254
> ("mmc: Enable MMC card reader for RICOH [1180:e823]")

Doesn't help.  Some tracing shows that the initial (BIOS-provided?)
value of config byte 0xCB is 0x87.

--Andy
