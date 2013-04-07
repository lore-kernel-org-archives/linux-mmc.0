From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: FLUSH mechanism implementation in block layer
Date: Sun, 07 Apr 2013 16:15:30 +0300
Message-ID: <51617172.10300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:60589 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933584Ab3DGNPf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Apr 2013 09:15:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tj@kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org

Hello Tejun,

I'm writing to you since you're signed on the blk-flush.c file, hoping 
you could answer a flush-related question for me. Please excuse me if 
you're not the right person to address this to.

I've been looking into the flush implementation, trying to understand 
how it works. FLUSH command can be used for two purposes:
1. Flush the data to the non-volatile memory from the card cache
2. Keep an order of requests: req_A.... req_D, FLUSH, req_C...req_X
Unfortunately I don't understand how the second purpose of FLUSH is 
implemented. If to simplify the question, let take for example a card 
that doesn't implement a writeback cache (doesn't support FLUSH/FUA) and 
the following example:

The application inserts req_A...req_D to the block layer (and the 
scheduler) and issues req_FLUSH that contains data. What is expected in 
this situation is that req_A..req_D will be written to the non-volatile 
memory before req_FLUSH.
According to the code at blk_insert_flush() the req_FLUSH request will 
be marked as SOFTBARRIER and added to the tail of the dispatch queue.
But what guaranties that by the time it's added to the dispatch queue 
req_A..req_D have been dispatched as well? It's possible that they are 
still in scheduler and will be dispatched only after req_FLUSH is 
completed...

One possible solution to this is if the application waits to get a 
completion callback on req_A..req_D before issuing the req_FLUSH. Is 
this indeed the case? I didn't find any documentation on it on the web.

Thanks,
Tanya Brokhman

-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
