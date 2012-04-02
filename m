From: Hugh Dickins <hughd@google.com>
Subject: Re: swap on eMMC and other flash
Date: Mon, 2 Apr 2012 07:41:56 -0700 (PDT)
Message-ID: <alpine.LSU.2.00.1204020734560.1847@eggly.anvils>
References: <201203301744.16762.arnd@arndb.de> <201203301850.22784.arnd@arndb.de> <alpine.LSU.2.00.1203311230490.10965@eggly.anvils> <201204021145.43222.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54382 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2DBOmc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 10:42:32 -0400
Received: by iagz16 with SMTP id z16so4185487iag.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Apr 2012 07:42:31 -0700 (PDT)
In-Reply-To: <201204021145.43222.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rik van Riel <riel@redhat.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, linux-kernel@vger.kernel.org, "Luca Porzio (lporzio)" <lporzio@micron.com>, linux-mm@kvack.org, Hyojin Jeong <syr.jeong@samsung.com>, kernel-team@android.com, Yejin Moon <yejin.moon@samsung.com>

On Mon, 2 Apr 2012, Arnd Bergmann wrote:
> 
> Another option would be batched discard as we do it for file systems:
> occasionally stop writing to swap space and scanning for areas that
> have become available since the last discard, then send discard
> commands for those.

I'm not sure whether you've missed "swapon --discard", which switches
on discard_swap_cluster() just before we allocate from a new cluster;
or whether you're musing that it's no use to you because you want to
repurpose the swap cluster to match erase block: I'm mentioning it in
case you missed that it's already there (but few use it, since even
done at that scale it's often more trouble than it's worth).

Hugh
