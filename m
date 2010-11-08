From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 1/2] mmc: agressive clocking framework v8
Date: Mon, 8 Nov 2010 10:26:14 +0100
Message-ID: <AANLkTika=H3EOA=WSdyuP9Mexrrh0z6-KjjTiNCj=mLc@mail.gmail.com>
References: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51886 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0KHJ0P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 04:26:15 -0500
Received: by wyb36 with SMTP id 36so3243703wyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2010 01:26:14 -0800 (PST)
In-Reply-To: <1288776170-10141-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, David Vrabel <david.vrabel@csr.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com, Linus Walleij <linus.walleij@stericsson.com>

2010/11/3 Linus Walleij <linus.walleij@stericsson.com>:

> This patch modifies the MMC core code to optionally call the
> set_ios() operation on the driver with the clock frequency set
> to 0 (gate) after a grace period of at least 8 MCLK cycles, then
> restore it (ungate) before any new request. This gives
> the driver the option to shut down the MCI clock to the MMC/SD
> card when the clock frequency is 0, i.e. the core has stated
> that the MCI clock does not need to be generated.
>
> It is inspired by existing clock gating code found in the OMAP
> and Atmel drivers and brings this up to the host abstraction.
> Gating is performed before and after any MMC request.
>
> It exemplifies by implementing this for the MMCI/PL180 MMC/SD
> host controller, but it should be simple to switch OMAP and
> Atmel over to using this instead.
>
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>

I think we have some rough consesus that:

* This patch adds the desired gating functionality to the MMC
  subsystem.
* It can be refactored to reuse parts of runtime PM in the
  future if some eager contributor turns up.

Andrew, can you add this v8 version (not the misguided v9!)
version to your patch stack?

Yours,
Linus Walleij
