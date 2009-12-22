From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mmc_block: fix queue cleanup
Date: Tue, 22 Dec 2009 14:20:55 -0800
Message-ID: <20091222142055.fc97214b.akpm@linux-foundation.org>
References: <20091218121527.4351.14601.sendpatchset@ahunter-work.research.nokia.com>
	<20091218121548.4351.24938.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43394 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755177AbZLVWWU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2009 17:22:20 -0500
In-Reply-To: <20091218121548.4351.24938.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, stable@kernel.org

On Fri, 18 Dec 2009 14:15:48 +0200
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> The main bug was that 'blk_cleanup_queue()' was called while
> the block device could still be in use, for example, because
> the card was removed while files were still open.
> 
> In addition, to be sure that 'mmc_request()' will get called
> for all new requests (so it can error them out), the queue is
> emptied during cleanup.  This is done after the worker thread
> is stopped to avoid racing with it.
> 
> Finally, it is not a device error for this to be happening, so
> quiet the (sometimes very many) error messages.

What nice changelogs.

Thanks, I tagged all three patches for a 2.6.32.x backport.  They do
appear to be applicable to 2.6.31 and perhaps earlier, also.

