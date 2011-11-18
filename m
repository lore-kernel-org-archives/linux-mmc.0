From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for
 testing of non read/write Commands
Date: Fri, 18 Nov 2011 18:39:08 +0530
Message-ID: <CANYdXnpAbvNSqMRACLKre3mYR3v4UFSocEBgBTv+EWU3qw+J7Q@mail.gmail.com>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
	<201111171441.48504.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33108 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab1KRNJI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2011 08:09:08 -0500
Received: by iage36 with SMTP id e36so3574463iag.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2011 05:09:08 -0800 (PST)
In-Reply-To: <201111171441.48504.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Venkatraman S <svenkatr@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

Hi Arnd,
Please forgive me for a lengthy mail.

firstly, the Patch has not added testcases in kernel,  but has added
support infrastructure  for handling  different commands. Function
names are misnomers and =E2=80=9C.test_CMD0=E2=80=9D should have instea=
d been
=E2=80=9Csend_CMD0=E2=80=9D.

I have tried to express my views in 2 questions:

Q1 : What all Commands can be sent using MMC block layer IOCTL ?

       Currently  it be used for sending only read/write commands.
       Should it also not support non-data (read/write) commands ?
       If Yes, then the =E2=80=9Cblock.c=E2=80=9D must be modified with=
 few changes to
handle non-data commands by making the read/write code conditional.

Ex:  Code snippet below has to be made conditional i.e. execute only
for read/write commands

	data.sg =3D &sg;
	data.sg_len =3D 1;
	data.blksz =3D idata->ic.blksz;
	data.blocks =3D idata->ic.blocks;

	sg_init_one(data.sg, idata->buf, idata->buf_bytes);

	if (idata->ic.write_flag)
		data.flags =3D MMC_DATA_WRITE;
	else
		data.flags =3D MMC_DATA_READ;

Q2 : Can I send CMD 9 (or any non-data command) via the mmc blk layer
IOCTL ? If not what are the issues ?

As of now non-data commands are not supported. So in order to send CMD
9, the card has to be brought to a certain known state by sending the
pre CMD 9 sequence.

As per the Specification, before sending CMD 9, the following commands
have to be sent
Pre-CMD 9 Sequence
  CMD0 : Reset
  CMD8 : Get ocr
  CMD55 : App command
  CMD41 :
  CMD2 :
  CMD3 :

The implementation for the above can be seen mmc.c  file snippet shown =
below

        CODE SNIPPET : linux/driver/core/mmc.c
	/*
	 * Since we're changing the OCR value, we seem to
	 * need to tell some cards to go back to the idle
	 * state.  We wait 1ms to give cards time to
	 * respond.
	 * mmc_go_idle is needed for eMMC that are asleep
	 */
	mmc_go_idle(host);

	/* The extra bit indicates that we support high capacity */
	err =3D mmc_send_op_cond(host, ocr | (1 << 30), &rocr);
	if (err)
		goto err;

	/*
	 * For SPI, enable CRC as appropriate.
	 */
	if (mmc_host_is_spi(host)) {
		err =3D mmc_spi_set_crc(host, use_spi_crc);
		if (err)
			goto err;
	}

	/*
	 * Fetch CID from card.
	 */
	if (mmc_host_is_spi(host))
		err =3D mmc_send_cid(host, cid);
	else
		err =3D mmc_all_send_cid(host, cid);
	if (err)
		goto err;

	if (oldcard) {
		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) {
			err =3D -ENOENT;
			goto err;
		}

		card =3D oldcard;
	} else {
		/*
		 * Allocate card structure.
		 */
		card =3D mmc_alloc_card(host, &mmc_type);
		if (IS_ERR(card)) {
			err =3D PTR_ERR(card);
			goto err;
		}

		card->type =3D MMC_TYPE_MMC;
		card->rca =3D 1;
		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
	}

	/*
	 * For native busses:  set card RCA and quit open drain mode.
	 */
	if (!mmc_host_is_spi(host)) {
		err =3D mmc_set_relative_addr(card);
		if (err)
			goto free_card;

		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
	}

	if (!oldcard) {
		/*
		 * Fetch CSD from card.
		 */
		err =3D mmc_send_csd(card, card->raw_csd);
		if (err)
			goto free_card;

		err =3D mmc_decode_csd(card);
		if (err)
			goto free_card;
		err =3D mmc_decode_cid(card);  //send CMD9
		if (err)
			goto free_card;
	}
=09
 From user space, in order to send CMD9, the above code snippet should
be available as a single stand alone function. As of now the mmc core
state machine has a single flow which is card enumeration. But if we
want to send stand alone commands from user space, the enumeration
flow has to be broken into single standalone functions specific to the
commands that is they have to send the pre command sequence and get
the card to the proper state to send the user specified command.

The command sent should also work in following scenarios:-
       CASE 1 : Card enumerated, and ready for transfer
       CASE 2 : Card is reset
       CASE 3 : CMD 9 has been sent, now can I send CMD 8

On Thu, Nov 17, 2011 at 8:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 November 2011, Shashidhar Hiremath wrote:
>> The patch provides An infrastructure to test commands other than Rea=
d/Write commands using the IOCTL interface.The Patch can be useful inca=
se of validating the device to verify whether device support a given co=
mmand or not. The result of the sent command will be written to the =C2=
=A0result element of the mmc_ioc_cmd structure passed through IOCTL int=
erface.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> Hi Shashidhar,
>
> Unfortunately, I have to tell you that an implementation like this is
> inappropriate for a number of reasons. My feeling is that most
> importantly you should instead have the test logic entirely in user
> space and only call the existing ioctl in the kernel. This would
> make the entire patch obsolete, so I'm not commenting on the other
> problems.
>
> What has lead you to implementing the individual test cases in the
> kernel?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Arnd
>



--=20
regards,
Shashidhar Hiremath
