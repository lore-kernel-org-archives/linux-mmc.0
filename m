From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: mmc_spi and flash cards
Date: Mon, 28 Dec 2009 12:58:28 -0500
Message-ID: <f96d234e0912280958u559c41e6yd47eea5526b6cbda@mail.gmail.com>
References: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:50692 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZL1R63 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2009 12:58:29 -0500
Received: by ewy19 with SMTP id 19so2016916ewy.21
        for <linux-mmc@vger.kernel.org>; Mon, 28 Dec 2009 09:58:28 -0800 (PST)
In-Reply-To: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Some more decoding of response codes.  Its interesting the both cards
return an error at the same place in the init sequence.  I suspect
that we are sending something bogus to the cards, but the transcend
and ATP cards seems to recover, but the Sandisk does not.

It appears that all this activity happens before the card is mounted
(must be scanning partition tables, etc).


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Sandisk:

mmc0: starting CMD18 arg 7927f000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   ... CMD12 response SPI_R1B: resp 0008 00000000

>> STOP_TRANSMISSION
>> bit 3 -> R1_SPI_COM_CRC (the CRC of the last command failed)

mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): -84: 00000008 00000000 00000000 00000000

>> -84 (matches code, EILSEQ)

mmcblk0: retrying using single block read
mmc0: starting CMD17 arg 7927f000 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:   ... CMD17 response SPI_R1: resp 0004 00000000

>> R1_SPI_ILLEGAL_COMMAND

mmc0: req done (CMD17): -38: 00000004 00000000 00000000 00000000
mmc0:     0 bytes transferred: 0
mmc0: starting CMD13 arg 00000000 flags 00000195
mmc_spi spi1.0:   mmc_spi: CMD13, resp R2/R5
mmc_spi spi1.0:   ... CMD13 response SPI_R2/R5: resp ff04 00000000

>> another R1_SPI_ILLEGAL_COMMAND

mmc0: req done (CMD13): -38: 0000ff04 00000000 00000000 00000000
mmcblk0: error -38 sending status comand
mmcblk0: error -38 sending read/write command, response 0x4, card statu=
s 0xff04
end_request: I/O error, dev mmcblk0, sector 3970040
mmc0: starting CMD17 arg 7927f200 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:   ... CMD17 response SPI_R1: resp 0004 00000000
mmc0: req done (CMD17): -38: 00000004 00000000 00000000 00000000


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Transcend card:

mmc0: starting CMD18 arg 77eff000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   ... CMD12 response SPI_R1B: resp 0040 00000000

>> bit 6, R1_SPI_PARAMETER (commands argument, block length) was out of=
 allowed range for this card.

mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): -14: 00000040 00000000 00000000 00000000
mmcblk0: retrying using single block read
mmc0: starting CMD17 arg 77eff000 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:   ... CMD17 response SPI_R1: resp 0040 00000000
mmc0: req done (CMD17): -14: 00000040 00000000 00000000 00000000
mmc0:     0 bytes transferred: 0
mmc0: starting CMD13 arg 00000000 flags 00000195
mmc_spi spi1.0:   mmc_spi: CMD13, resp R2/R5
mmc_spi spi1.0:   ... CMD13 response SPI_R2/R5: resp ff4c 00000000
mmc0: req done (CMD13): -14: 0000ff4c 00000000 00000000 00000000
mmcblk0: error -14 sending status comand
mmcblk0: error -14 sending read/write command, response 0x40, card stat=
us 0xff4c
end_request: I/O error, dev mmcblk0, sector 3930104


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ATP card

mmc0: starting CMD18 arg 3d07f000 flags 000000b5
mmc0:     blksz 512 blocks 8 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmc_spi spi1.0:   mmc_spi: CMD18, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
mmc_spi spi1.0:   ... CMD12 response SPI_R1B: resp 0040 00000000

>> bit 6, R1_SPI_PARAMETER (commands argument, block length) was out of=
 allowed range for this card.

mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
mmc0:     4096 bytes transferred: 0
mmc0:     (CMD12): -14: 00000040 00000000 00000000 00000000
mmcblk0: retrying using single block read
mmc0: starting CMD17 arg 3d07f000 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc0: req done (CMD17): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD17 arg 3d07f200 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc0: req done (CMD17): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD17 arg 3d07f400 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc0: req done (CMD17): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD17 arg 3d07f600 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc0: req done (CMD17): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD17 arg 3d07f800 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmc_spi spi1.0:   mmc_spi: CMD17, resp R1
mmc_spi spi1.0:     mmc_spi: read block, 512 bytes
mmc0: req done (CMD17): 0: 00000000 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD17 arg 3d07fa00 flags 000000b5


On Wed, Nov 18, 2009 at 10:57 AM, Cliff Brake <cliff.brake@gmail.com> w=
rote:
> Hello,
>
> I'm debugging some issues with mmc_spi. =A0I have 3 mini-SD cards:
>
> - transcend 2G - works
> - Sandisk 2GB ultra - works if we play games with the CPHA bit, but
> then the transcend card breaks.
> - ATP Pro - does not get very far: mmc1: error -38 whilst initialisin=
g SD card
>
> Thinking it might be a problem with the PXA270 SPI driver/hardware, I
> switched to using the gpio_spi driver, and got exactly the same
> results. =A0I have verified the power is stable. =A0Next, I plan to d=
ig
> into the driver and protocol, but wondered how its working for others=
:
>
> - has 2.6.31 mmc_spi has been tested with a number of flash cards and=
 works?
> - I noticed the driver is playing games with the SPI mode to keep CS
> high during some clock pulses. =A0Is there any concern that the CS wi=
ll
> glitch while changing modes?
> - any suggestions as to what to look for?
>
> Thanks,
> Cliff
>
