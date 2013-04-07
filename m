From: Tejun Heo <tj@kernel.org>
Subject: Re: FLUSH mechanism implementation in block layer
Date: Sun, 7 Apr 2013 09:33:45 -0700
Message-ID: <20130407163345.GC12038@htj.dyndns.org>
References: <51617172.10300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43725 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934035Ab3DGQdt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 12:33:49 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so2819958pdd.3
        for <linux-mmc@vger.kernel.org>; Sun, 07 Apr 2013 09:33:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51617172.10300@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org

Hey,

On Sun, Apr 07, 2013 at 04:15:30PM +0300, Tanya Brokhman wrote:
> I've been looking into the flush implementation, trying to
> understand how it works. FLUSH command can be used for two purposes:
> 1. Flush the data to the non-volatile memory from the card cache
> 2. Keep an order of requests: req_A.... req_D, FLUSH, req_C...req_X
> Unfortunately I don't understand how the second purpose of FLUSH is
> implemented. If to simplify the question, let take for example a
> card that doesn't implement a writeback cache (doesn't support
> FLUSH/FUA) and the following example:
> 
> The application inserts req_A...req_D to the block layer (and the
> scheduler) and issues req_FLUSH that contains data. What is expected
> in this situation is that req_A..req_D will be written to the
> non-volatile memory before req_FLUSH.
> According to the code at blk_insert_flush() the req_FLUSH request
> will be marked as SOFTBARRIER and added to the tail of the dispatch
> queue.
> But what guaranties that by the time it's added to the dispatch
> queue req_A..req_D have been dispatched as well? It's possible that
> they are still in scheduler and will be dispatched only after
> req_FLUSH is completed...

Which version of kernel are you looking at?  The barrier / flush
implementation went through several iterations and in the current
iteration ordering of requests around the flush request is the
responsibility of higher layer - ie. filesystems are required to wait
for completions of commands which should come before flush before
issuing it.

Thanks.

-- 
tejun
