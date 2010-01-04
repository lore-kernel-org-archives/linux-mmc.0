From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: MMC: Atmel choice under Kconfig
Date: Mon, 04 Jan 2010 16:21:02 +0000
Message-ID: <4B42156E.3050103@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:56010 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab0ADQVE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jan 2010 11:21:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Just a nitpicking comment. Currently even if one doesn't actually
have an atmel chip, the menu will include an entry Atmel SD/MMC Driver
due to the following bit of drivers/mmc/host/kconfig

choice
	prompt "Atmel SD/MMC Driver"
	default MMC_ATMELMCI if AVR32
	help
	  Choose which driver to use for the Atmel MCI Silicon

config MMC_AT91
	tristate "AT91 SD/MMC Card Interface support"
	depends on ARCH_AT91
	help
	  This selects the AT91 MCI controller.

	  If unsure, say N.

config MMC_ATMELMCI
	tristate "Atmel Multimedia Card Interface support"
	depends on AVR32 || ARCH_AT91
	help
	  This selects the Atmel Multimedia Card Interface driver. If
	  you have an AT32 (AVR32) or AT91 platform with a Multimedia
	  Card slot, say Y or M here.

	  If unsure, say N.

endchoice

Does anyone object to making adding a dependency on AVR32 || ARCH_AT91
to the 'choice' entry so as to clean up what everyone else sees?

Sorry for the noise if there is already a patch for this queued up
somewhere.

Thanks,

Jonathan Cameron
