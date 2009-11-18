From: Cliff Brake <cliff.brake@gmail.com>
Subject: mmc_spi and flash cards
Date: Wed, 18 Nov 2009 10:57:11 -0500
Message-ID: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.186]:7662 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757466AbZKRP5G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2009 10:57:06 -0500
Received: by gv-out-0910.google.com with SMTP id r4so232406gve.37
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2009 07:57:11 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I'm debugging some issues with mmc_spi.  I have 3 mini-SD cards:

- transcend 2G - works
- Sandisk 2GB ultra - works if we play games with the CPHA bit, but
then the transcend card breaks.
- ATP Pro - does not get very far: mmc1: error -38 whilst initialising SD card

Thinking it might be a problem with the PXA270 SPI driver/hardware, I
switched to using the gpio_spi driver, and got exactly the same
results.  I have verified the power is stable.  Next, I plan to dig
into the driver and protocol, but wondered how its working for others:

- has 2.6.31 mmc_spi has been tested with a number of flash cards and works?
- I noticed the driver is playing games with the SPI mode to keep CS
high during some clock pulses.  Is there any concern that the CS will
glitch while changing modes?
- any suggestions as to what to look for?

Thanks,
Cliff
