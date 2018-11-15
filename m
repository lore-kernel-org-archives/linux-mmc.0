From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH 04/16] block: use atomic bitops for
	->queue_flags
Date: Thu, 15 Nov 2018 10:04:35 +0100
Message-ID: <20181115090435.GA14370@lst.de>
References: <20181114160219.28328-1-hch@lst.de>
	<20181114160219.28328-5-hch@lst.de>
	<ddb96188-b2dd-6aaf-90f5-7eb5889691f8@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ddb96188-b2dd-6aaf-90f5-7eb5889691f8-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <http://lists.linbit.com/mailman/options/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linbit.com/pipermail/drbd-dev>
List-Post: <mailto:drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org>
List-Help: <mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linbit.com/mailman/listinfo/drbd-dev>,
	<mailto:drbd-dev-request-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org?subject=subscribe>
Sender: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
Errors-To: drbd-dev-bounces-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
To: Hannes Reinecke <hare-l3A5Bk7waGM@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, drbd-dev-cunTk1MwBs8qoQakbn7OcQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 15, 2018 at 07:55:02AM +0100, Hannes Reinecke wrote:
>> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
>> ---
>>   block/blk-core.c       | 54 ++++++----------------------------------
>>   block/blk-mq.c         |  2 +-
>>   block/blk-settings.c   | 10 +++-----
>>   block/blk-sysfs.c      | 28 +++++++++------------
>>   block/blk.h            | 56 ------------------------------------------
>>   include/linux/blkdev.h |  1 -
>>   6 files changed, 24 insertions(+), 127 deletions(-)
>>
> I wonder if we can't remove the 'blk_queue_flag_XXX' helpers and replace 
> them with inlines ...

I'd prefer to just open code the *bit helpers as that is a lot more
reasonable.  But that is quite a lot of churn, so I'll only do that if
I get previous buy-in to that idea, and preferably in a separate series.
