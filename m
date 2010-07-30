From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmc: only set blockaddressed for > 2GiB cards
Date: Fri, 30 Jul 2010 16:34:57 -0700
Message-ID: <20100730163457.a54cb0f1.akpm@linux-foundation.org>
References: <1277194762-21399-1-git-send-email-rabin.vincent@stericsson.com>
	<AANLkTin-EGaq9q0ATgRfm=XKTgJ7EYT_Q-Ruzr_OQXsY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58431 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872Ab0G3XfH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jul 2010 19:35:07 -0400
In-Reply-To: <AANLkTin-EGaq9q0ATgRfm=XKTgJ7EYT_Q-Ruzr_OQXsY@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Hanumath Prasad <hanumath.prasad@stericsson.com>, Rabin Vincent <rabin.vincent@stericsson.com>

On Fri, 30 Jul 2010 19:28:44 +0200
Linus Walleij <linus.walleij@stericsson.com> wrote:

> 2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> 
> > From: Hanumath Prasad <hanumath.prasad@stericsson.com>
> >
> > A non-zero value of SEC_COUNT does not indicate that the card is sector
> > addressed. __According to the MMC specification, cards with a density
> > greater than 2GiB are sector addressed.
> 
> What's happening with this beauty? Andrew would you mind
> picking this one up please?

I merged that a month ago, for 2.6.36.

If we think that it should be in 2.6.35 (and earlier?) then please send
along revised changelog text which explains the reason for that.

