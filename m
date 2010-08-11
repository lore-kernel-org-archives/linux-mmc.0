From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [patch 044/177] sdio: allow non-standard SDIO cards
Date: Wed, 11 Aug 2010 16:26:07 +0000
Message-ID: <AANLkTimkcMnc__xKEWjGQGcSCp-DZFP=1yOBEBGKVp=v@mail.gmail.com>
References: <201008110101.o7B11o7F027077@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57654 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0HKQ0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 12:26:08 -0400
Received: by qwh6 with SMTP id 6so301669qwh.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Aug 2010 09:26:07 -0700 (PDT)
In-Reply-To: <201008110101.o7B11o7F027077@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, notasas@gmail.com, adrian.hunter@nokia.com, kishore.kadiyala@ti.com, kvalo@adurom.com, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, madhu.cr@ti.com, me@bobcopeland.com, tony@atomide.com

2010/8/11  <akpm@linux-foundation.org>:
> From: Grazvydas Ignotas <notasas@gmail.com>
>
> There are some chips (like TI WL12xx series) that can be interfaced o=
ver
> SDIO but don't support the SDIO specification, meaning that they are
> missing CIA (Common I/O Area) with all it's registers. =A0Current Lin=
ux SDIO
> implementation relies on those registers to identify and configure th=
e
> card, so non-standard cards can not function and cause lots of warnin=
gs
> from the core when it reads invalid data from non-existent registers.
>
> After this patch, init_card() host callback can now set new quirk
> MMC_QUIRK_NONSTD_SDIO, which means that SDIO core should not try to a=
ccess
> any standard SDIO registers and rely on init_card() to fill all SDIO
> structures instead. =A0As those cards are usually embedded chips, all=
 the
> required information can be obtained from machine board files by the =
host
> driver when it's called through init_card() callback.
>
[...]
> diff -puN drivers/mmc/core/sdio.c~sdio-allow-non-standard-sdio-cards =
drivers/mmc/core/sdio.c
> --- a/drivers/mmc/core/sdio.c~sdio-allow-non-standard-sdio-cards
> +++ a/drivers/mmc/core/sdio.c
[...]
> @@ -412,6 +418,23 @@ static int mmc_sdio_init_card(struct mmc
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (card->quirks & MMC_QUIRK_NONSTD_SDIO) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is non-standard SDIO device, =
meaning it doesn't
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* have any CIA (Common I/O area) reg=
isters present.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* It's host's responsibility to fill=
 cccr and cis
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* structures in init_card().
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_clock(host, card->cis.max_dtr);
> +

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->cccr.high_speed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_highspeed(=
card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_timing(card->ho=
st, MMC_TIMING_SD_HS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Since this goes after patch 032/177 "mmc: split mmc_sd_init_card()",
you can use:

    if (card->cccr.high_speed)
        mmc_sd_go_highspeed(card);

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto finish;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Read the common registers.
> =A0 =A0 =A0 =A0 */
[...]

Best Regards,
Micha=B3 Miros=B3aw
