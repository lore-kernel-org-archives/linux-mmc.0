From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: undefined reference to `mmc_pm_notify' when selected MMC without
 PM.
Date: Fri, 13 Aug 2010 20:33:40 +0900
Message-ID: <009801cb3adb$6550e400$2ff2ac00$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31031 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042Ab0HMLdg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2010 07:33:36 -0400
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Kukjin Kim' <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ben-linux@fluff.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Maxim Levitsky' <maximlevitsky@gmail.com>

Kukjin Kim wrote:
> 
> Hi,
> 
> Following is build error when selected MMC without PM.
> 
> drivers/built-in.o: In function `mmc_alloc_host':
> drivers/mmc/core/host.c:108: undefined reference to `mmc_pm_notify'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make: *** [sub-make] Error 2
> 
> That is added from Maxim's ' mmc: fix all hangs related to mmc/sd card
> insert/removal during suspend/resume '
> (commit ID: 4c2ef25fe0b847d2ae818f74758ddb0be1c27d8e)
> 
> Below is temporary patch for avoiding build error.
> But I'm not sure about this... :-(
> 
> ---
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 0efe631..d80cfdc 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -86,7 +86,9 @@ struct mmc_host *mmc_alloc_host(int extra, struct device
> *dev)
>         init_waitqueue_head(&host->wq);
>         INIT_DELAYED_WORK(&host->detect, mmc_rescan);
>         INIT_DELAYED_WORK_DEFERRABLE(&host->disable,
> mmc_host_deeper_disable);
> +#ifdef CONFIG_PM
>         host->pm_notify.notifier_call = mmc_pm_notify;
> +#endif
> 
>         /*
>          * By default, hosts do not support SGIO or large requests.
> 
> ---

Kindly ignore this stuff because I found Uwe's same patch just now ;-)
Sorry for bothering.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

