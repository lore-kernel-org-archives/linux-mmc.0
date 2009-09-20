From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + sdio-recognize-io-card-without-powercycle.patch added to -mm
 tree
Date: Sat, 19 Sep 2009 20:16:23 -0700
Message-ID: <20090919201623.df300c63.akpm@linux-foundation.org>
References: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
	<20090920030311.GA21188@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44743 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422AbZITDQ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Sep 2009 23:16:26 -0400
In-Reply-To: <20090920030311.GA21188@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: albert_herranz@yahoo.es, linux-mmc@vger.kernel.org

On Sun, 20 Sep 2009 04:03:13 +0100 Chris Ball <cjb@laptop.org> wrote:

> Hi Andrew,
> 
> On Sun, Sep 13, 2009 at 03:45:04PM -0700, akpm@linux-foundation.org wrote:
> > +++ a/drivers/mmc/core/core.c
> > @@ -1073,6 +1073,7 @@ void mmc_rescan(struct work_struct *work
> >  	mmc_claim_host(host);
> >  
> >  	mmc_power_up(host);
> > +		sdio_reset(host);
> >  	mmc_go_idle(host);
> 
> Looks like this hunk gained an extra tab on the way into -mm.
> 

yup, thanks, fixed.  A leftover from reject-fixing, I assume.
