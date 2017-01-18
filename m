From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 0/3] Auto BKOPS PM suspend
Date: Wed, 18 Jan 2017 09:53:50 +0800
Message-ID: <30196abc-e340-2b7f-0ad2-d644a0d78b49@rock-chips.com>
References: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:33779 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdARCGG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2017 21:06:06 -0500
In-Reply-To: <1484655337-32562-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, chris@printf.net, alex.lemberg@sandisk.com

Hi Uri,

On 2017/1/17 20:15, Uri Yanai wrote:
> Hi Ulf
> Resubmitting three patches for approval, originally submitted by Alex Lemberg <alex.lemberg@sandisk.com>
> [1/3] mmc: replacing hardcoded value for runtime PM suspend  		Message ID:<1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
> [2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support		Message ID:<1472739890-3384-3-git-send-email-alex.lemberg@sandisk.com>
> [3/3] mmc: Checking BKOPS status prior to Suspend 			Message ID:<1472739890-3384-4-git-send-email-alex.lemberg@sandisk.com>
>
> Thanks
> Uri Yanai

Firstly, the authorship isn't correct and of course the SOB path.
Then, it'd better to add a changelog since you do improve Alex's
patches, and it would help us to better understand what was changed. :)

Also you should remove Change-Id when fetching patches from your
internal code review system.

Anyway, let's talk about the patches themself, I have
a question for your patch 3/3 there.


>
> Uri Yanai (3):
>   mmc: replacing hardcoded value for runtime PM suspend
>   mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
>   mmc: Checking BKOPS status prior to Suspend
>
>  drivers/mmc/core/block.c |  3 ++-
>  drivers/mmc/core/mmc.c   | 45 ++++++++++++++++++++++++++++++++++++---------
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/host.h |  2 ++
>  include/linux/mmc/mmc.h  |  3 +++
>  5 files changed, 44 insertions(+), 10 deletions(-)
>


-- 
Best Regards
Shawn Lin

