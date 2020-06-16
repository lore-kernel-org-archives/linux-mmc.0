Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D979BC433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B796320B80
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUYZE6Ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgFPLdP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgFPLdM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:12 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A99C08C5C2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:10 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id y23so1623771vkd.13
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGK4YbhCcwirb0SVPCE+lFgJzM9gI3w/a7Njq3MvGOM=;
        b=iUYZE6Ijc6WacIvt9ZuRdg7PWXdzmLnFzOx6tDATh5LsyftfqAIaOqVzK8ZvQSccDv
         +M/h0lJdFifa8aPECvrC14s0tSjKcPBej/+LK4vzMSspSA6cz3hbpvMQAlWvjji8NfMX
         4Sfy4RX33xH8TNb2zZ5tTqp/qSY/bnRqxP668LuNqVz9MjlU4E7nGW6NVW5M9/a2LG7N
         tUp6oEI53+t9qQU/NmResf+EuwbcAFdJprdJrfGo0jkPDTcfwYXgKJH+GINXEeY99M94
         s2t4gv6SlTCpxJzhOH46K9Td84u3P8ogUEPIHa/eBES8QaqZCsMyjzz+DiuegOT1hD6s
         ggaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGK4YbhCcwirb0SVPCE+lFgJzM9gI3w/a7Njq3MvGOM=;
        b=H0+YDYeFqWP2KV5EUCY3mXv8h7hXlCrOxQ8jPtD/kie6GQZZFhio7iBSI8mHAtiplT
         ywkpjzVJ3vjSono+7sguljJWZWJEYjiF91FmWAGJYEiqH23a4a84OqfjtvSYZMfLuv3E
         zNWq0zNIKC1/7XytfhBSxdLvVXz5Cg5hb1AfTf8IXtGrS2OOcHEgw/9FkiVFpLkSmrk5
         R7VfBoxr5MJmQSIJb8hN6KBoQVa1gWT4dyH072GqMfIRCm0GRPXagv8BJsDaI0e419Tm
         UR2eLq5/LPpDluKA27B1iNoINGdMHcokcC/qpnu2lDWy8VYgJCo+F3FPUokxVuvLUga6
         0Isg==
X-Gm-Message-State: AOAM53325VlfAIrvzCRIkMvxUG8m/LrAL+MknafOT6F3nNPPFffn9spk
        LB43yrLKnwVgzFjdFCSiLS7vaIAG/EdejtSUpXUDyw==
X-Google-Smtp-Source: ABdhPJwUYh4G25X8uNlyJV1JSiV/4TO05WKTdEB/kI9t/hbTUt46H5QKVf9ZIf+q00IIYmJ6Rwm9ORXK40d0MeOZDmo=
X-Received: by 2002:a1f:5e51:: with SMTP id s78mr1151790vkb.59.1592307190187;
 Tue, 16 Jun 2020 04:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200604100102.13572-1-zbestahu@gmail.com>
In-Reply-To: <20200604100102.13572-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:32 +0200
Message-ID: <CAPDyKFq6bGtBm94f_5G1_p2LW40hLet_kMtPbpX9BfxNsLfhuQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: Return ret if sdio_disable_func() fails
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        huyue2@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Jun 2020 at 12:01, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We should return any possible error returned by mmc_io_rw_direct()
> rather than only -EIO in sdio_disable_func() failure path.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 2ba00ac..cba54df 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -133,7 +133,7 @@ int sdio_disable_func(struct sdio_func *func)
>
>  err:
>         pr_debug("SDIO: Failed to disable device %s\n", sdio_func_id(func));
> -       return -EIO;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(sdio_disable_func);
>
> --
> 1.9.1
>
