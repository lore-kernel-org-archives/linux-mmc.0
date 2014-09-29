From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6] mmc: Fix incorrect warning when setting 0 Hz via debugfs
Date: Mon, 29 Sep 2014 11:44:32 +0200
Message-ID: <CAPDyKFrwKAKYtgNdKFBB2y4Uo9L0h6EShWG9BaaY4pfkXo5PTQ@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:49508 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaI2Jod (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 05:44:33 -0400
Received: by mail-qg0-f49.google.com with SMTP id q107so11647717qgd.22
        for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2014 02:44:32 -0700 (PDT)
In-Reply-To: <1411502430-25535-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> It is possible to turn off the card clock by setting
> the frequency to zero via debugfs e.g.
>
>         echo 0 > /sys/kernel/debug/mmc0/clock
>
> However that produces an incorrect warning that is
> designed to warn if the frequency is below the minimum
> operating frequency.  So correct the warning.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index e2e1dd4..16aa7bd 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -995,7 +995,7 @@ void mmc_set_chip_select(struct mmc_host *host, int mode)
>   */
>  static void __mmc_set_clock(struct mmc_host *host, unsigned int hz)
>  {
> -       WARN_ON(hz < host->f_min);
> +       WARN_ON(hz && hz < host->f_min);
>
>         if (hz > host->f_max)
>                 hz = host->f_max;
> --
> 1.8.3.2
>
