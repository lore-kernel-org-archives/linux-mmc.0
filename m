From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC breakage
Date: Tue, 17 Aug 2010 09:31:28 -0700
Message-ID: <20100817093128.c4358ea8.akpm@linux-foundation.org>
References: <20100817135455.GB6681@flint.arm.linux.org.uk>
	<20100817152132.GA8071@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49635 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713Ab0HQQcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 12:32:07 -0400
In-Reply-To: <20100817152132.GA8071@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Russell King <rmk@arm.linux.org.uk>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org

On Tue, 17 Aug 2010 16:21:32 +0100 Chris Ball <cjb@laptop.org> wrote:

> Hi Russell,
> 
> On Tue, Aug 17, 2010 at 02:54:56PM +0100, Russell King wrote:
> > I get the following build error:
> > 
> > 	drivers/built-in.o: In function `mmc_alloc_host':
> > 	mmci.c:(.text+0x80c44): undefined reference to `mmc_pm_notify'
> > 
> > Seems to be down to 4c2ef25fe.  The commit claims to fix the CONFIG_PM=n
> > build, but it seems not to as mmc_pm_notify() is within an #ifdef CONFIG_PM
> > block but the initialization isn't.
> 
> Patches have been sent to akpm to fix this already; see
>   http://lkml.org/lkml/2010/8/12/207
>   http://article.gmane.org/gmane.linux.kernel/1022716
> 

yup.  I'm lying on a beach at present.  I expect I'll get onto these
later in the week.

