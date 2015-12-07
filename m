From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: fix racy probe cleanup
Date: Mon, 7 Dec 2015 17:10:29 +0100
Message-ID: <CAPDyKFr6qMJAPW7WMXD--Dhy32iJ8iOmfOS2wXCPWFq7B891yA@mail.gmail.com>
References: <E1a5tlb-0000UY-81@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33245 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932416AbbLGQKa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2015 11:10:30 -0500
Received: by ykdv3 with SMTP id v3so199595645ykd.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Dec 2015 08:10:29 -0800 (PST)
In-Reply-To: <E1a5tlb-0000UY-81@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 7 December 2015 at 12:15, Russell King <rmk+kernel@arm.linux.org.uk> wrote:
> MMC probe cleanup is racy: consider the following sequence:
>
> - mmc_alloc_host()
> - mmc_gpio_request_cd()
> - some failure
> - mmc_free_host()
>
> mmc_gpio_request_cd() registers a handler for the card detect GPIO
> signal, and if this is triggered, it can queue the delayed work in

mmc_gpio_request_cd() requests the GPIO, but doesn't request the IRQ.
Instead that's delayed until mmc_add_host() is called.

> struct mmc_host.  mmc_free_host() then frees the mmc_host structure
> with the still queued delayed work, which will then cause the timer
> subsystem to touch free'd memory, potentially oopsing the kernel.

Because of the above, I don't think this can happen..

...unless there are some specific cases when hosts dealing with
registering the GPIO CD irq themselves, is that so?

>
> Fix this by ensuring that the delayed work is properly cancelled
> before freeing the underlying memory.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/core/host.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 5466f25f0281..b246803f2f1d 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -677,6 +677,7 @@ EXPORT_SYMBOL(mmc_remove_host);
>   */
>  void mmc_free_host(struct mmc_host *host)
>  {
> +       cancel_delayed_work_sync(&host->detect);
>         mmc_pwrseq_free(host);
>         put_device(&host->class_dev);
>  }
> --
> 2.1.0
>

Kind regards
Uffe
