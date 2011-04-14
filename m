From: Chris Ball <cjb@laptop.org>
Subject: Re: SET_BLOCK_COUNT-bounded multiblock transfers
Date: Thu, 14 Apr 2011 19:18:54 -0400
Message-ID: <m3k4ewto9t.fsf@pullcord.laptop.org>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com>
	<BANLkTikFWhDhCjGKBBE4PP9sNa2ynVEOtg@mail.gmail.com>
	<CE761E84DADF2947A4AF22FB8D97A473571F5610@shsmsx501.ccr.corp.intel.com>
	<BANLkTikDaPq56UBkNtmKApBXZ6dgMKgo6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41762 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472Ab1DNXOX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Apr 2011 19:14:23 -0400
In-Reply-To: <BANLkTikDaPq56UBkNtmKApBXZ6dgMKgo6Q@mail.gmail.com> (Andrei
	Warkentin's message of "Thu, 14 Apr 2011 17:58:45 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "Gao, Yunpeng" <yunpeng.gao@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>

Hi,

On Thu, Apr 14 2011, Andrei Warkentin wrote:
> The question to Arnd and Chris - should by default use of CMD23 for
> multiblock writes be disabled, and enabled per known-good card using
> add_flag quirk support? Or should CMD23 for multiblock writes be
> enabled by default, and then disabled for known-bad cards?

I don't have a standard answer for this -- it just depends on the numbers.

If we've seen a card that freaks out and loses significant bandwidth, that
would be a good reason to start with a whitelist.  If all the data we have
suggests that it's performance-wise either a win or a no-op, that's a fine
reason to push it to mmc-next with a blacklist approach and change our
minds later if our knowledge gets updated.  Does that help?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
