From: Matt Fleming <matt@console-pimps.org>
Subject: Re: mmc: sdhci.h compile error
Date: Mon, 26 Apr 2010 12:18:29 +0100
Message-ID: <87mxwqzcl6.fsf@linux-g6p1.site>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
	<87zl0rb20u.fsf@linux-g6p1.site>
	<g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:56726 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab0DZLSd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 07:18:33 -0400
In-Reply-To: <g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 26 Apr 2010 15:46:31 +0800, zhangfei gao <zhangfei.gao@gmail.com> wrote:
> Hi, Matt
> 
> We also rename the function name to pass compile.
> Besides, here is typo error drivers/mmc/host/sdhci.h, though it is not
> a big deal.

Good catch! How did you notice that? Did you see a failure at runtime or
did you spot it by reading the code? If you were seeing a bug at runtime
then this patch should also be sent to stable@kernel.org.

I don't have any hardware to test this patch but the change looks like
it makes sense.
