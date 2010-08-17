From: Chris Ball <cjb@laptop.org>
Subject: Re: MMC breakage
Date: Tue, 17 Aug 2010 16:21:32 +0100
Message-ID: <20100817152132.GA8071@void.printf.net>
References: <20100817135455.GB6681@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34983 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab0HQPVj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Aug 2010 11:21:39 -0400
Content-Disposition: inline
In-Reply-To: <20100817135455.GB6681@flint.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Hi Russell,

On Tue, Aug 17, 2010 at 02:54:56PM +0100, Russell King wrote:
> I get the following build error:
> 
> 	drivers/built-in.o: In function `mmc_alloc_host':
> 	mmci.c:(.text+0x80c44): undefined reference to `mmc_pm_notify'
> 
> Seems to be down to 4c2ef25fe.  The commit claims to fix the CONFIG_PM=n
> build, but it seems not to as mmc_pm_notify() is within an #ifdef CONFIG_PM
> block but the initialization isn't.

Patches have been sent to akpm to fix this already; see
  http://lkml.org/lkml/2010/8/12/207
  http://article.gmane.org/gmane.linux.kernel/1022716

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
