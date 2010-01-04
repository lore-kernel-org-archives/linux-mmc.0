From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: MMC: Atmel choice under Kconfig
Date: Mon, 04 Jan 2010 17:25:41 +0100
Message-ID: <4B421685.8010306@atmel.com>
References: <4B42156E.3050103@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:50151 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753560Ab0ADQez (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Jan 2010 11:34:55 -0500
In-Reply-To: <4B42156E.3050103@cam.ac.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-mmc@vger.kernel.org

Le 04/01/2010 17:21, Jonathan Cameron :
> Just a nitpicking comment. Currently even if one doesn't actually
> have an atmel chip, the menu will include an entry Atmel SD/MMC Driver
> due to the following bit of drivers/mmc/host/kconfig
> 
> choice
> 	prompt "Atmel SD/MMC Driver"
> 	default MMC_ATMELMCI if AVR32
> 	help
> 	  Choose which driver to use for the Atmel MCI Silicon
> 
> config MMC_AT91
> 	tristate "AT91 SD/MMC Card Interface support"
> 	depends on ARCH_AT91
> 	help
> 	  This selects the AT91 MCI controller.
> 
> 	  If unsure, say N.
> 
> config MMC_ATMELMCI
> 	tristate "Atmel Multimedia Card Interface support"
> 	depends on AVR32 || ARCH_AT91
> 	help
> 	  This selects the Atmel Multimedia Card Interface driver. If
> 	  you have an AT32 (AVR32) or AT91 platform with a Multimedia
> 	  Card slot, say Y or M here.
> 
> 	  If unsure, say N.
> 
> endchoice
> 
> Does anyone object to making adding a dependency on AVR32 || ARCH_AT91
> to the 'choice' entry so as to clean up what everyone else sees?

Yes, sure go-on.

> Sorry for the noise if there is already a patch for this queued up
> somewhere.

No patch queued for this if I recall well...


Thanks, best regards,
-- 
Nicolas Ferre
