From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: block: Remove use of mmc_blk_set_blksize
Date: Sat, 31 Mar 2012 23:52:14 -0400
Message-ID: <87ehs8m7m9.fsf@laptop.org>
References: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56847 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab2DADwI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 31 Mar 2012 23:52:08 -0400
In-Reply-To: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 22 Mar 2012 11:47:26 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Subhash Jadavani <subhashj@codeaurora.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi,

On Thu, Mar 22 2012, Ulf Hansson wrote:
> According to the specifications for SD and (e)MMC default
> blocksize (named BLOCKLEN in Spec.) must always be 512
> bytes. Since we hardcoded to always use 512 bytes, we do
> not explicitly have to set it. Future improvements should
> potentially make it possible to use a greater blocksize
> than 512 bytes, but until then let's skip this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Thanks, pushed to mmc-next for 3.5 with Subhash's Reviewed-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
