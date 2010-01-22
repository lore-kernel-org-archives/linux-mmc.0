From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 5/10] omap: Add functions for dynamic remuxing of
 pins
Date: Fri, 22 Jan 2010 09:17:16 -0800
Message-ID: <20100122171716.GR23467@atomide.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com>
 <20100117013328.17308.2865.sendpatchset@ahunter-work.research.nokia.com>
 <20100120012120.GJ10318@atomide.com>
 <4B56B92D.6000009@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65296 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab0AVRRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2010 12:17:09 -0500
Content-Disposition: inline
In-Reply-To: <4B56B92D.6000009@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

* Adrian Hunter <adrian.hunter@nokia.com> [100120 00:04]:
> Tony Lindgren wrote:
> >* Adrian Hunter <adrian.hunter@nokia.com> [100116 17:31]:
> >>From 33beb5bc36cba739971dc8919a6929925ad3dafc Mon Sep 17 00:00:00 2001
> >>From: Tony Lindgren <tony@atomide.com>
> >>Date: Wed, 13 Jan 2010 10:27:17 -0800
> >>Subject: [PATCH] omap: Add functions for dynamic remuxing of pins
> >>
> >>Make the omap_mux_read and write available for board code,
> >>and rename omap_mux_set_board_signals into omap_mux_write_array.
> >>
> >>In some cases we want to change the signals dynamically,
> >>mostly for power management.
> >>
> >>Note that we cannot use the signal names as they are set
> >>__init to save memory.
> >
> >I'll try to merge this as a fix since it fixes dynamic remuxing.
> >
> >Adrian, can I add your Acked-by?
> 
> Sure.
> 
> Acked-by: Adrian Hunter <adrian.hunter@nokia.com>

Already got the omap-fixes-for-linus queued up, so I'd rather
not start messing again. So a bit too late for your ack, but
thanks anyways for testing.

Tony
