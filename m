From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] drivers: mmc: reordered shutdown sequence in mmc_bld_remove_req
Date: Thu, 27 Jun 2013 11:23:09 -0400
Message-ID: <87k3lfpogy.fsf@octavius.laptop.org>
References: <1370382160-7576-1-git-send-email-taysom@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52393 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab3F0PXQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:23:16 -0400
In-Reply-To: <1370382160-7576-1-git-send-email-taysom@chromium.org> (Paul
	Taysom's message of "Tue, 4 Jun 2013 14:42:40 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Taysom <taysom@chromium.org>
Cc: Namjae Jeon <linkinjeon@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, sonny@chromium.org, olofj@chromium.org

Hi Paul,

On Tue, Jun 04 2013, Paul Taysom wrote:
> We had a multi-partition SD-Card with two ext2 file systems. The partition
> table was getting overwritten by a race between the card removal and
> the unmount of the 2nd ext2 partition.
>
> What was observed:
> 1. Suspend/resume would call to remove the device. The clearing
>    of the device information is done asynchronously.
> 2. A request is made to unmount the file system (this is called
>    after the removal has started).
> 3. The remapping table was cleared by the asynchronous part of
>    the device removal.
> 4. A write request to the super block (block 0 of the partition)
>    was sent down and instead of being remapped to the partition
>    offset, it was remapped to block 0 of the device which is where
>    the partition table is located.
> 5. Write was queued and written resulting in the overwriting
>    of the partition table with the ext2 super block.
> 6. The mmc_queue is cleaned up.
>
> The mmc card device driver used to access SD cards, was calling del_gendisk
> before calling mmc_cleanup-queue. The comment in the mmc_blk_remove_req
> code indicated that it expected del_gendisk to block all further requests
> from being queued but it doesn't. The mmc driver uses the presences of the
> mmc_queue to determine if the request should be queued.
>
> The fix was to clean up the mmc_queue before the rest of the
> the delete partition code is called.
>
> This prevents the overwriting of the partition table.
>
> However, the umount gets an error trying to write the super block.
> The umount should be issued before the device is removed but that
> is not always possible. The umount is still needed to cleanup other
> data structures.
>
> Addresses the problem described in http://crbug.com/240815
>
> Signed-off-by: Paul Taysom <taysom@chromium.org>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
