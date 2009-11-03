From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] Disk hot removal causing oopses and fixes
Date: Tue, 03 Nov 2009 20:51:29 +0100
Message-ID: <4AF089C1.4010806@s5r6.in-berlin.de>
References: <20091021161201.GA16968@angel.research.nokia.com> <4ADF752D.7010206@s5r6.in-berlin.de> <20091103115444.GA8507@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:46817 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbZKCTvb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Nov 2009 14:51:31 -0500
In-Reply-To: <20091103115444.GA8507@angel.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Jarkko Lavinen wrote:
> Hi Steven
> 
> Sorry for late reply.
> 
>> It has to reference-count its objects so that they are not freed as long
>> as they are used by upper layers,
> 
> The block layer and device removal seems to be designed from
> top-down approach.  Althouh disc is referenced from
> __blkdev_get(), disc's request queue is not.  Also
> blk_cleanup_queue() calls elevator_exit() without caring if
> anyone still uses the elevator.
[...]

I still don't understand how there can be a problem here.  Shouldn't the
sequence be:

 1. low-level determines that a device went away
 2. low-level takes note that from now on no new requests must be
    enqueued anymore
 3. low-level calls blk_cleanup_queue
 4. blk_cleanup_queue waits until remaining requests are done
    (it calls blk_sync_queue)
 5. blk_cleanup_queue cleans up block layer data
 6. low-level can now clean up/ free its own data

Does the MMC layer miss step 2?  Because without this, step 4 would be
in vain.
-- 
Stefan Richter
-=====-==--= =-== ---==
http://arcgraph.de/sr/
