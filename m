From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/17] mmc: sdhci: avoid unnecessary mapping/unmapping of
 align buffer
Date: Mon, 21 Dec 2015 10:53:51 +0000
Message-ID: <20151221105350.GX8644@n2100.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
 <E1aAO9H-0007yC-Dl@rmk-PC.arm.linux.org.uk>
 <CAPDyKFr9_ieo_HbJgq7YaFMGN5G-EXBuK5aLxOepP86yLQ5EWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39550 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbbLUKyB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 05:54:01 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr9_ieo_HbJgq7YaFMGN5G-EXBuK5aLxOepP86yLQ5EWA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Dec 21, 2015 at 11:28:15AM +0100, Ulf Hansson wrote:
> On 19 December 2015 at 21:30, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> > Unnecessarily mapping and unmapping the align buffer for SD cards is
> > expensive: performance measurements on iMX6 show that this gives a hit
> > of 10% on hdparm buffered disk reads.
> >
> > MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
> > for this case, the align buffer is not going to be used.  However, we
> > still map and unmap this buffer.
> 
> What about the SDIO case? How will this change affect SDIO data transfers?

I can't quantify that as I have no SDIO cards to do any measurements.

It depends entirely on the expense of accessing to DMA coherent memory
compared to accessing normal memory and then syncing it.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
