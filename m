From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH 1/2] Revert "mmc: core: wait while adding MMC host to
 ensure root mounts successfully"
Date: Thu, 04 Apr 2013 17:52:41 +0400
Message-ID: <1365083561.9806.43.camel@host5.omatika.ru>
References: <1365082866-28404-1-git-send-email-adrian.hunter@intel.com>
	 <1365082866-28404-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:55443 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761042Ab3DDNwq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 09:52:46 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so2731650lbi.37
        for <linux-mmc@vger.kernel.org>; Thu, 04 Apr 2013 06:52:45 -0700 (PDT)
In-Reply-To: <1365082866-28404-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Namjae Jeon <linkinjeon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Thu, 2013-04-04 at 16:41 +0300, Adrian Hunter wrote:
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index ad7decc..3bf1c46 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2418,7 +2418,6 @@ void mmc_start_host(struct mmc_host *host)
>  	host->rescan_disable = 0;
>  	mmc_power_up(host);
>  	mmc_detect_change(host, 0);
> -	mmc_flush_scheduled_work();
>  }
>  
>  void mmc_stop_host(struct mmc_host *host)

Without some kind of synchronization between end of card probing and
start of root mounting, it is not safe to have root on an mmc card.

In other words, 'root_wait' will be mandatory to ensure successful mount
of root filesystem on an mmc card. It may be worth documenting
somewhere.

It is not a big deal. I could live with a patched kernel or pass the
parameter in the systems I work with. However, other people will fall in
this trap later, and it would be nice to let them know what to do.

