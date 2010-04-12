From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: How to make kernel block layer generate bigger request in the
 request queue?
Date: Mon, 12 Apr 2010 14:58:29 -0500
Message-ID: <1271102309.4428.85.camel@mulgrave.site>
References: <CE761E84DADF2947A4AF22FB8D97A4731CAF351C@shsmsx501.ccr.corp.intel.com>
	 <4BBFBE3E.5070605@gmail.com> <yq1y6gwt62p.fsf@sermon.lab.mkp.net>
	 <1270911503.2806.194.camel@mulgrave.site>
	 <yq1d3y4msri.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37477 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753355Ab0DLT6g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Apr 2010 15:58:36 -0400
In-Reply-To: <yq1d3y4msri.fsf@sermon.lab.mkp.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, 2010-04-12 at 14:26 -0400, Martin K. Petersen wrote:
> >>>>> "James" == James Bottomley <James.Bottomley@suse.de> writes:
> 
> >> Correct.  It's quite unlikely for pages to be contiguous so this is
> >> the best we can do.
> 
> James> Actually, average servers do about 50% contiguous on average
> James> since we changed the mm layer to allocate in ascending physical
> James> page order ...  this figure is highly sensitive to mm changes
> James> though, and can vary from release to release.
> 
> Interesting.  When did this happen?

The initial work was done by Bill Irwin, years ago.  For a while it was
good, but then after Mel Gorman did the page reclaim code, we became
highly sensitive to the reclaim algorithms for this, so it's fluctuated
a bit ever since.  Even with all this, the efficiency is highly
dependent on the amount of free memory: once the machine starts running
to exhaustion (excluding page cache, since that usually allocates
correctly to begin with) the contiguity really drops.

> Last time I gathered data on segment merge efficiency (1 year+ ago) I
> found that adjacent pages were quite rare for a normal fs type workload.
> Certainly not in the 50% ballpark.  I'll take another look when I have a
> moment...

I got 60% with an I/O bound test with about a gigabyte of free memory a
while ago (2.6.31, I think).  Even for machines approaching memory
starvation, 30% seems achievable.

James


