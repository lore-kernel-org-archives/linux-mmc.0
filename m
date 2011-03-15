From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Re-Resubmission
Date: Tue, 15 Mar 2011 16:55:07 +0000
Message-ID: <1300208107.1875.271.camel@apple-mac>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	 <1295607004.1816.6.camel@apple-mac> <1299773604.1682.21.camel@apple-mac>
	 <201103151723.32942.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:52836 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357Ab1COQzV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 12:55:21 -0400
In-Reply-To: <201103151723.32942.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

see embedded answers:-

On Tue, 2011-03-15 at 17:23 +0100, Arnd Bergmann wrote:
> On Thursday 10 March 2011, Tony Olech wrote:
> >   Add a driver for Elan Digital System's VUB300 chip
> > which is a USB connected SDIO/SDmem/MMC host controller.
> > A VUB300 chip enables a USB 2.0 or USB 1.1 connected host
> > computer to use SDIO/SD/MMC cards without the need for
> > a directly connected, for example via PCI, SDIO host
> > controller.
> First a small question: I've read that USB mmc controllers
> only work for SDIO but not for storage cards. Is that true
> for this driver?

The chip has been designed to handle memory cards as well
as SDIO, and we have test all we could get our hands on,
and tested for and thus 64M to 8G SD cards. It has also
been tested on a 64M MMC (1 bit) data card.

> If not, I'd probably get one for card testing, since the
> spring loading mechanism in my laptop is starting to wear
> out.
> What are typical products using this?

At the moment the dev kit, which is really just a bare board
USB to SD/SDIO/MMC converter, is available for evaluation.
the chips themselves are available for for purchase - see
our web site for details.

> My comments are mostly for coding style, I didn't see any
> major problems with the operation of the driver.

I am going to have to go through your coding style comments
separately.

Thanks for reading through the code,

Tony Olech

