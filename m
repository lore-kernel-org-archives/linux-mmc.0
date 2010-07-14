From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH 0/8] sdhci: Move real work out of an atomic context
Date: Wed, 14 Jul 2010 17:07:28 +0400
Message-ID: <20100714130728.GA27339@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:18705 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755625Ab0GNNHc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 09:07:32 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Albert Herranz <albert_herranz@yahoo.es>, Matt Fleming <matt@console-pimps.org>, Ben Dooks <ben-linux@fluff.org>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

Hi all,

Currently the sdhci driver does everything in the atomic context.
And what is worse, PIO transfers are made from the IRQ handler.

This causes huge latencies (up to 120 ms). On some P2020 SOCs,
DMA and card detection is broken, which means that kernel polls
for the card via PIO transfers every second. Needless to say
that this is quite bad.

So, this patch set reworks sdhci code to avoid atomic context,
almost completely. We only do two device memory operations
in the atomic context, and all the rest is threaded.

I noticed no throughput drop neither with PIO transfers nor
with DMA (tested on MPC8569E CPU), while latencies should be
greatly improved.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
