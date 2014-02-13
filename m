From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Thu, 13 Feb 2014 10:42:48 +0000
Message-ID: <20140213104248.GU26684@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <52E700F0.7040708@gmail.com> <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com> <201401281148.10670.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34851 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753494AbaBMKnG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 05:43:06 -0500
Content-Disposition: inline
In-Reply-To: <201401281148.10670.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Olof Johansson <olof@lixom.net>, linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, mark.rutland@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>

On Tue, Jan 28, 2014 at 11:48:10AM +0100, Arnd Bergmann wrote:
> I think there is another option, which does have its own pros and cons:
> We could move all the power handling back into the sdio function driver
> if we allow a secondary detection path using DT rather than the probing
> of the SDIO bus.

No thanks.

What if we have a platform where things subtly change, like for instance,
the wiring on the SD slot to fix a problem with UHS-1 cards, which means
you don't have UHS-1 support for some platforms but do for others.

What if you have a platform which uses a brcm4329 chip for Wifi, but then
later in the production run switch to using a different Wifi chipset?

With this information encoded into DT, the number of DT files quickly
increases, and then this presents its own problem - how do users get to
know which DT file should be used for their platform when all they see
externally is "a product of type A"?

Let's say that the board folk were kind enough to set some kind of
identifing feature for the first but not the second (why would they,
it's probe-able, damn it).

The "we can do it in DT" approach just makes things unnecessarily more
difficult from the _user_ and _hardware_ point of view.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
