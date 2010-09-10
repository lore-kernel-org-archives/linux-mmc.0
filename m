From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc_test: fix performance tests that go over max_blk_count
Date: Fri, 10 Sep 2010 21:06:40 +0100
Message-ID: <20100910200640.GA2298@void.printf.net>
References: <4C89ED69.8000301@nokia.com> <20100910152904.GA31914@void.printf.net> <4C8A7FEA.2090407@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33339 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755002Ab0IJUGo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 16:06:44 -0400
Content-Disposition: inline
In-Reply-To: <4C8A7FEA.2090407@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Adrian,

On Fri, Sep 10, 2010 at 09:58:50PM +0300, Adrian Hunter wrote:
> > This patch is corrupt, I think due to missing leading spaces on context
> > lines; it's suspicious that the first hunk doesn't line up properly.
> > Could you check and resend?
> 
> I took a copy from gmane via nntp and applied with git am just fine,
> so I think it was sent OK.  Again below.

Thanks, got it now.  My MUA was corrupting the patches due to the
"format=flowed" in your Content-Type: header, but the bytes themselves
are fine.  Could you remove that?  It's instructed against by the
Documentation/email-clients.txt file.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
