From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] MMC Agressive clocking framework v7
Date: Wed, 03 Nov 2010 08:25:07 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011030820410.18581@xanadu.home>
References: <1288541169-16054-1-git-send-email-linus.walleij@stericsson.com>
 <AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:11726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257Ab0KCMZJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Nov 2010 08:25:09 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBB00DJV6HM8680@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 03 Nov 2010 08:24:59 -0400 (EDT)
In-reply-to: <AANLkTims3RhKmPxxxL_T32DN96kSrEE415FE1320fbNO@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, jh80.chung@samsung.com, Kyungmin Park <kmpark@infradead.org>, arm-kernel@lists.infradead.org

On Wed, 3 Nov 2010, Ohad Ben-Cohen wrote:

> On Sun, Oct 31, 2010 at 6:06 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> > This patch modifies the MMC core code to optionally call the
> > set_ios() operation on the driver with the clock frequency set
> > to 0 (gate) after a grace period of at least 8 MCLK cycles, then
> > restore it (ungate) before any new request. This gives
> > the driver the option to shut down the MCI clock to the MMC/SD
> 
> Have you considered migrating this to runtime PM API ?
> 
> Runtime PM core already provides most of the necessary plumbing:
> referred work, reference counting, tunable delay, active/suspended
> status, etc..
> 
> It will also allow you to avoid overloading the set_ios() operation:
> once suspended, host controllers will receive an idle notification
> from runtime PM core. also CONFIG_MMC_CLKGATE will probably not be
> needed anymore (no API changes so everything should just work as
> before. only difference is that now hosts can start supporting  these
> runtime PM notifications).

While runtime PM might be appropriate, I think that passing a clock rate 
of 0 to set_ios() is a clear and fully defined state worth supporting.  
Nothing prevents the later from being used by the former then.


Nicolas
