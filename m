From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: MMC maintainer
Date: Thu, 9 Sep 2010 11:47:50 -0700
Message-ID: <20100909114750.09214854.akpm@linux-foundation.org>
References: <m3lj7avpk4.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40593 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752247Ab0IISme (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 14:42:34 -0400
In-Reply-To: <m3lj7avpk4.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Thu, 09 Sep 2010 12:39:55 -0400 Chris Ball <cjb@laptop.org> wrote:

> Hi all,
> 
> I've been considering volunteering to take over as MMC maintainer.
> I mentioned this to my boss at OLPC, and he's willing to have some
> of my OLPC hours each week allocated towards maintaining MMC, which
> encourages me more.
> 
> So, here's my humble offer: I can take care of maintaining an MMC tree
> for -next, keeping it working and tested, sending pull requests, and
> making sure that patches are kept track of and reach the appropriate
> places for review.  I wouldn't plan on changing patch workflow --
> patches would still be submitted and responded to on the list.
> 
> I'm also interested in setting up automated testing to catch
> performance and functionality regressions similarly to the Xorg
> Tinderbox__, which I run.  Aside from that, I'd be open to hearing
> about what anyone else thinks is a priority to work on in the MMC
> stack.
> 
> Let me know what you think,

Sounds good to me, thanks.

> and if this sounds like a reasonable
> idea then I'll work out a transition plan with Andrew.

These things can happen in parallel - get the tree set up, get it into
linux-next, start putting patches in it.  If I see patches turn up in
linux-next which I already have, I just drop them.  If I find I'm
holding patches which should be in the mmc tree but which aren't, I
send them to you.

