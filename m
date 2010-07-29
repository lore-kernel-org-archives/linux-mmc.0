From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 02/12] mmci: fix multi block transfers
Date: Thu, 29 Jul 2010 14:18:58 +0100
Message-ID: <20100729131858.GB18923@n2100.arm.linux.org.uk>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com> <1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52146 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0G2NTO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 09:19:14 -0400
Content-Disposition: inline
In-Reply-To: <1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, STEricsson_nomadik_linux@list.st.com, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@stericsson.com>

On Tue, Jun 22, 2010 at 02:47:37PM +0530, Rabin Vincent wrote:
> Fix the data transfer size to allow multi block transfers to work.
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>

The first two patches improve performance on Versatile, from 20.5s to
read 1MB down to 18.5s - a 10% improvement.

I was worried that the first patch would add too much overhead, and
cause the hardware to overrun - as the ARM version of these primecells
does not have the capability to stop the clock when the FIFO fills
up, any increase in IRQ latency to read the FIFO will result in an
overrun.

So this is good news.  I've applied the first three patches in this
series, but we do need to sort out the card detect situation properly
before continuing.
