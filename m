From: Matt Fleming <matt@console-pimps.org>
Subject: Re: mmc_spi and flash cards
Date: Sat, 02 Jan 2010 14:17:51 +0000
Message-ID: <m3d41slhf4.fsf@phlog.console-pimps.org>
References: <f96d234e0911180757l22af9e5dq4fa27db7f260c104@mail.gmail.com>
	<f96d234e0912280958u559c41e6yd47eea5526b6cbda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:47577 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab0ABOR7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jan 2010 09:17:59 -0500
In-Reply-To: <f96d234e0912280958u559c41e6yd47eea5526b6cbda@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 28 Dec 2009 12:58:28 -0500, Cliff Brake <cliff.brake@gmail.com> wrote:
> 
> >> STOP_TRANSMISSION
> >> bit 3 -> R1_SPI_COM_CRC (the CRC of the last command failed)
> 
> mmc0: req done (CMD18): 0: 00000000 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): -84: 00000008 00000000 00000000 00000000
> 

That's weird.

> mmc_spi spi1.0:   mmc_spi: CMD12, resp R1B
> mmc_spi spi1.0:   ... CMD12 response SPI_R1B: resp 0040 00000000
> 
> >> bit 6, R1_SPI_PARAMETER (commands argument, block length) was out of allowed range for this card.
> 

And that just seems completely bogus; the STOP_TRANSMISSION command
doesn't require any parameters.

Having read mmc_spi_response_get() I'm wondering if it's actually trying
to interpret a busy signal as a response code. Would you mind giving
this patch a go and seeing if the BUG_ON() triggers?

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index d55fe4f..3e36ff4 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -310,6 +310,7 @@ static int mmc_spi_response_get(struct mmc_spi_host *host,
 
 checkstatus:
 	bitshift = 0;
+	BUG_ON(*cp == 0xff);
 	if (*cp & 0x80)	{
 		/* Houston, we have an ugly card with a bit-shifted response */
 		rotator = *cp++ << 8;

