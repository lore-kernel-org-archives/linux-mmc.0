From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 00/12] use nonblock mmc requests to minimize latency
Date: Fri, 1 Jul 2011 18:44:43 +0200
Message-ID: <201107011844.44058.arnd@arndb.de>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org> <201106301512.46788.arnd@arndb.de> <20110630133003.GZ21898@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62530 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab1GAQoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 12:44:54 -0400
In-Reply-To: <20110630133003.GZ21898@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>, Nickolay Nickolaev <nicknickolaev@gmail.com>

On Thursday 30 June 2011, Russell King - ARM Linux wrote:
> We've been here before - with PCMCIA's card insertion code, where you
> have to go through a sequence of events (insert, power up, reset, etc).
> The PCMCIA code used to have a collection of small functions to do
> each step, one chained after the other in a state machine fashion.
> The result was horrid.  That's exactly what you'll end up with here.
> 
> Threads have their place, and this is one of them.

Ok, fair enough. The performance enhancement is certainly here already
with getting the cache management operations out of the hot path,
and for the fully asynchronous case it's not getting better by trying
to be smarter.

At least for ARM, the overhead of the DMA mapping operations will
dwarf the overhead of the extra context switches for the foreseeable
future, so we don't need to bother.

Things might be different for coherent low-end CPU cores like Atom
when mmc device become much faster and block access becomes CPU
bound.

	Arnd
