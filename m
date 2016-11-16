From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] RFC: mmc: block: replace semaphore with freezing
Date: Wed, 16 Nov 2016 13:19:40 +0100
Message-ID: <2389754.pTXLssq8q3@wuerfel>
References: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:56311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752694AbcKPMTr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 07:19:47 -0500
In-Reply-To: <1479293464-4576-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>

On Wednesday, November 16, 2016 11:51:04 AM CET Linus Walleij wrote:
> @@ -95,12 +95,9 @@ static int mmc_queue_thread(void *d)
>                                 set_current_state(TASK_RUNNING);
>                                 break;
>                         }
> -                       up(&mq->thread_sem);
> -                       schedule();
> -                       down(&mq->thread_sem);
> +                       try_to_freeze();
> 

The schedule() here is where we wait for new requests to come in
from mmc_request_fn(), you can't remove that or you end up spinning
continuously.

	Arnd
