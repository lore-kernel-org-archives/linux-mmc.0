Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FD4CCA483
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349760AbiFOReC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357747AbiFORdW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831E1EAC3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v8so3033360ljj.8
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKNf0k9l6gLrV2AI3VWWdOaW+620gEpiFjUyyJCX0Cs=;
        b=tlKGen7zMe6cWxtE6Iq+6NS/TFHumGCzRMFTXeyJUE8ztpNiY3hvE1iAKl/OlX9X9O
         HzsFVwv9ypNae7Z3mFrO0XyV4Y4pj6Iipdr8THGhJaqduTvEbbXSXByop1C7Mds0rAah
         kGzShX4Mub0mOxuiyIFNvOWa8m4UIpsQUaHfbKJDq5oIQWtC4N7TNdT396lcETQxXcKp
         AYMOlMAHjYjsA7V5u65u9GxDqq5MOFmy9QYT2YywcsjKOAhn1qsjIZZeSbMX0PpZAiZJ
         3rCXRaol3umGZRlUj8Y2dD7Hlpy6sN4xAXyW6YHvQjoJxBHMiFJz6N2vJtT77rr+UL19
         P37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKNf0k9l6gLrV2AI3VWWdOaW+620gEpiFjUyyJCX0Cs=;
        b=n1xFcj9y/OjopBM18jg+Tinv31IceytAft7Zv9J6Wdfph/vipOBVtMbbjLck4rqv5+
         IU39aLdNnVku4n8+Gp33qN0EeMBr64LLuuAW2iya6gup3dIIXKKCG5hHCk4cdo6wiGLl
         K3V1GhR2GG4AGm3K/YdzFmULai0KiUnFa7Jhh+8TcacRLfNvYjK/hNMKi7zAgXvxRsJi
         AusYHj5j2XHqM1nKkXVYLjhdhbIwSToHiRIrgOKw9vjy582eD00P6eIqCXLAwcBKl/Q7
         miNapDTgNJnPoSqZ8XsFbzDcGoerSrhcYaTOjqrjH8YO4u86AKN0y2J0bfppZK4O0nML
         GPXQ==
X-Gm-Message-State: AJIora8n8Sl9BjeYvZA+J2tlIEI0lnnS0becI+gQLDZKOrsiavYeiFNp
        gquKwvkEuGOMkpftoFMFMREseGhOkMWy8HDBYcCN1A==
X-Google-Smtp-Source: AGRyM1tarJ3RmYGZi4Bh/Sn0M/lEpQDAsmJjikNL+iLfDgMeV5j+niJz7+d8G8zHnwmUFIHeOkjT3b9W/eOOBPc6Vxg=
X-Received: by 2002:a2e:808e:0:b0:255:be23:1372 with SMTP id
 i14-20020a2e808e000000b00255be231372mr454884ljg.4.1655314398304; Wed, 15 Jun
 2022 10:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220608130847.46359-1-wangxiang@cdjrlc.com>
In-Reply-To: <20220608130847.46359-1-wangxiang@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:40 -0700
Message-ID: <CAPDyKFobyJS-7j7C0x-FwV6zdqR9gOtpr-HWn8zcLkFd-gMAeg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Fix typo in comment
To:     Xiang wangx <wangxiang@cdjrlc.com>
Cc:     linux@armlinux.org.uk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jun 2022 at 06:12, Xiang wangx <wangxiang@cdjrlc.com> wrote:
>
> Delete the redundant word 'is'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 01159eaf8694..012aa85489d8 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -762,7 +762,7 @@ int mmci_dmae_setup(struct mmci_host *host)
>
>         /*
>          * If only an RX channel is specified, the driver will
> -        * attempt to use it bidirectionally, however if it is
> +        * attempt to use it bidirectionally, however if it
>          * is specified but cannot be located, DMA will be disabled.
>          */
>         if (dmae->rx_channel && !dmae->tx_channel)
> --
> 2.36.1
>
