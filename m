From: Cliff Brake <cliff.brake@gmail.com>
Subject: Re: mmc_spi and flash cards
Date: Thu, 14 Jan 2010 16:09:05 -0500
Message-ID: <f96d234e1001141309g746f2f67l9f92d8b8a2dcf49f@mail.gmail.com>
References: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
	 <f96d234e0912280958u559c41e6yd47eea5526b6cbda@mail.gmail.com>
	 <m3d41slhf4.fsf@phlog.console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:35334 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498Ab0ANVJH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2010 16:09:07 -0500
Received: by ewy1 with SMTP id 1so118466ewy.28
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2010 13:09:05 -0800 (PST)
In-Reply-To: <m3d41slhf4.fsf@phlog.console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org

On Sat, Jan 2, 2010 at 9:17 AM, Matt Fleming <matt@console-pimps.org> w=
rote:
> On Mon, 28 Dec 2009 12:58:28 -0500, Cliff Brake <cliff.brake@gmail.co=
m> wrote:
>>
>> >> STOP_TRANSMISSION
>> >> bit 3 -> R1_SPI_COM_CRC (the CRC of the last command failed)
>>
>> mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
>> mmc0: =A0 =A0 4096 bytes transferred: 0
>> mmc0: =A0 =A0 (CMD12): -84: 00000008 00000000 00000000 00000000
>>
>
> That's weird.
>
>> mmc_spi spi1.0: =A0 mmc_spi: CMD12, resp R1B
>> mmc_spi spi1.0: =A0 ... CMD12 response SPI_R1B: resp 0040 00000000
>>
>> >> bit 6, R1_SPI_PARAMETER (commands argument, block length) was out=
 of allowed range for this card.
>>
>
> And that just seems completely bogus; the STOP_TRANSMISSION command
> doesn't require any parameters.
>
> Having read mmc_spi_response_get() I'm wondering if it's actually try=
ing
> to interpret a busy signal as a response code. Would you mind giving
> this patch a go and seeing if the BUG_ON() triggers?
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index d55fe4f..3e36ff4 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -310,6 +310,7 @@ static int mmc_spi_response_get(struct mmc_spi_ho=
st *host,
>
> =A0checkstatus:
> =A0 =A0 =A0 =A0bitshift =3D 0;
> + =A0 =A0 =A0 BUG_ON(*cp =3D=3D 0xff);
> =A0 =A0 =A0 =A0if (*cp & 0x80) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Houston, we have an ugly card with =
a bit-shifted response */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rotator =3D *cp++ << 8;
>

Matt,

I applied the above patch, and the BUG_ON did not trigger.  Appreciate
the ideas, and welcome any other thoughts.

I wonder if there is something wrong with the previous
READ_MULTIPLE_BLOCK command, and that is what the cards are
complaining about, not the STOP_TRANSMISSION command?

I'm decoding the READ_MULTIPLE_BLOCK arguments next ....

Thanks,
Cliff
