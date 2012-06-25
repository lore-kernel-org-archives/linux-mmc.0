From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 00:18:50 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206250017090.21883@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <1340372890-10091-3-git-send-email-rnayak@ti.com> <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com> <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
 <4FE7F636.7040803@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51323 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2FYGSv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jun 2012 02:18:51 -0400
In-Reply-To: <4FE7F636.7040803@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org

On Mon, 25 Jun 2012, Rajendra Nayak wrote:

> On Saturday 23 June 2012 12:04 AM, Paul Walmsley wrote:
> > On Fri, 22 Jun 2012, S, Venkatraman wrote:
> > 
> > > On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
> > > > In preparation of OMAP moving to Common Clk Framework(CCF) add
> > > > clk_prepare()
> > > > and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
> > > > probe() and remove() routines.
> > > > 
> > > > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > > > Cc: Chris Ball<cjb@laptop.org>
> > > > Cc: Balaji T K<balajitk@ti.com>
> > > > Cc:<linux-mmc@vger.kernel.org>
> > > 
> > > Rajendra,
> > >    Can this be applied independently, or does this patch have a
> > > dependency on other patches in the series ?
> > 
> > A better way to handle this one would be to convert the driver to runtime
> > PM.  That needs to be done anyway.
> 
> Well, mmc driver is already using runtime PM. But it still using clock
> apis' to deal with some optional debounce clock needed only on 2430.

drivers/mmc/host/omap.c, which is what this patch changes, has not yet 
been converted to use runtime PM in mainline.

This is a driver for the MSDI IP block which is not available on 2430.

- Paul
