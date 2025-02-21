Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3020E337
	for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2025 13:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145177; cv=none; b=HAc7f+zSiQo0WvunBMax6EN7A8zeC+9lGPW0HqkIZOTj5YfIiDp3qO5bswTaPBdgIweBJ13itHa97ycTeIqrVXLkCGPyuh2u1GIdG0L2nkttravGhcH4TbjVVvl+to9odQI7AzJe1KxwagYS241Ft42pA6IeGttbY9lXLEoEdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145177; c=relaxed/simple;
	bh=pds9veOP5v/FsAe6Z3SuixrbK3yo4QD4KmX7/cL8QTw=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=ERr0HOasnKR5uQfn6JGq3noZi4RMUCIvZh7OweLPNIQhzFfX1+0NqwUrMXH3AGcGuDQVEBlWfmZI9Ur6vGwHO5ViAprf4oY2JibOGg49CYiYz7Nn6PAJGtdt+Hev5WxVSXxbdDRXfE8LlWHxzWLb7lKG8rSiPXeNhrnc2OIjebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr3wD0tq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr3wD0tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004AAC4CED6;
	Fri, 21 Feb 2025 13:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145177;
	bh=pds9veOP5v/FsAe6Z3SuixrbK3yo4QD4KmX7/cL8QTw=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=Vr3wD0tqdx3boRqcj1qYWrdEnyM8M7OQnDDb0/YFchjDxaz8tgjj2hEU9DIDWfXH3
	 x0CFmEzCUmPOEmw2mJ+b3pU7iap4zSlcwSpJU3CkFwi9oAVPicPFjjNRbtSUpLRAN5
	 eVqf2Idr8TuyLY28r/QZsqKvoK/Bf387BcUDr6M865dUKfCe+pncFtCTp6kQRwU5yl
	 I9tr5DpjIwxWQDsic+h33AdNX6TOzT4FVh7hZob7oM7NAmvtpIs3+chUIVzH8cZKtD
	 I5iaYGaqk5jDwrrBy/I8E+fvlI7XweX6QJk3D3oqKaDIRZqX/cW0RcdRYIV5ky/jMu
	 EYBLQdmEyk+JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1A0A3804CAF;
	Fri, 21 Feb 2025 13:40:08 +0000 (UTC)
From: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Date: Fri, 21 Feb 2025 13:40:16 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ricky_wu@realtek.com, ulf.hansson@linaro.org
Message-ID: <20250221-b218821c12-65606d75b0ee@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Thomas Haschka writes via Kernel.org Bugzilla:

I bisected the problem, and it seems come from the blocklayer. 

Before this change the SD cards in my Surface GO 2 behave correctly, afterwards they fail after a couple of minutes usage, especially on card rw intensive tasks. 

The SD card basically stops working correctly after the following commit:

smr /usr/src/linux # git bisect good 
65a558f66c308251e256317957b75d1e643c33c3 is the first bad commit
commit 65a558f66c308251e256317957b75d1e643c33c3
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Fri Jul 21 10:27:30 2023 -0700

    block: Improve performance for BLK_MQ_F_BLOCKING drivers
    
    blk_mq_run_queue() runs the queue asynchronously if BLK_MQ_F_BLOCKING
    has been set. This is suboptimal since running the queue asynchronously
    is slower than running the queue synchronously. This patch modifies
    blk_mq_run_queue() as follows if BLK_MQ_F_BLOCKING has been set:
    - Run the queue synchronously if it is allowed to sleep.
    - Run the queue asynchronously if it is not allowed to sleep.
    Additionally, blk_mq_run_hw_queue(hctx, false) calls are modified into
    blk_mq_run_hw_queue(hctx, hctx->flags & BLK_MQ_F_BLOCKING) if the caller
    may be invoked from atomic context.
    
    The following caller chains have been reviewed:
    
    blk_mq_run_hw_queue(hctx, false)
      blk_mq_get_tag()      /* may sleep, hence the functions it calls may also sleep */
      blk_execute_rq()             /* may sleep */
      blk_mq_run_hw_queues(q, async=false)
        blk_freeze_queue_start()   /* may sleep */
        blk_mq_requeue_work()      /* may sleep */
        scsi_kick_queue()
          scsi_requeue_run_queue() /* may sleep */
          scsi_run_host_queues()
            scsi_ioctl_reset()     /* may sleep */
      blk_mq_insert_requests(hctx, ctx, list, run_queue_async=false)
        blk_mq_dispatch_plug_list(plug, from_sched=false)
          blk_mq_flush_plug_list(plug, from_schedule=false)
            __blk_flush_plug(plug, from_schedule=false)
            blk_add_rq_to_plug()
              blk_mq_submit_bio()  /* may sleep if REQ_NOWAIT has not been set */
      blk_mq_plug_issue_direct()
        blk_mq_flush_plug_list()   /* see above */
      blk_mq_dispatch_plug_list(plug, from_sched=false)
        blk_mq_flush_plug_list()   /* see above */
      blk_mq_try_issue_directly()
        blk_mq_submit_bio()        /* may sleep if REQ_NOWAIT has not been set */
      blk_mq_try_issue_list_directly(hctx, list)
        blk_mq_insert_requests() /* see above */
    
    Cc: Christoph Hellwig <hch@lst.de>
    Cc: Ming Lei <ming.lei@redhat.com>
    Signed-off-by: Bart Van Assche <bvanassche@acm.org>
    Link: https://lore.kernel.org/r/20230721172731.955724-4-bvanassche@acm.org
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

 block/blk-mq.c          | 16 ++++++++++------
 drivers/scsi/scsi_lib.c |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c12
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

