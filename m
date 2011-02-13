From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci: Replace SDHCI_QUIRK_NO_MULTIBLOCK with
 a platform hook.
Date: Sun, 13 Feb 2011 22:13:12 +0100
Message-ID: <20110213211312.GA27028@pengutronix.de>
References: <m3zkq9n115.fsf@pullcord.laptop.org>
 <20110207174839.GF3123@pengutronix.de>
 <20110212202212.GA11375@void.printf.net>
 <20110212204350.GA23657@pengutronix.de>
 <20110212210541.GA11634@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36427 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744Ab1BMVNP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 16:13:15 -0500
Content-Disposition: inline
In-Reply-To: <20110212210541.GA11634@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Olof Johansson <olof@lixom.net>, Philip Rakity <prakity@marvell.com>

On Sat, Feb 12, 2011 at 09:05:41PM +0000, Chris Ball wrote:

> > > If there still isn't a better alternative in mind, I'm thinking about
> > > going ahead and taking this patch, and then reusing the quirk bit for
> > > Chuanxiao's "mmc: set a suitable max_discard_sectors value for HC"
> > > patchset.
> > 
> > What about using the SZ_2048 quirk instead which could be done via
> > io-accessors?
> 
> That sounds fine too; I thought this one was more straightforward.
> 
> > That being said, I have a train travel tomorrow and will try to
> > see if a fixup() function would make sense for this one. Can you
> > wait one more day?
> 
> Sure, no immediate hurry.  Thanks!

So, I had a look today: Hmm....

I wanted something like a fixup-function called at the end of sdhci_add_host
which could handle all quirks doing some "mmc->..." changes. (I know that Olof
doesn't like this because it breaks abstraction. There might be a middle-way,
though.)

What bugs me with that approach is that it won't help against all quirks, so we
would need to replace all other quirks with functions, too. I'd think a
combination of QUIRKS and a fixup-function will be too confusing (we have that
to some degree already). Changing all at once is a major task though if you
want to group them properly and not do a 1:1 mapping.

I'd like to hear other people's opinion at this point. For now, my suggestion
would be to remove those quirks which could be handled via io-accessors. That
could be done on a step by step basis and should not create confusion if all
registers flaws are handled via io-accessors. But that's just my brainstorming,
so looking forward to comments.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
