From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Tue, 3 Jun 2014 15:28:09 +0200
Message-ID: <CAPDyKFqi0-Fa0rZAvCO0GukNTrMy9R1io8bLYr_KEceRRFb+-Q@mail.gmail.com>
References: <537E31F7.1030505@gmail.com>
	<537F1148.3010102@redhat.com>
	<20140523112239.GB12304@sirena.org.uk>
	<537F3610.3050104@redhat.com>
	<20140523162718.GE22111@sirena.org.uk>
	<53806F26.6050706@redhat.com>
	<20140525123452.GS22111@sirena.org.uk>
	<53824294.1090609@redhat.com>
	<20140526103807.GV22111@sirena.org.uk>
	<538321AB.4050006@redhat.com>
	<20140526142225.GF22111@sirena.org.uk>
	<538356DA.7090302@redhat.com>
	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
	<53838023.2080807@redhat.com>
	<CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
	<5385AF94.90004@redhat.com>
	<CAPDyKFpd1mPi1pqTxx=uNG+MsprCngZN-WFnNQrB_1+WuA0faA@mail.gmail.com>
	<538DAC58.90001@redhat.com>
	<CAPDyKFr67c0NfL6+_0mejz2rSjwCLXhhGVqXpicerM1ZwRMNmg@mail.gmail.com>
	<538DC873.8000809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:52604 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaFCN2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 09:28:11 -0400
Received: by mail-qa0-f52.google.com with SMTP id cm18so4749223qab.25
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 06:28:10 -0700 (PDT)
In-Reply-To: <538DC873.8000809@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

[snip]

>>
>> Why do we need to put the sdio functions devices in DT?
>
> To define sdio function specific non probable info, such as oob irqs,
> also see the "mmc: Add SDIO function devicetree subnode parsing" patch-set
> of which I send v3 this morning.

Yes, of course - makes sense.

[snip]

>>>> I see these important things that follow if we decide to use runtime
>>>> PM to trigger the power up/off sequence.
>>>> 1) In cases of !CONFIG_PM_RUNTIME, it means the "powerup driver" once
>>>> probed, will keep it's resources enabled forever.
>>>
>>> Ack.
>>
>> So, the consequence is that for CONFIG_PM_SLEEP systems not using
>> CONFIG_PM_RUNTIME - we don't have a good solution.
>>
>> Is that acceptable?
>
> IMHO yes, if people want maximum power savings they should use
> CONFIG_PM_RUNTIME. And since this is all for yet to be added
> systems / configs I would expect CONFIG_PM_RUNTIME to be supported
> there just fine.

That's a valid point, but on the other hand, "old" systems could
benefit from this "feature" as well, were runtime PM might not be that
interesting.

Kind regards
Uffe
