From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] MMC GPIO polarity flag usage
Date: Mon, 14 Jan 2013 10:56:14 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301140954470.29911@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63233 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236Ab3ANJ4T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jan 2013 04:56:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>

Hi all

I'm confused by the ways to specify GPIO polarity in general and for MMC 
card-detect and write-protect pins specifically.

IIUC, the flags variable as returned by a call to 
of_get_named_gpio_flags(..., &flags) should be platform-independent, if a 
specific gpio driver choses to define their gpio cells in a non-standard 
way, not according to "*-gpios = <&gpio gpio_number flags>" they shall be 
providing an .of_xlate() method to convert whatever their GPIO information 
to standard data. So far the GPIO subsystem defines only one flag 
OF_GPIO_ACTIVE_LOW. Any other use of the above flags is invalid.

The first confusing thing about those flags is, that they are defined as 
an enum, and not as a bit-field. This seems to suggest, that one only 
should be comparing flags to specific enum values, and not checking set 
bits, like e.g. drivers/usb/host/ohci-at91.c and drivers/hwmon/gpio-fan.c 
are doing. Logically, this should indeed be a bit-field, in which case 
of_get_named_gpio_flags()'s prototype should be changed, as well as the 
definition of OF_GPIO_ACTIVE_LOW.

Secondly, drivers/pinctrl/pinctrl-nomadik.c seems to be doing a wrong 
thing - they are defining extended incompatible flags' bits in 
Documentation/devicetree/bindings/gpio/gpio-nmk.txt and not providing an 
.of_xlate() method.

All drivers quoted above are just examples, that I stumbled ver, while 
trying to figure out what's the right way to use flags and how others do 
that. There are most likely more of them in the tree.

Thirdly, Documentation/devicetree/bindings/mmc/mmc.txt defines the use of 
gpio-bindings:

  - cd-gpios: Specify GPIOs for card detection, see gpio binding
- wp-gpios: Specify GPIOs for write protection, see gpio binding

but additionally defines two boolean properties:

- cd-inverted: when present, polarity on the cd gpio line is inverted
- wp-inverted: when present, polarity on the wp gpio line is inverted

which should be redundant and instead GPIO flags should be used?

Are my above conclusions correct and what should we do to improve the 
situation?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
