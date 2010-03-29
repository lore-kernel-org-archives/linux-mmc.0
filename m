From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 0/5] ARM: PrimeCell DMA patches v4
Date: Tue, 30 Mar 2010 01:35:28 +0200
Message-ID: <1269905728-5452-1-git-send-email-linus.walleij@stericsson.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.df.lth.se ([194.47.250.12]:56342 "EHLO df.lth.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752742Ab0C3AQJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Mar 2010 20:16:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Linus Walleij <linus.walleij@stericsson.com>

This is a fourth iteration of the PrimeCell DMA API on top of the
generic DMA devices (sibling to the DMA engine). It's based on
the suggestion from Russell to try and define a specific extension
subset for DMA devices.

Since last iteration the changes are:

- Some necessary extensions to the DMA engine were folded into
  the generic DMA engine framework and are now pending in Dan's
  -next tree.

- I have now also implemented support for the PL022 PrimeCell.

PL011, PL022 and PL180 drivers were tested on the U300 with the
COH 901 318 DMA device.

The PL011 driver was also tested on the U8500 with the pending
DMA40 DMA device.

We're running huge and high-speed transfers on all peripherals.
It works.

Patches will be added to the patch tracker soonish, but if this
is eventually OK:ed by Russell I guess it will have to go in
through Dan's DMA tree. Also Grant has to OK it as maintainer of
the SPI subsystem.

Yours,
Linus Walleij
ST-Ericsson SA
