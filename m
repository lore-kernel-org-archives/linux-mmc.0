From: Philip Rakity <prakity@nvidia.com>
Subject: Re: [PATCH 0/8] sdhci: Move real work out of an atomic context
Date: Tue, 9 Jul 2013 17:52:55 +0200
Message-ID: <D49C0E13-CD9B-451A-8CFB-B28404AA6A8E@nvidia.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:16018 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3GIPxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2013 11:53:01 -0400
In-Reply-To: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "matthieu.castet@parrot.com" <matthieu.castet@parrot.com>, "gregor.boirie@parrot.com" <gregor.boirie@parrot.com>


On Jul 9, 2013, at 4:44 PM, Jeremie Samuel <jeremie.samuel.ext@parrot.com> wrote:

> Hi all,
> 
> Currently the sdhci driver does everything in the atomic context.
> And what is worse, PIO transfers are made from the IRQ handler.
> 
> Some patches were already submitted to solve this issue. But there were
> rejected because they involved new issues.
> 
> This set of patches is an evolution of an old patch from Anton Vorontsov.
> I tried to fix all the problems involved by the patches. I tested it for
> several time now with SD cards and SDIO.
> 
> So, this patch set reworks sdhci code to avoid atomic context,
> almost completely.
> 
> Thanks,
> 

Running DDR50, SDR104 or HS200 what is the performance impact ?


> Jeremie Samuel
> 
> Jeremie Samuel (8):
>  sdhci: Turn timeout timer into delayed work
>  sdhci: Turn tuning timeout timer into delayed work
>  sdhci: Use work structs instead of tasklets
>  sdhci: Use threaded IRQ handler
>  sdhci: Delay led blinking
>  sdhci: Turn host->lock into a mutex
>  sdhci: Get rid of mdelay()s where it is safe and makes sense
>  sdhci: Use jiffies instead of a timeout counter
> 
> drivers/mmc/host/sdhci.c  |  327 ++++++++++++++++++++++-----------------------
> include/linux/mmc/sdhci.h |   13 +-
> 2 files changed, 168 insertions(+), 172 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

