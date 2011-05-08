From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
Date: Sun, 8 May 2011 11:22:19 +0100
Message-ID: <20110508102219.GG27807@n2100.arm.linux.org.uk>
References: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551Ab1EHKW3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 06:22:29 -0400
Content-Disposition: inline
In-Reply-To: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>

On Thu, May 05, 2011 at 01:14:23PM +0200, Linus Walleij wrote:
> From: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
> 
> Earlier code was expecting that mmci_pio_write() returns
> not more than 'remain' bytes transferred. It is not the case
> for buffers which are not multiple of 4 bytes length.
> 
> The patch fix the problem by checking result of mmci_pio_write().
> 
> The fault was introduced in the change:
> 	I2e506ec1f5a7fadf9780c18d8d31573eaf048273
> 	MMCI: Fixup sg buffer handling in pio_write

I assume this isn't for mainline as that commit isn't present.
