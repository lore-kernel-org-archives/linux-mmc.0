From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 3/3 v2] mmc: Use mmc_delay() instead of mdelay() for time delay
Date: Wed, 31 Aug 2011 23:42:08 -0500
Message-ID: <CBED532F-6456-46FE-A96A-D91264E95966@freescale.com>
References: <1314345310-15041-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:19907 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967Ab1IAEmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2011 00:42:18 -0400
In-Reply-To: <1314345310-15041-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Shengzhou Liu <b36685@freescale.com>, PPC list <linuxppc-dev@lists.ozlabs.org>


On Aug 26, 2011, at 2:55 AM, Chunhe Lan wrote:

> The mmc_delay() is a wrapper function for mdelay() and msleep().
> 
>    o mdelay() -- block the system when busy-waiting.
>    o msleep() -- suspend the currently running task to enable CPU
>                  to process other tasks, so it is non-blocking
>                  regarding the whole system.
> 
> When the desired delay time is more than a period of timer interrupt,
> just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
> CPU when busy wait.
> 
> Signed-off-by: Shengzhou Liu <b36685@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> drivers/mmc/host/sdhci.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)

It might be good to either merge patch 2/3 & 3/3 or rename them since they have same commit message.

Chris,

Any comments on closing on these patches?

- k
