From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Sun, 28 Oct 2012 14:52:51 +0200
Message-ID: <508D2AA3.8080902@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>	<5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org> <CAOyx1Lo9P6fvp+6Y+PAyrPovpqzf8nR3U4UEyTqtuxZ9WSPJCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:59426 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab2J1Mwy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Oct 2012 08:52:54 -0400
In-Reply-To: <CAOyx1Lo9P6fvp+6Y+PAyrPovpqzf8nR3U4UEyTqtuxZ9WSPJCw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Per Forlin <per.lkml@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello Venkatraman,
You are very welcome with any ideas,

On 10/26/2012 01:55 PM, Venkatraman S wrote:

> 
> Being nitpicky, I think it contradicts with the commit log that you have
> for the patch..
> <Quote>
> When the block layer notifies the MMC layer on a new request, we check
> for the above case where MMC layer is waiting on a previous request
> completion and the current request is NULL.
> </Quote>
> 

Can you be more specific? What is contradiction? Can you suggest better
patch description?

What I'm trying to say here:

the patch will modify block layer notification (mmc_request() callback)
on new incoming request in such way, that when MMC layer is blocked by
waiting for completion of previous request (in core/core.c) - it will
unblock MMC layer, rollback in mmc_queue_thread code up to blk_fetch()
point. This will permit to the MMC layer start processing of newly
notified request immediately (and not after completion of currently
running request).

Does it make sense?


-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
