From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/17] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 11:04:10 +0000
Message-ID: <20151221110409.GY8644@n2100.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
 <CAPDyKFpuOymN=SVYQ4-FGP+0MbE5F9RrV5usaJQJn2yh+JGzgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39580 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbbLULET (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:04:19 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpuOymN=SVYQ4-FGP+0MbE5F9RrV5usaJQJn2yh+JGzgw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On Mon, Dec 21, 2015 at 11:46:32AM +0100, Ulf Hansson wrote:
> Related to patch1, I noticed that the callers of
> mmc_of_parse_voltage() don't check the return value. Adopting my
> suggested change to patch1, would enable them to be able to check the
> return code.

I disagree with that, because you make the "no voltage-ranges specified"
case appear to be successful.  What if a driver wants it to be mandatory?
You force them down the complicated path of checking the resulting OCR
which is horrid.

It would be better to return some other error code if it's missing, or
maybe return zero for "no voltage-ranges specified" and one for a
successfully parsed "voltage-range" specifier.  This would allow these
cases to be identified by users of this API.

I've gone with that, new patch series will follow when I get a moment
to prepare it, thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
