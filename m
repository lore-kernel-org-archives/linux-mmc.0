From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] ARM: PrimeCell DMA Interface v5
Date: Thu, 22 Apr 2010 12:00:25 +0100
Message-ID: <20100422110025.GC20008@n2100.arm.linux.org.uk>
References: <1270681920-4461-1-git-send-email-linus.walleij@stericsson.com> <v2se9c3a7c21004071645u8180f4d7p3b4b1f96de11303e@mail.gmail.com> <CEE6BB42CAD6E947908279175AF8470A03A50F78@EXDCVYMBSTM006.EQ1STM.local> <t2qe9c3a7c21004141815x70ecf123p4364802681417da9@mail.gmail.com> <q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36017 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759145Ab0D3T7T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2010 15:59:19 -0400
Content-Disposition: inline
In-Reply-To: <q2o63386a3d1004162158v296379fat2b376d5c4c087378@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Apr 17, 2010 at 06:58:49AM +0200, Linus Walleij wrote:
> 2010/4/15 Dan Williams <dan.j.williams@intel.com>:
> 
> > Getting closer... I have pushed out the dma40 driver (v3), 4, and 6.
> 
> That's great!
> 
> > The other patch in -mm I could take as well but that needs an ack from
> > Russell.
> 
> Nah, I'll push that in through Russells tree hopefully, it needs rebasing on
> the latest board setup code anyway.
> 
> > 5 is pending the review comment and 9 does not apply cleanly (does it
> > depend on something in the spi tree?)
> 
> OK I'm sending updated versions soon, along with a DMA40 bug fix
> all on top of async_tx instead.
> 
> Number 9 fails since it is based on -next where all the #include <slab.h>
> business has taken place, I don't know how that is resolved in the end
> but it now includes that include and applies cleanly on async_tx.
> 
> I'll keep working on getting the PL011 and PL180 DMA tested on the
> RealView somehow so those can also be accepted.

So has this (which has now been applied to Dan's tree) been tested
as I asked on Versatile platforms, or do we have something that could
be incompatible with those platforms?

I'm basically not acking or applying these patches until something
along those lines has happened.  (And unfortunately I don't have the
resources to apply to this at present.)
