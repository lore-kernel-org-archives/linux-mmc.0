Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 15:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiBQPkl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:40:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbiBQPkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:40:41 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7592B2E3A
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bx31so89978ljb.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtHuVZsN9dq8Ef87/aHczhTpVzC+pvWaYD+ZfU02gIo=;
        b=DI03Q5WXZVS9ul6CojxIkkW4nz0ZO8uejIIb6VmNzipMI4NSLJuTUuNVVF8WnOFPAk
         ETS6C8BnZIusFEeLd24/3GcTkvUN/KMupJrzeOYeA7tKvdIomQivWL/B3zy0zY/tPlWx
         qZd8OE4OY3XIcUeT56fXQg7Hw3ayHOmVCKvDHuwxw4crgO4MVGVUQrERnwTHeExrETVI
         5SmD7k91ENizvCB6TkQp/RzxY1OH9FxQ24PYKDpYCZa7+veM6B71vzU3wVeuJytFMcjb
         NcYwsjepH5AqvNSOFhYwssoKWSW7LOjr9PgcAHHYaWL9iU46/fTADC/Xvtya3WEZDAsS
         +HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtHuVZsN9dq8Ef87/aHczhTpVzC+pvWaYD+ZfU02gIo=;
        b=YWhHPtn3IMSKRNSaGc3SkScE9PPUkiA5IU4UId+VnnE/u0cGZ/PjBnEQoneYGi9EdE
         6l873Ihk/SuWJpKcGsCxZHL/M7LLl9g2tgmYVoUJv9h0qSWr+oKsFyTFrd2AOs7219Si
         7ILb3MS8ZraBUqSgkc0WFEiYmH332jf2dmhlNx1I7ZleZ9X/T5REmIQZP94eS8mFO7yH
         8jBs9uK2kc0cZt5HM4mX7i8jAoBzP4vjT63pPBkfjNkpI/hfbfB548XZ8VLJhOg+s3kR
         MTOh/tHJnygEtjZN1OZw7scKizsIMQBgdr4h+0eqK+VRpWXmtpA3KwH6W4T11JhrFwQg
         oTRw==
X-Gm-Message-State: AOAM532SUw8vskphZ1Eyp3ARINoQEbKFo8qrZaEHeOPz9N0lRXaecBYi
        UGwFyQoggnY8kQw10vEaIWJ9hcMvdNFy4ec5Ilo5a64fUmk=
X-Google-Smtp-Source: ABdhPJzS1HsQQFljNPEfdzoowpGZXeJXTbt7Iuq1OuK3MM2rhphn87bPRKA7/KY2OrtWgxD7W1s9ZurapEW2QYPSaeM=
X-Received: by 2002:a05:651c:c7:b0:244:f9d7:7c48 with SMTP id
 7-20020a05651c00c700b00244f9d77c48mr2735695ljr.300.1645112424989; Thu, 17 Feb
 2022 07:40:24 -0800 (PST)
MIME-Version: 1.0
References: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1644395927-4138-1-git-send-email-wangqing@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:48 +0100
Message-ID: <CAPDyKFqg5N1tCqQ2u2jt5qU0qLuDJRSJRtq_aMVDc7XNDbRvkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: use div64_u64() instead of do_div()
To:     Qing Wang <wangqing@vivo.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 9 Feb 2022 at 09:39, Qing Wang <wangqing@vivo.com> wrote:
>
> From: Wang Qing <wangqing@vivo.com>
>
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
>
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 65037e1..777c9a8
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -766,7 +766,7 @@ static u64 msdc_timeout_cal(struct msdc_host *host, u64 ns, u64 clks)
>                 clk_ns  = 1000000000ULL;
>                 do_div(clk_ns, mmc->actual_clock);
>                 timeout = ns + clk_ns - 1;
> -               do_div(timeout, clk_ns);
> +               div64_u64(timeout, clk_ns);
>                 timeout += clks;
>                 /* in 1048576 sclk cycle unit */
>                 timeout = DIV_ROUND_UP(timeout, BIT(20));
> --
> 2.7.4
>
