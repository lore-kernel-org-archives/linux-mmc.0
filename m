From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Date: Fri, 11 Jan 2013 11:11:28 +0000
Message-ID: <20130111111128.GE30875@n2100.arm.linux.org.uk>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch> <20130111110210.GC30875@n2100.arm.linux.org.uk> <20130111120909.2cee1b8e@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44636 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab3AKLLh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jan 2013 06:11:37 -0500
Content-Disposition: inline
In-Reply-To: <20130111120909.2cee1b8e@skate>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Jan 11, 2013 at 12:09:09PM +0100, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Fri, 11 Jan 2013 11:02:10 +0000, Russell King - ARM Linux wrote:
> 
> > What remains?  The assumption that GPIO0 means "no GPIO" rather than
> > testing with gpio_valid() and the IRQ stuff.
> 
> Patches that I have written have been merged by Jason Cooper and while
> adding the DT binding for this driver, it also converts it to use the
> MMC GPIO helpers from drivers/mmc/core/slot-gpio.c, which makes this
> whole GPIO initialization/cleanup a lot simpler.

Please also fix the whole raft of other crap in this driver too, as
I've highlighted previously and in these patches.
