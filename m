From: Tejun Heo <tj@kernel.org>
Subject: Re: FLUSH mechanism implementation in block layer
Date: Tue, 9 Apr 2013 12:03:36 -0700
Message-ID: <20130409190336.GG6186@mtj.dyndns.org>
References: <51617172.10300@codeaurora.org>
 <20130407163345.GC12038@htj.dyndns.org>
 <51624547.6000500@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:49486 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834Ab3DITDl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Apr 2013 15:03:41 -0400
Received: by mail-qc0-f173.google.com with SMTP id b12so3173833qca.32
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2013 12:03:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51624547.6000500@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mmc@vger.kernel.org, merez@codeaurora.org, kdorfman@codeaurora.org

Hey,

On Mon, Apr 08, 2013 at 07:19:19AM +0300, Tanya Brokhman wrote:
> completed after the FLUSH. But perhaps there is a correct way to
> move the implementation of "ordering around the flush" to the block
> layer? Not that it would work better, it just feels that logically -
> block layer is the place to do it at.
> What do you think?

It used to be implemented that way - REQ_BARRIER.  The problem was
that filesystems wanted multiple dependency streams - ie. fdatasync()
of a file doesn't need to drain all other IOs in progress.  We could
do coloring of IOs - ie. give IOs which may need flushing later but
belong to different dependency streams different colors and let block
layer figure out partial drainining, which would work but at the same
time be pretty nasty and complex.  The thing was that most filesystems
were already drainings IOs and didn't need any ordering guarantee from
block layer.  hch took care of the outliers which were depending on
REQ_BARRIER ordering guarantees and we just stripped the ordering
mechanism which immediately improved performance noticeably in certain
workloads.

It was done that way mostly out of convenience at that time but now I
think of it it's the correct thing to do.  It just is too much
information to communicate downwards and the extra communication
overhead doesn't really buy anything.

Thanks.

-- 
tejun
