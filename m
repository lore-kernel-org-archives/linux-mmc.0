From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for
 testing of non read/write Commands
Date: Thu, 24 Nov 2011 10:06:42 +0530
Message-ID: <CANYdXnpQhCFmkL5+u9P73LDhMpCH45=H=ipwrnbYA8N+MRbang@mail.gmail.com>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
	<201111171441.48504.arnd@arndb.de>
	<CANYdXnpAbvNSqMRACLKre3mYR3v4UFSocEBgBTv+EWU3qw+J7Q@mail.gmail.com>
	<201111221604.53474.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40174 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1KXEgn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 23:36:43 -0500
Received: by iage36 with SMTP id e36so2494618iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2011 20:36:42 -0800 (PST)
In-Reply-To: <201111221604.53474.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

Hi Arnd,
  thanks for the reply.

On Tue, Nov 22, 2011 at 9:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 November 2011, Shashidhar Hiremath wrote:
>> Hi Arnd,
>> Please forgive me for a lengthy mail.
>>
>> firstly, the Patch has not added testcases in kernel, =C2=A0but has =
added
>> support infrastructure =C2=A0for handling =C2=A0different commands. =
=46unction
>> names are misnomers and =E2=80=9C.test_CMD0=E2=80=9D should have ins=
tead been
>> =E2=80=9Csend_CMD0=E2=80=9D.
>>
>> I have tried to express my views in 2 questions:
>>
>> Q1 : What all Commands can be sent using MMC block layer IOCTL ?
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Currently =C2=A0it be used for sending on=
ly read/write commands.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Should it also not support non-data (read=
/write) commands ?
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0If Yes, then the =E2=80=9Cblock.c=E2=80=9D=
 must be modified with few changes to
>> handle non-data commands by making the read/write code conditional.
>>
>> Ex: =C2=A0Code snippet below has to be made conditional i.e. execute=
 only
>> for read/write commands
>>
>> =C2=A0 =C2=A0 =C2=A0 data.sg =3D &sg;
>> =C2=A0 =C2=A0 =C2=A0 data.sg_len =3D 1;
>> =C2=A0 =C2=A0 =C2=A0 data.blksz =3D idata->ic.blksz;
>> =C2=A0 =C2=A0 =C2=A0 data.blocks =3D idata->ic.blocks;
>>
>> =C2=A0 =C2=A0 =C2=A0 sg_init_one(data.sg, idata->buf, idata->buf_byt=
es);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (idata->ic.write_flag)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.flags =3D MMC_=
DATA_WRITE;
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data.flags =3D MMC_=
DATA_READ;
>
> This is all fine, I don't object at all to changing the code so it
> supports non-data commands. It should be easy enough to make the abov=
e
> code get executed only if idata->buf_bytes is positive.
>
>> Q2 : Can I send CMD 9 (or any non-data command) via the mmc blk laye=
r
>> IOCTL ? If not what are the issues ?
>>
>> As of now non-data commands are not supported. So in order to send C=
MD
>> 9, the card has to be brought to a certain known state by sending th=
e
>> pre CMD 9 sequence.
>
> The command interface we have is for very low-level commands, and the
> kernel should not try to intercept these.
>
>> As per the Specification, before sending CMD 9, the following comman=
ds
>> have to be sent
>> Pre-CMD 9 Sequence
>> =C2=A0 CMD0 : Reset
>> =C2=A0 CMD8 : Get ocr
>> =C2=A0 CMD55 : App command
>> =C2=A0 CMD41 :
>> =C2=A0 CMD2 :
>> =C2=A0 CMD3 :
>>
>> ...
>>
>> =C2=A0From user space, in order to send CMD9, the above code snippet=
 should
>> be available as a single stand alone function. As of now the mmc cor=
e
>> state machine has a single flow which is card enumeration. But if we
>> want to send stand alone commands from user space, the enumeration
>> flow has to be broken into single standalone functions specific to t=
he
>> commands that is they have to send the pre command sequence and get
>> the card to the proper state to send the user specified command.
>
> I think it is reasonable to require user space to know that it needs =
to
> send all the other commands before it can send CMD9. However, if you
> need the mmc_block driver to perform any other operations besides
> sending commands to the card, you can add new ioctl commands for
> this, e.g. you can have one ioctl to tell the block driver to
> get out of the way and not accept any requests from the block layer
> while you are sending low-level commands, and another ioctl to
> tell the block layer to rescan the card in order to get it into
> a known working state again after you are done with the tests. Would
> that work for you?

Yes, =C2=A0extra ioctl's can help me bringing the card to defined state=
=2E I
will try implementing with this approach.

>
>> The command sent should also work in following scenarios:-
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CASE 1 : Card enumerated, and ready for t=
ransfer
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CASE 2 : Card is reset
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0CASE 3 : CMD 9 has been sent, now can I s=
end CMD 8
>
> Why is that a requirement? I would argue that the user application
> already does things that are outside of the scope of normal
> operation, so it should know what it is doing and cannot expect
> the kernel to perform extra magic behind its back.

I Agree, Kernel need not worry about these scenarios..

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd
>


--=20
regards,
Shashidhar Hiremath
