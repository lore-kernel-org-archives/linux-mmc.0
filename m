Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FBDC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhLUNDj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbhLUNDi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:38 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378CEC061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z8so21277830ljz.9
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg/+YbNmnCRLvJQl5zgsP/kvT/R8Y/LG6eop4ZJ5kFg=;
        b=wEKmzVyqX4fogXHuKl1kZVPbOJB+KXJ0rp/lZ0OcKlMA2yB0PM7CD2nXS4wq+I0N00
         2ahwnlR+nLKqfwSvof+QkbS82AhfkSwfN8s3nnfQp6D9ulVfDEZLM99ETlEnvIm8QU0W
         i0hWxmmYJ7ziRb0qTvly6vT41YzoJjlDFlHvcVYPCi3BfYWuxwHSM1Art+hMCk9ydDoB
         Df8xA8MIstpnHe7E75hocjh436kvHlv9VtaAQgDgHhwjYe059T6iGaxeC/oiH/DOr9o2
         KpTRd2cqmmZ2xB9e8RQntkBVGN1/5IMKhLuX4yug85kyJxeDZk1IENlChYQ6jN+NoiXJ
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg/+YbNmnCRLvJQl5zgsP/kvT/R8Y/LG6eop4ZJ5kFg=;
        b=4/wkpGz0FQEOdj5ZEmCf93II/w4MwQxwf0qqi5uWpzH8ixGH7X6UL+E/xZ5QUp21S4
         qBbVQK/1kSWjR1Mo9kqrGqKSn0j0AhkE+Un5rQv9PUeOzDMaDIWtAKUqRHpC8z5UqI1X
         ppXfypnlun493jMz1dR/XDbxJhDxNiJ6JL4khTBsR5diHXrO89RL7uv1BPEpWd4XSNfX
         igiu/i6QED2RHSfxhUAOsr0c9VGUZDoVsYMpAvs4kOedvxFVQNLMbky6DpmwtZLSb8Ov
         aQPzSmmLkrixEk/oDYcD6qKWBP91kvDnuYk0IkhZHEpqV/Ahau//atFinOteJR5QHEOh
         shhA==
X-Gm-Message-State: AOAM532X3FGPypBZ1HsPA66XLdXiFl2ddFcEajlA/CFm1QakYPWPoQhI
        OzAZUlTbkneAyp137lQDEb8zbQvbVtGKHGbEkD31Kt9eLdc=
X-Google-Smtp-Source: ABdhPJzQ9aEfXhZCcRlIkSlDjbGVACLwWgp6kfc1uq4FyOMyJdDQUz4JUU0KDLkcttu0+pLxlQq0GaK3eB5MuBUrg2k=
X-Received: by 2002:a2e:9915:: with SMTP id v21mr2437966lji.273.1640091816235;
 Tue, 21 Dec 2021 05:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20211215011336.194089-1-joel@jms.id.au>
In-Reply-To: <20211215011336.194089-1-joel@jms.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:59 +0100
Message-ID: <CAPDyKFoZ3Btj562pNDEzPL4icBD-wZ+9ykxCVceJ5FJm6ao41A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix blk_status_t handling
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Dec 2021 at 02:13, Joel Stanley <joel@jms.id.au> wrote:
>
> Sparse spits out this following warning:
>
> drivers/mmc/core/queue.c:311:21: warning: incorrect type in assignment (different base types)
> drivers/mmc/core/queue.c:311:21:    expected int ret
> drivers/mmc/core/queue.c:311:21:    got restricted blk_status_t [usertype]
> drivers/mmc/core/queue.c:314:21: warning: incorrect type in assignment (different base types)
> drivers/mmc/core/queue.c:314:21:    expected int ret
> drivers/mmc/core/queue.c:314:21:    got restricted blk_status_t [usertype]
> drivers/mmc/core/queue.c:336:16: warning: incorrect type in return expression (different base types)
> drivers/mmc/core/queue.c:336:16:    expected restricted blk_status_t
> drivers/mmc/core/queue.c:336:16:    got int [assigned] ret
>
> ret is only used for blk_status_t types, so make it that type.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b15c034b42fb..c69b2d9df6f1 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -234,7 +234,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>         enum mmc_issue_type issue_type;
>         enum mmc_issued issued;
>         bool get_card, cqe_retune_ok;
> -       int ret;
> +       blk_status_t ret;
>
>         if (mmc_card_removed(mq->card)) {
>                 req->rq_flags |= RQF_QUIET;
> --
> 2.34.1
>
