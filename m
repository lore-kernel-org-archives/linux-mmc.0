Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BADC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 16:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7755660F39
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhJZQ6H (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhJZQ6E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2021 12:58:04 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB4C061745
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 09:55:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j2so208236lfg.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LP40nYkEbLTRumSDbIOq85aSQOkINlJU3Lvgje0t1Ow=;
        b=CIA7RDXGOVfr6w+wIEX0zTARG/3oUw7hS1nDA65m5j4EqzU2S3uppECIgYtrZ3onB7
         tCjEyCUOL3u34a4MtlqnZjoebRIXxZzeNy4QZeA4EjF0MDXWf04W/2qvfFMhIhU8+cbW
         KWQCsAPRF+u7Khu7QFp6i/hLT5Y62m7+S+ObY9YqB7ZhKy8+sU6lV1YC59dGSzI/Vl3d
         xAH/HOOC8w4PiOk3EnRbI6q5j9u1B4nrRX8Q0Z9Mv/WZ3hpA99jBaNFIbAlF9q9bnP9B
         NOrM63SZQbLdbF/mMpywcsgxhDZAOGkhJuh9GwufQ4gblB0rfFmHY6EAF9o1us5W4vM5
         CVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LP40nYkEbLTRumSDbIOq85aSQOkINlJU3Lvgje0t1Ow=;
        b=bsyEpDGREbL6FelKa05TCksbl50qTQIL0u3571ZmKeifJiXunpVRVQ9AIlHQ0Dyztr
         MkmgrbsiV/QMlxYTT7jXiwUzA/BKSs5Pa0/G2X6OrcpA51C5vedOQri9xX1KbYrlcumH
         n1XE0qh+OP+kI1BTppUt4qxJTl7rdPYmzqt36Uk/gKvVCQWGZCCU1yhqs17ouZRSgCcQ
         KunHLlqcZgcJHqd3l0bsM9f3iIGR6McG8/lOu+SsxezkMkjqFWVeFeuAU+yNDaV5SBU5
         RnnbWtFLRRRMqWcy9k5tNb/w2O655n7aVvbPuxPvsCflSYEaNjOIuDNC772o65WxPX3Q
         jYSw==
X-Gm-Message-State: AOAM532V954E1vg0t4ZABFa+n2gYAAkIgT1QzoxiHpni5l74N8QyESf1
        dHCWB3CSN3KLHK2bssMAClLFu2buZz1ZM/mk1owoMQ==
X-Google-Smtp-Source: ABdhPJw2cxUH8C9WC0nTDyk7WK/wvxQOywxtnc0blf51/N4iPjOxCOzuIu/Tm5j+Xzz4tYrbsQOVE+HZ5M4xLCGvrMw=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr24435501lfb.71.1635267338322;
 Tue, 26 Oct 2021 09:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20211022063928epcas1p28a32be208929f9905c80e655736b7a7d@epcas1p2.samsung.com>
 <20211022063920.2145-1-huijin.park@samsung.com>
In-Reply-To: <20211022063920.2145-1-huijin.park@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 18:55:01 +0200
Message-ID: <CAPDyKFo0FZ04dO-sJwL+Nvs-7JY22+y03VYRCmi80TpwdizxGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: adjust polling interval for CMD1
To:     Huijin Park <huijin.park@samsung.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <bbanghj.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Oct 2021 at 08:39, Huijin Park <huijin.park@samsung.com> wrote:
>
> In mmc_send_op_cond(), loops are continuously performed at the same
> interval of 10 ms.  However the behaviour is not good for some eMMC
> which can be out from a busy state earlier than 10 ms if normal.
>
> Therefore, this patch adjusts the waiting interval time. The interval
> time starts at 1 ms, but doubles until the range reaches 10 ms for
> each loop.
>
> The reason for adjusting the interval time is that it is important
> to reduce the eMMC initialization time, especially in devices that
> use eMMC as rootfs.
>
> Test log(eMMC:KLM8G1GETF-B041):
>
> before: 12 ms (0.439407 - 0.427186)
> [0.419407] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [0.422652] mmc0: starting CMD1 arg 00000000 flags 000000e1
> [0.424270] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [0.427186] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
> [0.439407] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
> [0.439721] mmc0: starting CMD2 arg 00000000 flags 00000007
>
> after: 4 ms (0.431725 - 0.427352)
> [0.419575] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [0.422819] mmc0: starting CMD1 arg 00000000 flags 000000e1
> [0.424435] mmc0: starting CMD0 arg 00000000 flags 000000c0
> [0.427352] mmc0: starting CMD1 arg 40000080 flags 000000e1<-start
> [0.428913] mmc0: starting CMD1 arg 40000080 flags 000000e1
> [0.431725] mmc0: starting CMD1 arg 40000080 flags 000000e1<-finish
> [0.432038] mmc0: starting CMD2 arg 00000000 flags 00000007
>
> Signed-off-by: Huijin Park <huijin.park@samsung.com>
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 0c54858e89c0..61b4ffdc89ce 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -177,6 +177,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  {
>         struct mmc_command cmd = {};
>         int i, err = 0;
> +       int interval = 1, interval_max = 10;
>
>         cmd.opcode = MMC_SEND_OP_COND;
>         cmd.arg = mmc_host_is_spi(host) ? 0 : ocr;
> @@ -198,7 +199,9 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>
>                 err = -ETIMEDOUT;
>
> -               mmc_delay(10);
> +               mmc_delay(interval);
> +               if (interval < interval_max)
> +                       interval = min(interval * 2, interval_max);

It looks like we should be able to replace the above polling loop with
__mmc_poll_for_busy(). We would need a callback function and a
callback data, specific for CMD1, but that looks far better to me, if
we can get that to work.

Would you mind having a look?

>
>                 /*
>                  * According to eMMC specification v5.1 section 6.4.3, we

Kind regards
Uffe
