From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Fri, 11 Mar 2011 11:23:20 +0100
Message-ID: <201103111123.21063.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <201103102254.02041.arnd@arndb.de> <AANLkTim1RUmDj_KooR3jXuZ2uTS6ajFyG9eGK7dQiijM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51111 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab1CKKXg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 05:23:36 -0500
In-Reply-To: <AANLkTim1RUmDj_KooR3jXuZ2uTS6ajFyG9eGK7dQiijM@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Friday 11 March 2011, Andrei Warkentin wrote:
> > I also don't know what the effect of setting physical_block_size
> > and/or io_min is, possibly it no longer works if they are larger
> > than the MMU page size. Need to try this.
> 
> The other thing is figuring out the default size limit for when the
> page align should be performed. I suppose it's safe enough to
> set it to 1.5 size the super_page_size. But that number came from the
> Toshiba card tests. Or it could be unbounded by default. I'd rather do
> the later.

You mean always splitting (multiples of) full super-pages from partial
super-pages when the quirk flag is enabled?

I think it depends on the performance numbers. Do you have any
meaningful measurements without the quirk, with the current implementation
and with the unbounded case?

If the latter two are not much different on the toshiba card, that
would be a simpler implementation, and more likely to be useful on
other cards.

I think we should also do measurements to see if the same quirk
actually has any negative effects on other cards, or if there
are even cases where it helps.

	Arnd
