From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Tue, 10 Apr 2012 14:38:14 -0400
Message-ID: <87pqbfv3e1.fsf@laptop.org>
References: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56552 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157Ab2DJSiO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 14:38:14 -0400
In-Reply-To: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>
	(Subhash Jadavani's message of "Tue, 10 Apr 2012 23:56:52 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi,

On Tue, Apr 10 2012, Subhash Jadavani wrote:
> This patch replaces all __blk_end_request() calls with
> blk_end_request() and __blk_end_request_all() calls with
> blk_end_request_all().
>
> Testing done: 20 process concurrent read/write on sd card
> and eMMC. Ran this test for almost a day on multicore system
> and no errors observed.

Is there a measurable improvement in throughput or latency that
you can show data for?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
