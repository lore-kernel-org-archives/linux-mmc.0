From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] MMC Agressive clocking framework v6
Date: Mon, 01 Nov 2010 11:27:49 +0000
Message-ID: <4CCEA435.9030402@csr.com>
References: <1288383487-29860-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queue01.mail.zen.net.uk ([212.23.3.234]:59448 "EHLO
	queue01.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab0KALsP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 07:48:15 -0400
In-Reply-To: <1288383487-29860-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>

On 29/10/2010 21:18, Linus Walleij wrote:
> This patch modifies the MMC core code to optionally call the
> set_ios() operation on the driver with the clock frequency set
> to 0 (gate) after a grace period of at least 8 MCLK cycles, then
> restore it (ungate) before any new request. This gives
> the driver the option to shut down the MCI clock to the MMC/SD
> card when the clock frequency is 0, i.e. the core has stated
> that the MCI clock does not need to be generated.

With SDIO cards, 1 bit mode needs to be set on the controller otherwise
many controllers cannot detect card interrupts.

Also some v2.00 SDIO cards in 4-bit mode will not generate card
interrupts unless they are clocked (the spec v2.00 doesn't require them
to be able to but v3.00 does).  I would suggest a white list of v2.00
cards that can generate interrupts asynchronousy.

David
