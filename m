From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for testing of non read/write Commands
Date: Tue, 22 Nov 2011 16:04:53 +0000
Message-ID: <201111221604.53474.arnd@arndb.de>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com> <201111171441.48504.arnd@arndb.de> <CANYdXnpAbvNSqMRACLKre3mYR3v4UFSocEBgBTv+EWU3qw+J7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57443 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab1KVQFG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 11:05:06 -0500
In-Reply-To: <CANYdXnpAbvNSqMRACLKre3mYR3v4UFSocEBgBTv+EWU3qw+J7Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

On Friday 18 November 2011, Shashidhar Hiremath wrote:
> Hi Arnd,
> Please forgive me for a lengthy mail.
>=20
> firstly, the Patch has not added testcases in kernel,  but has added
> support infrastructure  for handling  different commands. Function
> names are misnomers and =E2=80=9C.test_CMD0=E2=80=9D should have inst=
ead been
> =E2=80=9Csend_CMD0=E2=80=9D.
>=20
> I have tried to express my views in 2 questions:
>=20
> Q1 : What all Commands can be sent using MMC block layer IOCTL ?
>=20
>        Currently  it be used for sending only read/write commands.
>        Should it also not support non-data (read/write) commands ?
>        If Yes, then the =E2=80=9Cblock.c=E2=80=9D must be modified wi=
th few changes to
> handle non-data commands by making the read/write code conditional.
>=20
> Ex:  Code snippet below has to be made conditional i.e. execute only
> for read/write commands
>=20
> 	data.sg =3D &sg;
> 	data.sg_len =3D 1;
> 	data.blksz =3D idata->ic.blksz;
> 	data.blocks =3D idata->ic.blocks;
>=20
> 	sg_init_one(data.sg, idata->buf, idata->buf_bytes);
>=20
> 	if (idata->ic.write_flag)
> 		data.flags =3D MMC_DATA_WRITE;
> 	else
> 		data.flags =3D MMC_DATA_READ;

This is all fine, I don't object at all to changing the code so it
supports non-data commands. It should be easy enough to make the above
code get executed only if idata->buf_bytes is positive.

> Q2 : Can I send CMD 9 (or any non-data command) via the mmc blk layer
> IOCTL ? If not what are the issues ?
>=20
> As of now non-data commands are not supported. So in order to send CM=
D
> 9, the card has to be brought to a certain known state by sending the
> pre CMD 9 sequence.

The command interface we have is for very low-level commands, and the
kernel should not try to intercept these.

> As per the Specification, before sending CMD 9, the following command=
s
> have to be sent
> Pre-CMD 9 Sequence
>   CMD0 : Reset
>   CMD8 : Get ocr
>   CMD55 : App command
>   CMD41 :
>   CMD2 :
>   CMD3 :
>=20
> ...
> =09
>  From user space, in order to send CMD9, the above code snippet shoul=
d
> be available as a single stand alone function. As of now the mmc core
> state machine has a single flow which is card enumeration. But if we
> want to send stand alone commands from user space, the enumeration
> flow has to be broken into single standalone functions specific to th=
e
> commands that is they have to send the pre command sequence and get
> the card to the proper state to send the user specified command.

I think it is reasonable to require user space to know that it needs to
send all the other commands before it can send CMD9. However, if you
need the mmc_block driver to perform any other operations besides
sending commands to the card, you can add new ioctl commands for
this, e.g. you can have one ioctl to tell the block driver to
get out of the way and not accept any requests from the block layer
while you are sending low-level commands, and another ioctl to
tell the block layer to rescan the card in order to get it into
a known working state again after you are done with the tests. Would
that work for you?

> The command sent should also work in following scenarios:-
>        CASE 1 : Card enumerated, and ready for transfer
>        CASE 2 : Card is reset
>        CASE 3 : CMD 9 has been sent, now can I send CMD 8

Why is that a requirement? I would argue that the user application
already does things that are outside of the scope of normal
operation, so it should know what it is doing and cannot expect
the kernel to perform extra magic behind its back.

	Arnd
