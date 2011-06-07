From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Tue, 7 Jun 2011 17:41:18 +0100
Message-ID: <BANLkTin=+QGN=6_YjH8uEyZBbnTjuEXDjA@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
	<BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62579 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756589Ab1FGQlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 12:41:18 -0400
Received: by pzk9 with SMTP id 9so2614792pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 09:41:18 -0700 (PDT)
In-Reply-To: <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 5 June 2011 14:48, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Reset the card by performing the same steps that =
are taken by
>> + =A0 =A0 =A0 =A0* mmc_rescan_try_freq() and mmc_attach_sdio() durin=
g a "normal" probe
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 sdio_reset(host);
>
> Sending a reset is necessary only if we are re-initing a powered on
> card, but in this case, we know that we just powered the card up, so
> this is not needed.

Don't ask me for an explanation, but this is required here, for the
following scenario:

1. Power up and probe
2. Power down via runtime pm
3. Power up

step 3 needs the reset (even though it wasnt needed in step 1),
otherwise mmc_send_io_op_cond() fails with a timeout.

It is also needed for:

1. Power up
2. Suspend, libertas handler returns -ENOSYS so card gets powered down
3. System resume
4. Reprobe needs to power up card

Step 4 fails without this reset.

> + =A0 =A0 =A0 ret =3D mmc_send_io_op_cond(host, 0, NULL);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> Can you please add this under a card quirk ?
>
> The spec does not require this for embedded sdio cards, and we would
> like to skip this for wl12xx.

I could do this if it is required for merge, but I don't agree with
it. Are you suggesting that a quirk is used to enable this reset, or
to disable it? It seems overkill for something that is going to be
trivial and harmless to your setup.

Also, the most frustrating thing when working on this issue is that
the codepaths for powering up a SD card between the following 3
situations are significantly different:
 1. Power up and probe during boot
 2. Resume from suspend
 3. Power up after runtime suspend

It feels like there should be a lot more in common here. My patch is
adding some coherence to the process (and there is still plenty of
room for improvement, but adding quirks won't help...).

Daniel
