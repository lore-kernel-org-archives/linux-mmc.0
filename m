From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH V2 1/5] mmc: msm_sdcc: Fix possible circular locking
 dependency warning
Date: Thu, 09 Dec 2010 20:51:58 +0530
Message-ID: <1291908118.21924.69.camel@stummala-linux.in.qualcomm.com>
References: <1291800787-24757-1-git-send-email-stummala@codeaurora.org>
	 <1291832726.12568.5.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:29155 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0LIPWR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 10:22:17 -0500
In-Reply-To: <1291832726.12568.5.camel@c-dwalke-linux.qualcomm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Walker <dwalker@codeaurora.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, san@google.com, linux-arm-msm@vger.kernel.org

Hi Daniel,

On Wed, 2010-12-08 at 10:25 -0800, Daniel Walker wrote:
> On Wed, 2010-12-08 at 15:03 +0530, Sahitya Tummala wrote:
> > In the context of request processing thread, data mover lock is
> > acquired after the host lock.  In another context, in the completion
> > handler of data mover the locks are acquired in the reverse order,
> > resulting in possible circular lock dependency warning. Hence,
> > schedule a tasklet to process the dma completion so as to avoid
> > nested locks.
> > 
> 
> Can you just alter the location where the locks are taken ?
> 
> This lock,
> 
> spin_lock_irqsave(&host->lock, flags);
> 
> seems not fine grained at all .. That lock is just being held over very
> large sections of code which it doesn't seems like it needs to be. It
> doesn't appear to be protecting just the data structures.

Yes, it seems we are using the lock in this function not just for
required host data.

But to solve this circular locking issue, it looks like we don't need
host lock before enqueing the data mover request. I will analyze more
and confirm.

-- 
Thanks,
Sahitya.
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.

