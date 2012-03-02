From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mmci: reduce max_blk_count to avoid overflowing max_req_size
Date: Fri, 02 Mar 2012 16:02:38 -0500
Message-ID: <m2ehtan2c1.fsf@bob.laptop.org>
References: <1330082721-6021-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60455 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab2CBVCq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 2 Mar 2012 16:02:46 -0500
In-Reply-To: <1330082721-6021-1-git-send-email-will.deacon@arm.com> (Will
	Deacon's message of "Fri, 24 Feb 2012 11:25:21 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <drzeus@drzeus.cx>

Hi Will,

On Fri, Feb 24 2012, Will Deacon wrote:
> On a system with large pages (64k in my case), the following BUG is
> triggered in MMC core:
>
> [    2.338023] BUG: failure at drivers/mmc/core/core.c:221/mmc_start_request()!
> [    2.338102] Kernel panic - not syncing: BUG!
> [    2.338155] Call trace:
> [    2.338228] [<ffffffc00008635c>] dump_backtrace+0x0/0x120
> [    2.338317] [<ffffffc0003365ec>] dump_stack+0x14/0x1c
> [    2.338403] [<ffffffc000336990>] panic+0xbc/0x1f0
> [    2.338498] [<ffffffc00027a494>] mmc_start_request+0x154/0x184
> [    2.338600] [<ffffffc00027abdc>] mmc_start_req+0x110/0x140
> [    2.338701] [<ffffffc00028604c>] mmc_blk_issue_rw_rq+0x7c/0x39c
> [    2.338804] [<ffffffc00028652c>] mmc_blk_issue_rq+0x1c0/0x468
> [    2.338905] [<ffffffc000287564>] mmc_queue_thread+0x68/0x118
> [    2.338995] [<ffffffc0000bc308>] kthread+0x84/0x8c
>
> This is because of a 64k request with a max_req_size of 64k-1 bytes.
>
> The following patch fixes the problem by limiting the max_blk_count
> such that max_blk_count * max_blk_size == max_req_size. I couldn't
> pursuade the compiler to emit a shift instead of a div without encoding
> the shift explicitly.
>
> Cc: Pierre Ossman <drzeus@drzeus.cx>
> Cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
