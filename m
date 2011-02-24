From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Thu, 24 Feb 2011 10:24:01 +0100
Message-ID: <201102241024.01437.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102231709.05036.arnd@arndb.de> <AANLkTimZDDo0xa2CzgHhH1LSWJ-KT0QgOmEAKs2nJK8x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54269 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab1BXJYI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 04:24:08 -0500
In-Reply-To: <AANLkTimZDDo0xa2CzgHhH1LSWJ-KT0QgOmEAKs2nJK8x@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wednesday 23 February 2011, Andrei Warkentin wrote:

> I am more concerned with workarounds that depend on access size (like
> the toshiba one) and that modify the MMC commands sent (using reliable
> writes, like the Toshiba one, or putting parameters differently like
> the Sandisk erase workaround). It's these kinds of workarounds that
> the quirks framework is meant to address. I don't think it's a good
> idea to pollute mmc_blk_issue_rw_rq and mmc_blk_issue_discard_rq with
> if()-elsed workarounds, because it's going to quickly complicate the
> logic, and get out of hand and unmanageable the more cards are added.
> I'm trying to avoid having to make any changes to card/block.c as part
> of making quirk workarounds. The only cost when compared to an if-else
> will be one O(log n) quirk lookup, where n is either one or something
> close that (since the search is only done for quirks per
> mmc_blk_data), and one callback invoked after "brq.data.sg_len =
> mmc_queue_map_sg(mq);" so it can patch up mrq as necessary.

Unlike the sysfs interface, the code does not need to be future-proof,
it can always be changed if we feel the code becomes more maintainable
by doing it another way.

The approach that I'd like to see here is:

* Start out with an ad-hoc patch for a quirk (like the one you already
  have).
* Add a boolean variable to enable it per card.
* Get performance data for this quirk to show that it's useful in
  real-world workloads for some cards but counterproductive for others
* Get the patch into the mmc tree.
* Repeat for the next quirk
* When the code becomes overly complicated after adding all the quirks,
  decide on a good strategy to move the code around, and do a new patch.

I understand that you are convinced that you will need the indirect function
calls in the end. That is fine, just don't add them before they are
actually needed -- that would only make it harder for you to get the first
patch included.

Note that the situation is very different for user interfaces such as sysfs:
You need to plan ahead because once the interface is merged upstream, it
can never be changed. When you submit a patch that introduces a new sysfs
interface, it has to be documented, and you have to convince the reviewers
that it is sufficient to cover all the cases it is designed for, while
at the same time it is the most simple way to achieve this.

	Arnd
