From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v3] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Mon, 23 Nov 2009 07:32:46 -0800
Message-ID: <6cb013310911230732s5981f0dajea6a6bb4fd386f02@mail.gmail.com>
References: <1258924585.10992.1.camel@runt> <20091123132555.GA12983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:65216 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZKWPc7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2009 10:32:59 -0500
In-Reply-To: <20091123132555.GA12983@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Nov 23, 2009 at 5:25 AM, Ladislav Michl
<Ladislav.Michl@seznam.cz> wrote:
[...]
>> @@ -167,6 +168,8 @@ struct mmc_omap_host {
>> =C2=A0 =C2=A0 =C2=A0 spinlock_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0clk_lock; =C2=A0 =C2=A0 /* for changing enabled state */
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fclk_enabled:1;
>>
>> + =C2=A0 =C2=A0 unsigned =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0reg_shift:1;
>> +
> [...]
> Here you made reg_shift one bit wide variable...
>
>> @@ -1490,6 +1493,8 @@ static int __init mmc_omap_probe(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 host->reg_shift =3D (cpu_is_omap7xx() ? 1 : 2);
>> +
> ...and here you are possibly trying to set second bit of that variabl=
e. It does
> not work.

Ah, clumsy mistake, I'll fix it and resubmit.

> And sorry to ask again. This very driver works reliable and there are=
 no
> timeouts like this
> mmci-omap mmci-omap.0: command timeout (CMD8)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD5)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> mmci-omap mmci-omap.0: command timeout (CMD55)
> while detecting MMC card on OMAP730? (because I can see them on 5910)=
=2E This question
> is unrelated to your patch.

When booting up, I see the first set of timeouts (CMD8 and CMD5), but
I don't get any timeouts on 55, and it starts up correctly for me,
detecting my SD card and mounting it.  I've got an Angstrom
installation on my SD card and can boot all the way into it with this
patch.

Not sure if it matters, but this is against the linux-omap for-next bra=
nch.

- Cory
