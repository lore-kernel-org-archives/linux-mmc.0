From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmci: supply per-instance regulator name
Date: Thu, 2 Dec 2010 13:08:09 +0000
Message-ID: <20101202130809.GD859@rakim.wolfsonmicro.main>
References: <1291289707-5529-1-git-send-email-linus.walleij@stericsson.com>
 <20101202120318.GB3182@sirena.org.uk>
 <20101202122827.GG29347@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40060 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753358Ab0LBNIL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 08:08:11 -0500
Content-Disposition: inline
In-Reply-To: <20101202122827.GG29347@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 02, 2010 at 12:28:27PM +0000, Russell King - ARM Linux wrote:

> The way the MMCI code is, it only requests one regulator per AMBA
> device, and therefore only one regulator per struct device.  So I
> don't think the current code needs changing in any way provided the
> struct device is used to find the corresponding regulator.

Hrm.  In that case I'm not sure what the problem Linus' patch fixes is -
the driver is already requesting using the struct device, I was assuming
that the supplies weren't being requested in a fine grained enough
fashion.
