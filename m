From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] RFT: mmc: block: restore NULL check when retrying
Date: Tue, 31 Jan 2017 12:28:43 +0100
Message-ID: <CAPDyKFpm5AxsnbX-UMGLntB4Z1KK2TzCcCmWFJqYwku-JkOwzw@mail.gmail.com>
References: <20170130132625.18296-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35567 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbdAaL2q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 06:28:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id b65so74630236wmf.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 03:28:45 -0800 (PST)
In-Reply-To: <20170130132625.18296-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On 30 January 2017 at 14:26, Linus Walleij <linus.walleij@linaro.org> wrote:
> When retrying to send a request, we used to have a NULL
> check on the request we try to resend.
>
> It was removed in commit
> c659b878689c ("mmc: block: inline command abortions")
> but maybe that was not such a good idea. Maybe it can
> actually be NULL?
>
> This might be causeing regressions in errorpath behaviour
> seen in kernelci boot tests on the sunxi.
>
> I'm not sure because this state machine has so many
> entrances and exits that I can't wrap my head around it.
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I have applied this for next. Let's see what kernelci reports from the
boot test of the sunxi boards.

If it turns out to be a good fix, I am going to fold this change into
"mmc: block: inline command abortions", but re-writing the changelog
of that a bit.

Please tell me if you don't think this is a good idea.

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index ede759dda395..6c8be1a80551 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1606,6 +1606,9 @@ static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request *req)
>  static void mmc_blk_rw_start_new(struct mmc_queue *mq, struct mmc_card *card,
>                                  struct request *req)
>  {
> +       if (!req)
> +               return;
> +
>         if (mmc_card_removed(card)) {
>                 req->rq_flags |= RQF_QUIET;
>                 blk_end_request_all(req, -EIO);
> --
> 2.9.3
>
