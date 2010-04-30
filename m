From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: mmc: sdhci.h compile error
Date: Fri, 30 Apr 2010 09:30:02 +0400
Message-ID: <20100430053002.GA11716@oksana.dev.rtsoft.ru>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
 <87zl0rb20u.fsf@linux-g6p1.site>
 <20100426101704.GB2092@oksana.dev.rtsoft.ru>
 <20100429152856.30585944.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44205 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757088Ab0D3Q57 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 12:57:59 -0400
Received: by wye20 with SMTP id 20so335558wye.19
        for <linux-mmc@vger.kernel.org>; Fri, 30 Apr 2010 09:57:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100429152856.30585944.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Fleming <matt@console-pimps.org>, zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org

On Thu, Apr 29, 2010 at 03:28:56PM -0700, Andrew Morton wrote:
> On Mon, 26 Apr 2010 14:17:04 +0400
> Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> 
> > On Sun, Apr 25, 2010 at 11:28:17PM +0100, Matt Fleming wrote:
> > > On Wed, 21 Apr 2010 19:43:32 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> > > > 
> > > > There is compile error when we enable CONFIG_MMC_SDHCI_IO_ACCESSORS,
> > > > and include header file #include "sdhci.h"
> > > > error: macro "writel" passed 3 arguments, but takes just 2
> > > > 
> > > 
> > > Interesting...
> > > 
> > > It was Anton Vorontsov that added this code; presumably the code has
> > > never been compiled for an ARM board (or any other architecture that
> > > #define's their I/O accessors in asm/io.h).
> > 
> > Yep, there wasn't any need for these accessors on other platforms.
> > 
> > > It would be better if all architectures declared their I/O accessors as
> > > static inline, but I'm not volunteering to touch all those headers ;-)
> > > Renaming the SDHCI ops is definitely the easiest option. Anton, do you
> > > have a problem with the attached patch to rename the SDHCI accessor
> > > functions?
> > 
> > Looks OK.
> > 
> > Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > (for -next, I presume)
> 
> Why not for 2.6.34?

Because in 2.6.34 there are only PowerPC-specific drivers select
SDHCI_IO_ACCESORS, and for PowerPC there is no problem with
{write,read}{l,w,b} names.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
