From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into
 the driver
Date: Fri, 14 Dec 2012 16:33:29 +0000
Message-ID: <20121214163329.GS27617@gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
 <1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
 <20121214151002.GK14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61415 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab2LNQde (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 11:33:34 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1854687bkw.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 08:33:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121214151002.GK14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, 14 Dec 2012, Russell King - ARM Linux wrote:

> On Fri, Dec 14, 2012 at 03:30:29PM +0100, Ulf Hansson wrote:
> > From: Lee Jones <lee.jones@linaro.org>
> >=20
> > There are currently two instances of the ios_handler being used.
> > Both of which mearly toy with some regulator settings. Now there
> > is a GPIO regulator API, we can use that instead, and lessen the
> > per platform burden. By doing this, we also become more Device
> > Tree compatible.
>=20
> Err, why is this needed?  What's wrong with using the 'vmmc' for this=
?

It's a different regulator. The core knows about 'vmmc', which is the
primary one, then there is a regulator called 'vqmmc' which is for I/O
voltage. Until now this was done in a very platform specific way.
Normally by doing gpio_set's. Now there is a regulator API which can
deal with GPIO controlled regulators and there is provision for it in
MMC core also, so it's time to move it to the driver.

> From what I read in the mmc core, vmmc handling via mmc_regulator_set=
_ocr()
> can cope with GPIO-based regulators, and if you have a single GPIO si=
gnal
> then you have a single supply (it's either on or off).  So what's wro=
ng
> with using the existing regulator hooks for this which are already th=
ere?

In our case it's not a 'fixed' regulator (i.e. on/off). The new GPIO
regulator API can also control voltage selection using GPIOs too.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
