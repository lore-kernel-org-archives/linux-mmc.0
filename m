From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 0/2] mmc: Minimize resume time for sd/mmc
Date: Tue, 3 Jan 2012 16:24:34 +0100
Message-ID: <4F031DB2.7010808@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:41979 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753650Ab2ACPYy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2012 10:24:54 -0500
In-Reply-To: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, vitalywool@gmail.com

Hi Chris,

I have received some great comments some Vitaly Wool around the patch 2
"mmc: Minimize resume-time by deferring resume".

It would be interesting to hear if you or someone else has any thinking 
around these patches. Vitaly were mainly thinking of a pm_qos approach, 
which still is a bit unclear to me how to implement.

Any suggestion would be great! :-)

Regarding patch 1:
mmc: block: Remove use of mmc_blk_set_blksize
This patch could be discussed separately without patch 2. Do you want me 
to push this patch on it's own?


BR
Ulf Hansson



Ulf HANSSON wrote:
> Typically an sd/mmc card takes around 200 - 1100 ms to
> initialize when the power to the card has been cut, which
> is what happens during a suspend/resume sequence.
> 
> All device's resume time adds up to the total kernel resume
> time. Some use cases requires the kernel to be resumed fast,
> to be able to meet deadlines. One use case example is WLAN
> SOFT_AP, but there are certainly more.
> 
> This patch serie deferres the resume for mmc/sd cards into
> a delayed work to be able to respond quickly on the suspend
> request. Earlier the blkdev were issuing a set_blksize as a
> part of the blkdev resume, which right now is removed since
> it is not needed. In future, if other block sizes than 512
> bytes is used, this needs to be re-implemented in a different
> manner.
> 
> A deferred resume feature has been discussed on the mmc-list
> previously but did not end up in a final patch/solution.
> 
> Ulf Hansson (2):
>   mmc: block: Remove use of mmc_blk_set_blksize
>   mmc: Minimize resume-time by deferring resume
> 
>  drivers/mmc/card/block.c |   35 +++++++++--------------------------
>  drivers/mmc/core/core.c  |   36 +++++++++++++++++++++++++++++++++++-
>  drivers/mmc/core/core.h  |    1 +
>  drivers/mmc/core/host.c  |    1 +
>  include/linux/mmc/host.h |   16 ++++++++++++++++
>  5 files changed, 62 insertions(+), 27 deletions(-)
> 

