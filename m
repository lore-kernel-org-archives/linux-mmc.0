From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmci: supply per-instance regulator name
Date: Thu, 2 Dec 2010 12:28:27 +0000
Message-ID: <20101202122827.GG29347@n2100.arm.linux.org.uk>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com> <20101202120318.GB3182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49935 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757358Ab0LBM2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 07:28:38 -0500
Content-Disposition: inline
In-Reply-To: <20101202120318.GB3182@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 12:03:18PM +0000, Mark Brown wrote:
> On Thu, Dec 02, 2010 at 12:35:07PM +0100, Linus Walleij wrote:
> > On the Ux500 we have different regulators to different card slots
> > and eMMCs, and some have no regulator. Move the hardcoded "vmmc"
> > regulator name to platform data and supply it that way for the
> 
> You should never be passing regulator names through platform data, this
> appears to be broken.  You should be using the struct device to
> distingish between multiple instances and using whatever the actual
> supply names are for multiple supplies on the same device.
> 
> Looking at this without seeing the datasheet I'd expect these would end
> up as vmmcn for suitable values of n.

The way the MMCI code is, it only requests one regulator per AMBA
device, and therefore only one regulator per struct device.  So I
don't think the current code needs changing in any way provided the
struct device is used to find the corresponding regulator.
