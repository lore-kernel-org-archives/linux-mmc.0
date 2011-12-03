From: Daniel Drake <dsd@laptop.org>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Sat, 3 Dec 2011 10:44:18 -0600
Message-ID: <CAMLZHHSGL20vr7E1rMO47RsxOmO-UPRyOdnqq=DUie3FVzNcaQ@mail.gmail.com>
References: <CAMLZHHRF2ygqBRyNm21vv0WnCYKPtduGpW7ME25z55v7nTaRnA@mail.gmail.com>
	<CAK=WgbY22BD8WWk71nL3=D3NZfJY92LXUum8yhV3JyHypjOe-g@mail.gmail.com>
	<CAMLZHHRfitBnmXi=2ndvm5-jm1Mg4+NT83rjuwD9w236E12hQw@mail.gmail.com>
	<CAK=WgbYRvsOur6RmAYMEAf-01e-paGinPU4G_0VesacPGBD5GA@mail.gmail.com>
	<WC20111130150051.910209@terrafix.co.uk>
	<CAK=WgbbBF1=YJyc2MF2fgNtPbbqF=-9L53=LKoEmkgA43PjSdw@mail.gmail.com>
	<WC20111201112805.3502EA@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36438 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552Ab1LCQoU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Dec 2011 11:44:20 -0500
Received: by vbbfc26 with SMTP id fc26so3011477vbb.19
        for <linux-mmc@vger.kernel.org>; Sat, 03 Dec 2011 08:44:20 -0800 (PST)
In-Reply-To: <WC20111201112805.3502EA@terrafix.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thu, Dec 1, 2011 at 5:28 AM, Joe Woodward <jw@terrafix.co.uk> wrote:
> I've had a play with the nRESET line (as far as I can tell it is the =
only pin I have access to), and no joy.
>
> Also tried playing about a bit with the CMD sequence, again no joy.
>
> I'm not entirely sure of the CMD sequence. It seems we get:
> =A0- CMD52 (x2)
> =A0- CMD0
> =A0- CMD8 (fails)
> =A0- CMD5 (fails)
>
> In the "SDIO Simplified Specification Version 2.00" (https://www.sdca=
rd.org/developers/overview/sdio/sdio_spec/Simplified_SDIO_Card_Spec.pdf=
) page 6 it
> seems only a CMD52 should be required to "Re-init IO". Previous threa=
d posts state CMD5 (x2) are required by the 8686, but why CMD0/CMD8?
>
> Incidentally errors only occur after the CMD0, but before the first e=
rror we get (i.e. a change of cs from 1 to 0):
> "mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timin=
g 0".

Can you see how this compares with older working kernels?

Some more things to try:
there are some delays in mmc_power_off - try increasing them to 1000.


mmc_sdio_power_restore does:
sdio_reset (cmd52)
mmc_go_idle (cmd0)
mmc_send_if_cond (cmd8)
mmc_send_io_op_cond (cmd52)

These are the commands you have been looking at from the angle of the l=
ogs.

Try sprinkling in a load of msleep(500) delays before and inbetween
those commands. And if you suspect some of them are not necessary
trying removing them, etc.

Non-scientific but this is how we have got things working so far :)

Thanks,
Daniel
