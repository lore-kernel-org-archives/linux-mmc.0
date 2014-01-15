From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
Date: Wed, 15 Jan 2014 11:09:04 +0100
Message-ID: <20140115100904.GX31570@twins.programming.kicks-ass.net>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
 <CAA+hA=TRQP7hS3+iXyHg3FuNQKA=chJi7Ne47Ew_4RJcQ6yong@mail.gmail.com>
 <20140113120435.GQ31570@twins.programming.kicks-ass.net>
 <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:60554 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaAOKJZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 05:09:25 -0500
Content-Disposition: inline
In-Reply-To: <CAA+hA=Sb+Ve2xyto9v6YirqcXnePK2aHzJgjGZOhEQJK5Z0jqQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jan 15, 2014 at 03:19:27PM +0800, Dong Aisheng wrote:
> On Mon, Jan 13, 2014 at 8:04 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Dec 26, 2013 at 03:58:20PM +0800, Dong Aisheng wrote:
> >> > It's strange that this issue did not happen on kernel 3.10.17 with the same
> >> > code. And looking at the code, before call spin_lock we already disable the mmc
> >> > controller irq, per on my understanding, the deadlock given by lockdep may not
> >> > be able to happen(pls fix me if wrong).
> >> > May the lockdep not track the specific irq disable?
> >> > Copy lockdep guy to comment.
> >
> > No, lockdep also doesn't know only that one line can take this lock.
> > Lockdep only knows a lock is taken from IRQ context, and disabling one
> > line still allows IRQs to happen and therefore it yells.
> 
> Okay, thanks for the information.
> If that, kernel 3.10.17 has the same code, do you know why it does not trigger
> such lockdep error?

No idea; there haven't really been big lockdep changes recently.
