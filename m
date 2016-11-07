From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc_test: Fix "Commands during non-blocking write" tests
Date: Mon, 7 Nov 2016 13:43:35 +0100
Message-ID: <CAPDyKFrgDE4=_x+s4ShAWmA5i2o3fhOH4O6ekprBxvFykqFu+Q@mail.gmail.com>
References: <1478259665-13406-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38632 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbcKGQvf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 11:51:35 -0500
Received: by mail-wm0-f49.google.com with SMTP id f82so130489217wmf.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 08:51:34 -0800 (PST)
In-Reply-To: <1478259665-13406-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

On 4 November 2016 at 12:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> mmc_test_check_result_async() requires that struct mmc_async_req is
> contained within struct mmc_test_async_req. Fix the "Commands during
> non-blocking write" tests so that is the case.
>
> Fixes: 4bbb9aac9a9a ("mmc: mmc_test: Add tests for sending commands during transfer")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/card/mmc_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 5a8dc5a76e0d..3678220964fe 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2347,7 +2347,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
>         struct mmc_test_req *rq = mmc_test_req_alloc();
>         struct mmc_host *host = test->card->host;
>         struct mmc_test_area *t = &test->area;
> -       struct mmc_async_req areq;
> +       struct mmc_test_async_req test_areq = { .test = test };
>         struct mmc_request *mrq;
>         unsigned long timeout;
>         bool expired = false;
> @@ -2363,8 +2363,8 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
>                 mrq->sbc = &rq->sbc;
>         mrq->cap_cmd_during_tfr = true;
>
> -       areq.mrq = mrq;
> -       areq.err_check = mmc_test_check_result_async;
> +       test_areq.areq.mrq = mrq;
> +       test_areq.areq.err_check = mmc_test_check_result_async;
>
>         mmc_test_prepare_mrq(test, mrq, t->sg, t->sg_len, dev_addr, t->blocks,
>                              512, write);
> @@ -2378,7 +2378,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
>
>         /* Start ongoing data request */
>         if (use_areq) {
> -               mmc_start_req(host, &areq, &ret);
> +               mmc_start_req(host, &test_areq.areq, &ret);
>                 if (ret)
>                         goto out_free;
>         } else {
> --
> 1.9.1
>
