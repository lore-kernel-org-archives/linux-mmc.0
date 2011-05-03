From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Tue, 3 May 2011 15:16:28 +0200
Message-ID: <201105031516.28907.arnd@arndb.de>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53025 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1ECNQm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2011 09:16:42 -0400
In-Reply-To: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On Thursday 28 April 2011, Per Forlin wrote:

> For reads on the other hand it look like this
> root@(none):/ dd if=/dev/mmcblk0 of=/dev/null bs=4k count=256
> 256+0 records in
> 256+0 records out
> root@(none):/ dmesg
> [mmc_queue_thread] req d954cec0 blocks 32
> [mmc_queue_thread] req   (null) blocks 0
> [mmc_queue_thread] req   (null) blocks 0
> [mmc_queue_thread] req d954cec0 blocks 64
> [mmc_queue_thread] req   (null) blocks 0
> [mmc_queue_thread] req d954cde8 blocks 128
> [mmc_queue_thread] req   (null) blocks 0
> [mmc_queue_thread] req d954cec0 blocks 256
> [mmc_queue_thread] req   (null) blocks 0

> There are never more than one read request in the mmc block queue. All
> the mmc request preparations will be serialized and the cost for this
> is roughly 10% lower bandwidth (verified on ARM platforms ux500 and
> Pandaboard).

After some offline discussions, I went back to look at your mail, and I think
the explanation is much simpler than you expected:

You have only a single process reading blocks synchronously, so the round
trip goes all the way to user space. The block layer does some readahead,
so it will start reading 32 blocks instead of just 8 (4KB) for the first
read, but then the user process just sits waiting for data. After the
mmc driver has finished reading the entire 32 blocks, the user needs a
little time to read them from the page cache in 4 KB chunks (8 syscalls),
during which the block layer has no clue about what the user wants to do
next.

The readahead scales up to 256 blocks, but there is still only one reader,
so you never have additional requests in the queue.

Try running multiple readers in parallel, e.g.

for i in 1 2 3 4 5 ; do 
	dd if=/dev/mmcblk0 bs=16k count=256 iflag=direct skip=$[$i * 1024] &
done


	Arnd
