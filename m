From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + sdhci-add-no-hi-speed-bit-quirk-support.patch added to -mm
 tree
Date: Tue, 10 Aug 2010 14:34:34 -0700
Message-ID: <20100810143434.01bea685.akpm@linux-foundation.org>
References: <201006102043.o5AKhJjl022731@imap1.linux-foundation.org>
	<20100611004229.GD3498@trinity.fluff.org>
	<AANLkTik5ANblTvTGh-4f9IL7VW8iPmQtRiN0BIDWjFGc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37753 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755874Ab0HJVfZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 17:35:25 -0400
In-Reply-To: <AANLkTik5ANblTvTGh-4f9IL7VW8iPmQtRiN0BIDWjFGc@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org

On Fri, 11 Jun 2010 12:25:32 +0900
Kyungmin Park <kmpark@infradead.org> wrote:

> On Fri, Jun 11, 2010 at 9:42 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> > On Thu, Jun 10, 2010 at 01:43:19PM -0700, akpm@linux-foundation.org wrote:
> >>
> >> The patch titled
> >> __ __ __SDHCI: add no hi-speed bit quirk support
> >> has been added to the -mm tree. __Its filename is
> >> __ __ __sdhci-add-no-hi-speed-bit-quirk-support.patch
> >>
> >> Before you just go and hit "reply", please:
> >> __ __a) Consider who else should be cc'ed
> >> __ __b) Prefer to cc a suitable mailing list as well
> >> __ __c) Ideally: find the original patch on the mailing list and do a
> >> __ __ __ reply-to-all to that, adding suitable additional cc's
> >>
> >> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> >>
> >> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> >> out what to do about this
> >>
> >> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> >>
> >> ------------------------------------------------------
> >> Subject: SDHCI: add no hi-speed bit quirk support
> >> From: Kyungmin Park <kmpark@infradead.org>
> >>
> >> Some SDHCI controllers like s5pc110 don't have an HISPD bit in the HOSTCTL
> >> register.
> >
> > It would be nice for someone at Samsung to (a) explain the differences
> > from the base SDHCI spec for all their hardware (the databooks are often
> > vague in this area) and (b) for the information for the extra registers
> > this IP block has to be explained in more detail (and the platform code
> > checked for this too).
> 
> I hope also.

Going back over this dicussion, I get the impression that nothing
really got resolved or finished.  So it is far from clear that I should
send these:

s5pc110-sdhci-s3c-can-override-host-capabilities.patch
s5pc110-sdhci-s3c-support-on-s5pc110.patch
sdhci-add-no-hi-speed-bit-quirk-support.patch

upstream.  Could we please revisit all of this ASAP?

Thanks.
