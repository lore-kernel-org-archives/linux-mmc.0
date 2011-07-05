From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/4] mmci: sync DATAEND irq with dma|pio transfer done
Date: Tue, 5 Jul 2011 12:25:33 +0100
Message-ID: <20110705112533.GY8286@n2100.arm.linux.org.uk>
References: <1309247860-17181-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50603 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165Ab1GELZn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 07:25:43 -0400
Content-Disposition: inline
In-Reply-To: <1309247860-17181-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On Tue, Jun 28, 2011 at 09:57:40AM +0200, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> The end of a dma|pio data transfer is synced with the
> DATAEND irq. This will prevent the mmci driver from ending
> the request before the dma|pio job is completely done.
> 
> For dma we use DMA_PREP_INTERRUPT to register a callback
> function which is called when dma driver is done with job.
> 
> To also make sure we prevent hanging forever, waiting for
> DATAEND irq or a dma|pio transfer to be done, we setup a timer
> when either a DATAEND or dma|pio job is done. Once both
> conditions have occured, the timer is cancelled and the data
> transfer is completed.
> 
> If a timeout occurs, the data transfer is terminated in a
> controlled manner and EAGAIN is returned to the framework.
> A timeout value of 50 ms has been found to work well for
> our usecases.

What is the framework supposed to do with that error code?  Magic the
driver into disabling DMA by some non-existant callback?

Please, stop introducing magic new error codes which have no meaning to
the upper levels unless you're also going to add some handling of those
error conditions as well.
