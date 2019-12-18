Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E884C2D0C3
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050AE218AC
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576657998;
	bh=Junqz+6lLG0P4Dk4h48/gIhu7sjxQH/ijH2dR4doCNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWkEtXJkt0qJMcOh52Pp/AiIr0O33meffaF3COdIn7xZN4dLHJGW5gXG4HadPT+9O
	 8dKEQX+B0iFUpAdRE1favdCSODg2vVqVQI+/PBr25osJOt7ResArT6aVpWrpQSf45L
	 b8xhUjhrBz0dB1lNREhpBrxhKUfJxjKeBAdDMKVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbfLRIdR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfLRIdR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Dec 2019 03:33:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198B520717;
        Wed, 18 Dec 2019 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576657996;
        bh=Junqz+6lLG0P4Dk4h48/gIhu7sjxQH/ijH2dR4doCNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKHi+R2smU7CRobl43ONtxand1FTWoqpps7XgNvkmXJOE02q2NlruTzfVwclvOUxh
         rZESja1uhZsdRNiOcD2C7YluH0w+NBT7KhhvVmXgxJ2q7dQNMF5BB0hCJvLO0uwrNH
         Lkp2D2agCnD1Bx9VjagbaZP4aZcEkxMFnrKaHTuU=
Date:   Wed, 18 Dec 2019 09:33:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sayali Lokhande <sayalil@codeaurora.org>
Subject: Re: [<PATCH v1> 4/9] mmc: core: fix SD card request queue refcount
 underflow during shutdown
Message-ID: <20191218083314.GC1554871@kroah.com>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
 <afdbf5eff1918f4004f2418e90bd08400d40ed1b.1576540907.git.nguyenb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afdbf5eff1918f4004f2418e90bd08400d40ed1b.1576540907.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 06:50:37PM -0800, Bao D. Nguyen wrote:
> From: Can Guo <cang@codeaurora.org>
> 
> When system shutdown, kernel shall call shutdown function of mmc to stop
> its request queue and clean it up, during which the request queue's kobject
> shall be put once. In normal cases, if the SD card is removed, the
> mmc_blk_remove routine releases all the resources and kobjects related to
> the disk and request queue by decreasing their kref counts to 0. But if the
> SD card is removed after its shutdown function is called, below kref count
> underflow error shall be thrown out because the kref count was decreased
> once during request queue cleanup by the shutdown function in advance. This
> change fixes it by skipping request queue cleanup in the mmc blk routine if
> the queue has been marked as dead.
> 
> [  166.187211] refcount_t: underflow; use-after-free.
> [  166.187277] ------------[ cut here ]------------
> [  166.187321] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  166.187542] Workqueue: events_freezable mmc_rescan
> [  166.187558] task: ffffffe673b96680 task.stack: ffffff8008418000
> [  166.187579] pc : refcount_sub_and_test+0x64/0x78
> [  166.187593] lr : refcount_sub_and_test+0x64/0x78
> [  166.187605] sp : ffffff800841ba20 pstate : 60c00145
> [  166.188319] Call trace:
> [  166.188331]  refcount_sub_and_test+0x64/0x78
> [  166.188343]  refcount_dec_and_test+0x18/0x24
> [  166.188355]  kobject_put+0x5c/0x74
> [  166.188374]  blk_put_queue+0x1c/0x28
> [  166.188388]  disk_release+0x70/0x90
> [  166.188402]  device_release+0x38/0x90
> [  166.188429]  kobject_cleanup+0xc4/0x1c0
> [  166.188441]  kobject_put+0x68/0x74
> [  166.188455]  put_disk+0x20/0x2c
> [  166.188467]  mmc_blk_put+0x9c/0xdc
> [  166.188480]  mmc_blk_remove_req+0x110/0x120
> [  166.188493]  mmc_blk_remove+0x14c/0x22c
> [  166.188505]  mmc_bus_remove+0x24/0x34
> [  166.188517]  device_release_driver_internal+0x13c/0x1e0
> [  166.188528]  device_release_driver+0x24/0x30
> [  166.188540]  bus_remove_device+0xdc/0x120
> [  166.188552]  device_del+0x1e0/0x284
> [  166.188564]  mmc_remove_card+0x68/0x7c
> [  166.188577]  mmc_sd_remove+0x24/0x48
> [  166.188588]  mmc_sd_detect+0x120/0x1a4
> [  166.188600]  mmc_rescan+0xf4/0x384
> [  166.188613]  process_one_work+0x1c0/0x3d4
> [  166.188625]  worker_thread+0x224/0x344
> [  166.188637]  kthread+0x120/0x130
> [  166.188649]  ret_from_fork+0x10/0x18.
> 
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> ---
>  drivers/mmc/core/queue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 9edc086..846557b 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -506,7 +506,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>  	if (blk_queue_quiesced(q))
>  		blk_mq_unquiesce_queue(q);
>  
> -	blk_cleanup_queue(q);
> +	if (likely(!blk_queue_dead(q)))
> +		blk_cleanup_queue(q);

Unless you can measure the performance impact, never use unlikely/likely
in kernel code.  The compiler and cpu will always do much better over
time than you can.

That being said, what will cleanup the queue if it is not "dead" at this
point in time, later on?  Isn't this a leak?

thanks,

greg k-h
