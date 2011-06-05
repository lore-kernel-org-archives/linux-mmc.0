From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: sdio: reset card during power_restore
Date: Sun, 5 Jun 2011 16:48:25 +0300
Message-ID: <BANLkTimus7C-=_b2hgdfakU6Dt9=FgzyrQ@mail.gmail.com>
References: <20110605123852.BC6F39D401C@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab1FENsq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2011 09:48:46 -0400
Received: by wya21 with SMTP id 21so2257847wya.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2011 06:48:45 -0700 (PDT)
In-Reply-To: <20110605123852.BC6F39D401C@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Sun, Jun 5, 2011 at 3:38 PM, Daniel Drake <dsd@laptop.org> wrote:
> @@ -706,10 +706,25 @@ static int mmc_sdio_power_restore(struct mmc_ho=
st *host)
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Reset the card by performing the same steps that a=
re taken by
> + =A0 =A0 =A0 =A0* mmc_rescan_try_freq() and mmc_attach_sdio() during=
 a "normal" probe
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 sdio_reset(host);

Sending a reset is necessary only if we are re-initing a powered on
card, but in this case, we know that we just powered the card up, so
this is not needed.

+       ret =3D mmc_send_io_op_cond(host, 0, NULL);
+       if (ret)
+               goto out;

Can you please add this under a card quirk ?

The spec does not require this for embedded sdio cards, and we would
like to skip this for wl12xx.

Thanks,
Ohad.
