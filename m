From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] MMC Agressive clocking framework v6
Date: Mon, 1 Nov 2010 16:24:40 +0100
Message-ID: <AANLkTiki-PGJHMcrRCwA46W+-xmj+AdpxLMFdd2mfdhM@mail.gmail.com>
References: <1288383487-29860-1-git-send-email-linus.walleij@stericsson.com>
	<4CCEA435.9030402@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41171 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627Ab0KAPYz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 11:24:55 -0400
Received: by wwe15 with SMTP id 15so6154637wwe.1
        for <linux-mmc@vger.kernel.org>; Mon, 01 Nov 2010 08:24:54 -0700 (PDT)
In-Reply-To: <4CCEA435.9030402@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>

2010/11/1 David Vrabel <david.vrabel@csr.com>:
> On 29/10/2010 21:18, Linus Walleij wrote:
>> This patch modifies the MMC core code to optionally call the
>> set_ios() operation on the driver with the clock frequency set
>> to 0 (gate) after a grace period of at least 8 MCLK cycles, then
>> restore it (ungate) before any new request. This gives
>> the driver the option to shut down the MCI clock to the MMC/SD
>> card when the clock frequency is 0, i.e. the core has stated
>> that the MCI clock does not need to be generated.
>
> With SDIO cards, 1 bit mode needs to be set on the controller otherwi=
se
> many controllers cannot detect card interrupts.

Do you mean generally, or just when disabling the clock?
I don't quite get this part...

> Also some v2.00 SDIO cards in 4-bit mode will not generate card
> interrupts unless they are clocked (the spec v2.00 doesn't require th=
em
> to be able to but v3.00 does).

OK I think it is better to disable clocking off SDIO cards altogether
for now.

>=A0I would suggest a white list of v2.00
> cards that can generate interrupts asynchronousy.

Hm... does people maintain such lists? Sounds tricksy.
Better avoid it for the time being.

Linus Walleij
