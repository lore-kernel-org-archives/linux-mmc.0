From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc/sdio: remember new card RCA when redetecting card
Date: Wed, 02 Mar 2011 21:56:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1103022142150.18193@xanadu.home>
References: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
 <m3lj0xsct2.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:17342 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173Ab1CCC40 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2011 21:56:26 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LHG009XJO5LNHB0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 02 Mar 2011 21:56:09 -0500 (EST)
In-reply-to: <m3lj0xsct2.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

On Wed, 2 Mar 2011, Chris Ball wrote:

> Hi,
> 
> On Tue, Mar 01 2011, Linus Walleij wrote:
> > From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
> >
> > During redetection of a SDIO card, a request for a new card RCA
> > was submitted to the card, but was then overwritten by the old RCA.
> > This caused the card to be deselected instead of selected when using
> > the incorrect RCA.
> 
> Nico, would you mind taking a look at this, please?  Assigning to a
> member of oldcard because we know it's later going to be copied into
> card seems a little ugly to me (at least without a comment explaining
> that); I'm wondering if you'd suggest something else here.

No, I have nothing better to suggest at the moment.

> And, just to check we're all on the same page, this would be a
> regression introduced back at 2.6.32 when the "oldcard" handling
> was first merged, so it should be sent up with a stable tag.

Depends how you define a regression.  If the "oldcard" handling always 
screwed up the rca, then it simply never was right, hence it is hard to 
claim it worked better before. Probably this just worked so far by luck, 
or those cards tested with this code don't change their rca.

> (I'm not yet sure whether I want to send this to mainline during the
> last week of a release and without any previous testing, given that
> the bug is more than a year old already.  Let's see what Nico says.)

I'd queue this for the next merge window only, and not risk introducing 
a real regression in v2.6.38 at the last moment by making things worse 
somehow.


Nicolas
