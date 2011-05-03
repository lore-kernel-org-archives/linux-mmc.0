From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Tue, 3 May 2011 22:02:42 +0200
Message-ID: <201105032202.42662.arnd@arndb.de>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com> <201105031516.28907.arnd@arndb.de> <BANLkTi=74Mp1vWBt2F-sqqqkeNfP69+9vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52952 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab1ECUCs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2011 16:02:48 -0400
In-Reply-To: <BANLkTi=74Mp1vWBt2F-sqqqkeNfP69+9vg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On Tuesday 03 May 2011 20:54:43 Per Forlin wrote:
> >> page_not_up_to_date:
> >> /* Get exclusive access to the page ... */
> >> error = lock_page_killable(page);
> > I looked at the code in do_generic_file_read(). lock_page_killable
> > waits until the current read ahead is completed.
> > Is it possible to configure the read ahead to push multiple read
> > request to the block device queue?add

I believe sleeping in __lock_page_killable is the best possible scenario.
Most cards I've seen work best when you use at least 64KB reads, so it will
be faster to wait there than to read smaller units.

> When I first looked at this I used dd if=/dev/mmcblk0 of=/dev/null bs=1M count=4
> If bs is larger than read ahead, this will make the execution loop in
> do_generic_file_read() reading 512 until 1M is read. The second time
> in this loop it will wait on lock_page_killable.
>
> If bs=16k the execution wont stuck at lock_page_killable.

submitting small 512 byte read requests is a real problem when the
underlying page size is 16 KB. If your interpretation is right,
we should probably find a way to make it read larger chunks
on flash media.

	Arnd
