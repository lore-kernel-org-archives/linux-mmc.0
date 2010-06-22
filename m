From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] MMC: fix all hangs related to mmc/sd card
 insert/removal during suspend/resume.
Date: Tue, 22 Jun 2010 15:20:06 -0700
Message-ID: <20100622152006.d0ec0cef.akpm@linux-foundation.org>
References: <1276809695.28201.13.camel@maxim-laptop>
	<201006221119.06210.rjw@sisk.pl>
	<1277241450.10907.4.camel@maxim-laptop>
	<201006222353.21349.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47700 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab0FVWUX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 18:20:23 -0400
In-Reply-To: <201006222353.21349.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Philip Langdale <philipl@overt.org>

On Tue, 22 Jun 2010 23:53:21 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday, June 22, 2010, Maxim Levitsky wrote:
> > On Tue, 2010-06-22 at 11:19 +0200, Rafael J. Wysocki wrote: 
> > > On Tuesday, June 22, 2010, Maxim Levitsky wrote:
> > > > On Mon, 2010-06-21 at 22:26 +0200, Rafael J. Wysocki wrote: 
> ...
> > > > I *do* use freezable  work-queue.
> > > 
> > > I overlooked that, sorry.
> > > 
> > > > However since this is pm notifier, it is called before userspace and the
> > > > workqueue is frozen.
> > > > Therefore I would like manually to freeze the workqueue from the pm
> > > > notifier.
> > > 
> > > No, that won't work.  You need to find an alternative solution.  I guess you
> > > may insert a work item that's going to sleep until a condition is
> > > satisfied (analogous to a workqueue barrier) and wait for it to 
> > This screams to be done in generic way.
> > Something like suspend_workqueue() and resume_workqueue();
> 
> Well, there was no need for that until now. :-)
> 
> > In addition to that I just found that .suspend function sometimes can
> > return -ENOSYS, which triggers card removal. I wrongly remove that chunk
> > of code.
> > 
> > To make the thing picture perfect I would have to invest more time to
> > it, I will do so as soon as I finish my exams.
> > 
> > Meanwhile the current patch already fixes all but corner cases or rather
> > nasty hang on suspend with any MMC/SD card inserted.
> 
> OK
> 
> I think Andrew has already taken [2/2].

I took them both, but I need to come back to this discussion to work
out what to do with them now.

> Andrew, who's maintaining MMC now?

Pierre stopped doing it, so I'm now pretending to.

I actually pretend to maintain a huge number of subsystems and should
sprinkle akpms all over MAINTAINERS so stuff doesn't get lost.

