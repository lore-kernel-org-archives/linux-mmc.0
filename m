From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Sat, 15 Feb 2014 14:09:39 +0100
Message-ID: <1580658.FIe4en5bEU@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <3871646.18hjUjnpmg@wuerfel> <20140215122733.GK30257@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:50804 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbaBONJy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 08:09:54 -0500
In-Reply-To: <20140215122733.GK30257@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Saturday 15 February 2014 12:27:33 Russell King - ARM Linux wrote:
> On Sat, Feb 15, 2014 at 01:18:02PM +0100, Arnd Bergmann wrote:
> > If a wlan adapter has both SPI and SDIO front-ends, the external
> > dependencies (reset, clock, voltage, ...) will be the same, and
> > from the kernel perspective the main difference is that SPI cannot
> > be probed at all, while SDIO can be probed as long as the device
> > is powered on already.
> 
> Remember that MMC/SD/SDIO cards can be driven by either a MMC host
> interface, or a SPI interface.  Both are probe-able.

I knew about MMC/SD cards being required to understand simple SPI,
I wasn't sure about SDIO. My understanding however is that you
have to use the mmc_spi host driver to actually use MMC/SD devices
as a block device, and that requires having either a DT description
for the host or an spi_board_info, which I would not consider
discoverable.

For spi-mode SDIO devices I'm assuming it's similar, except that
you'd describe the actual SDIO device in the board info rather than
create a fake SDIO controller. Still not discoverable unless I'm
missing your point.

	Arnd
