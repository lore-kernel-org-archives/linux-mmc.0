From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/6] mmc: block: Fix error recovery stop cmd timeout calculation
Date: Thu, 25 Sep 2014 10:37:25 +0200
Message-ID: <CAPDyKFpSAvHr1P5Q7WAK_cRsPtYqZy9JVagqcUe0QO2vtOLdow@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:56225 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbaIYIh0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Sep 2014 04:37:26 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so4215144qaq.24
        for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2014 01:37:25 -0700 (PDT)
In-Reply-To: <1411502430-25535-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Data timeout has two components: one in nanoseconds
> and one in clock cycles.  Clock cycles were not being
> added when using the data timeout for the error
> recovery stop cmd timeout.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/card/block.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 5d27997..c3770dd 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -945,9 +945,19 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>          */
>         if (R1_CURRENT_STATE(status) == R1_STATE_DATA ||
>             R1_CURRENT_STATE(status) == R1_STATE_RCV) {
> -               err = send_stop(card,
> -                       DIV_ROUND_UP(brq->data.timeout_ns, 1000000),
> -                       req, gen_err, &stop_status);
> +               unsigned int timeout_ms, clock;
> +
> +               timeout_ms = DIV_ROUND_UP(brq->data.timeout_ns, 1000000);
> +               if (brq->data.timeout_clks) {
> +                       clock = card->host->actual_clock;
> +                       if (!clock)
> +                               clock = card->host->ios.clock;
> +                       if (clock) {
> +                               clock = DIV_ROUND_UP(clock, 1000);
> +                               timeout_ms += brq->data.timeout_clks / clock;
> +                       }

This pieces of code seems like it should be provided from
mmc/core/core.c. Could we maybe even have it close to
mmc_set_data_timeout(), since it somewhat related, and thus export a
new function for it?

Kind regards
Uffe

> +               }
> +               err = send_stop(card, timeout_ms, req, gen_err, &stop_status);
>                 if (err) {
>                         pr_err("%s: error %d sending stop command\n",
>                                req->rq_disk->disk_name, err);
> --
> 1.8.3.2
>
