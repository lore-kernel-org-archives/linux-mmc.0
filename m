From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Sat, 15 Feb 2014 12:27:33 +0000
Message-ID: <20140215122733.GK30257@n2100.arm.linux.org.uk>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <20140213144106.GW26684@n2100.arm.linux.org.uk> <1626419.Ta3A7zgHIt@wuerfel> <3871646.18hjUjnpmg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37385 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752881AbaBOM1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 07:27:46 -0500
Content-Disposition: inline
In-Reply-To: <3871646.18hjUjnpmg@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Sat, Feb 15, 2014 at 01:18:02PM +0100, Arnd Bergmann wrote:
> If a wlan adapter has both SPI and SDIO front-ends, the external
> dependencies (reset, clock, voltage, ...) will be the same, and
> from the kernel perspective the main difference is that SPI cannot
> be probed at all, while SDIO can be probed as long as the device
> is powered on already.

Remember that MMC/SD/SDIO cards can be driven by either a MMC host
interface, or a SPI interface.  Both are probe-able.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
