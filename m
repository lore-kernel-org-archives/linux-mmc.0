From: Tero Kristo <t-kristo@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Mon, 22 Oct 2012 19:13:55 +0300
Message-ID: <1350922435.2143.66.camel@sokoban>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
	 <alpine.DEB.2.00.1210201628420.24497@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57342 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563Ab2JVQOG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Oct 2012 12:14:06 -0400
In-Reply-To: <alpine.DEB.2.00.1210201628420.24497@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Venkatraman S <svenkatr@ti.com>, khilman@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Sat, 2012-10-20 at 17:20 +0000, Paul Walmsley wrote:
> Hello Venkatraman,
> 
> On Thu, 18 Oct 2012, Paul Walmsley wrote:
> 
> > Here are some basic OMAP test results for Linux v3.7-rc1.
> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
> 
> ...
> 
> > Failing tests: needing investigation
> > ------------------------------------
> 
> ...
> 
> > PM tests:
> > 
> > * 3530es3beagle: hangs during off-mode dynamic idle test
> >   - Unknown cause; not investigated
> 
> Looks like this commit is causing some of our power management tests to 
> fail on v3.7-rc1:
> 
> commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c
> Author: Venkatraman S <svenkatr@ti.com>
> Date:   Wed Aug 8 14:26:52 2012 +0530
> 
>     mmc: omap_hsmmc: remove access to SYSCONFIG register
> 
> ...
> 
> The failure can be seen in the following test log:
> 
> http://www.pwsan.com/omap/transcripts/20121020-3530es3beagle-off-mode-fail-pre-revert.txt
> 
> and with commit 6c31b215 reverted, the test succeeds:
> 
> http://www.pwsan.com/omap/transcripts/20121020-3530es3beagle-off-mode-fail-post-revert.txt
> 
> 
> Could you please take a look and fix the problem?

Root cause for this issue is that the MMC IP is reset during off-mode,
but the driver doesn't expect this in its current form. There are a
couple of alternative ways to fix this. Either add a reset timeout to
the MMC driver code (which was removed by the bisected patch), or
alternatively add a global reset check to the hwmod code. I'll send a
patch for the global reset purpose in a bit for commenting.

-Tero


