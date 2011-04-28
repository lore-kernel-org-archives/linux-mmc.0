From: Per Forlin <per.forlin@linaro.org>
Subject: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Thu, 28 Apr 2011 20:30:12 +0200
Message-ID: <BANLkTimOVO9ogfhjM-mjzTR=M0Q2LU5WGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38489 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248Ab1D1SaM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 14:30:12 -0400
Received: by pzk9 with SMTP id 9so1794778pzk.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 11:30:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org, majordomo@kvack.org

Hi,

I am working on minimizing the latency between two block requests in
the mmc framework. The approach is simple. If there are more than one
request in the block queue the 2nd request will be prepared while the
1st request is being transfered. When the 1 st request is completed
the 2nd request will start with minimal latency cost.

For writes this work fine:
root@(none):/ dd of=/dev/mmcblk0p2 if=/dev/zero bs=4k count=2560
2560+0 records in
2560+0 records out
root@(none):/ dmesg
[mmc_queue_thread] req d97a2ac8 blocks 1024
[mmc_queue_thread] req d97a2ba0 blocks 1024
[mmc_queue_thread] req d97a2c78 blocks 1024
[mmc_queue_thread] req d97a2d50 blocks 1024
[mmc_queue_thread] req d97a2e28 blocks 1024
[mmc_queue_thread] req d97a2f00 blocks 1024
[mmc_queue_thread] req d954c9b0 blocks 1024
[mmc_queue_thread] req d954c800 blocks 1024
[mmc_queue_thread] req d954c728 blocks 1024
[mmc_queue_thread] req d954c650 blocks 1024
[mmc_queue_thread] req d954c578 blocks 1024
[mmc_queue_thread] req d954c4a0 blocks 1024
[mmc_queue_thread] req d954c8d8 blocks 1024
[mmc_queue_thread] req d954c3c8 blocks 1024
[mmc_queue_thread] req d954c2f0 blocks 1024
[mmc_queue_thread] req d954c218 blocks 1024
[mmc_queue_thread] req d954c140 blocks 1024
[mmc_queue_thread] req d954c068 blocks 1024
[mmc_queue_thread] req d954cde8 blocks 1024
[mmc_queue_thread] req d954cec0 blocks 1024
mmc block queue is never empty. All the mmc request preparations can
run in parallel with an ongoing transfer.

[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req   (null) blocks 0
"req (null)" indicates there are no requests pending in the mmc block
queue. This is expected since there are no more requests to process.

For reads on the other hand it look like this
root@(none):/ dd if=/dev/mmcblk0 of=/dev/null bs=4k count=256
256+0 records in
256+0 records out
root@(none):/ dmesg
[mmc_queue_thread] req d954cec0 blocks 32
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 64
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cde8 blocks 128
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cde8 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cde8 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cde8 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cde8 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req d954cec0 blocks 256
[mmc_queue_thread] req   (null) blocks 0
[mmc_queue_thread] req   (null) blocks 0
There are never more than one read request in the mmc block queue. All
the mmc request preparations will be serialized and the cost for this
is roughly 10% lower bandwidth (verified on ARM platforms ux500 and
Pandaboard).

> page_not_up_to_date:
> /* Get exclusive access to the page ... */
> error = lock_page_killable(page);
I looked at the code in do_generic_file_read(). lock_page_killable
waits until the current read ahead is completed.
Is it possible to configure the read ahead to push multiple read
request to the block device queue?

Thanks,
Per
