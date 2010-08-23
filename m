From: Matt Fleming <matt@console-pimps.org>
Subject: Re: + sdhci-support-mmc_cap_mmc_highspeed.patch added to -mm tree
Date: Mon, 23 Aug 2010 21:22:58 +0100
Message-ID: <20100823202258.GA6510@console-pimps.org>
References: <201008232009.o7NK9LIf012151@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:51998 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752155Ab0HWUXA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Aug 2010 16:23:00 -0400
Content-Disposition: inline
In-Reply-To: <201008232009.o7NK9LIf012151@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, zhangfei.gao@gmail.com, linux-mmc@vger.kernel.org, zgao6@marvell.com, Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Aug 23, 2010 at 01:09:21PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      sdhci: support MMC_CAP_MMC_HIGHSPEED
> has been added to the -mm tree.  Its filename is
>      sdhci-support-mmc_cap_mmc_highspeed.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: sdhci: support MMC_CAP_MMC_HIGHSPEED
> From: zhangfei gao <zhangfei.gao@gmail.com>
> 
> With MMC_CAP_MMC_HIGHSPEED, mmc & emmc could negotiate up to 50M,
> otherwise only 25M could be reached.
> 
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> Acked-by: Matt Fleming <matt@console-pimps.org> 
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Andrew, Kyungmin Park also ACK'd this.
