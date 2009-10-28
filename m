From: =?ISO-8859-1?Q?Thiago_A=2E_Corr=EAa?= <thiago.correa@gmail.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
Date: Tue, 27 Oct 2009 22:53:26 -0200
Message-ID: <d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	 <20090930155557.7dae503b@hskinnemoen-d830>
	 <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	 <cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	 <20091028083548.38f1d80c@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f208.google.com ([209.85.219.208]:38840 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056AbZJ1AxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2009 20:53:22 -0400
In-Reply-To: <20091028083548.38f1d80c@hskinnemoen-d830>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Andrew Victor <avictor.za@gmail.com>, linux-mmc@vger.kernel.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Tue, Oct 27, 2009 at 10:35 PM, Haavard Skinnemoen
<haavard.skinnemoen@atmel.com> wrote:
> Andrew Victor <avictor.za@gmail.com> wrote:
>> > +static struct mci_platform_data __initdata mci0_data =3D {
>> > + =A0 =A0 =A0 .slot[0] =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bus_width =A0 =A0 =A0=3D 4,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .detect_pin =A0 =A0 =3D AT91_PIN_PD1=
0,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .wp_pin =A0 =A0 =A0 =A0 =3D -1,
>> > + =A0 =A0 =A0 },
>>
>> Causes at91_set_gpio_input() to be called for pin -1. =A0Which shoul=
dn't be valid.
>> AT91 platforms use 0 to indicate an un-connected GPIO pin, so the
>> assignment of "wp_pin" should probably just be removed.
>
> The mci driver expects non-existent pins to have a negative value, as
> do all other drivers which use gpio_is_valid().
>

Then I think it would be best to use GPIO_PIN_NONE. Makes it clear
what is expected and avoids confusion on what should be the proper
value.
I hope I'm not saying non-sense, but even if I am, I guess you can see
that I'm advocating against the magic numbers :)


Kind Regards,
   Thiago A. Correa
