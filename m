From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc/sdio: remember new card RCA when redetecting card
Date: Wed, 02 Mar 2011 22:15:46 -0500
Message-ID: <m3wrkgq4gt.fsf@pullcord.laptop.org>
References: <1298986864-25597-1-git-send-email-linus.walleij@stericsson.com>
	<m3lj0xsct2.fsf@pullcord.laptop.org>
	<alpine.LFD.2.00.1103022142150.18193@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36267 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757245Ab1CCDRd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 2 Mar 2011 22:17:33 -0500
In-Reply-To: <alpine.LFD.2.00.1103022142150.18193@xanadu.home> (Nicolas
	Pitre's message of "Wed, 02 Mar 2011 21:56:24 -0500 (EST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Nico, thanks for the quick reply,

On Wed, Mar 02 2011, Nicolas Pitre wrote:
> No, I have nothing better to suggest at the moment.

Okay.  I'll add a comment explaining what's going on.

>> And, just to check we're all on the same page, this would be a
>> regression introduced back at 2.6.32 when the "oldcard" handling
>> was first merged, so it should be sent up with a stable tag.
>
> Depends how you define a regression.  If the "oldcard" handling always 
> screwed up the rca, then it simply never was right, hence it is hard to 
> claim it worked better before. Probably this just worked so far by luck, 
> or those cards tested with this code don't change their rca.

Yes, it's never been right under the "oldcard" handling which was merged
in 2.6.32.  I agree with your guesses on why it wasn't noticed before.

>> (I'm not yet sure whether I want to send this to mainline during the
>> last week of a release and without any previous testing, given that
>> the bug is more than a year old already.  Let's see what Nico says.)
>
> I'd queue this for the next merge window only, and not risk introducing 
> a real regression in v2.6.38 at the last moment by making things worse 
> somehow.

Thanks, that exactly matches my intuition on what to do.  I'll push it
to mmc-next now and add a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
