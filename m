Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB38C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbhLUNDq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238073AbhLUNDp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:45 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC46C061574
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x21so20970446lfa.5
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qR/GFbAQWP29cRyrgKwJq8PjwisWjVet0Dha36hCWQ=;
        b=uYspa3g8B9SsxDs/tLuDv19oblTeaNeb02v3391IOxEDqHhVX4UxlnZRXTlirRx0eT
         +LHlcmsmcSd0NrKaoEuMLdnqZEfbAGbD5E0cLSzHogURrZv43jj5PxiXas9P56g/T6m0
         L6eiuTUK2+5agrHly7tgp1k/8eLJTuVPmiha6ywcvMJVs9gZa5rfoweqVX9ZeTkrBYq0
         W/TZ4jCwhgDB17yyQqnJWkUKQMgSh+8FraLjuQTRsW3agoIiI3CGOZZlnXliQZjQUoWR
         ZmkOWXzrdbGQ7v8WME3agrke5sC1iH/t1O2GWDVTvGqUDtQvswYVKbeXvPii8oJwznxV
         i9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qR/GFbAQWP29cRyrgKwJq8PjwisWjVet0Dha36hCWQ=;
        b=ZU+KgX+hHbzLSK+b2lp3CvjE/jzE3v8CvWqbcsYCDtF7WxiK7cdCChpM96hwtjMfeP
         rK9HgJeTepLH5lPhAHmlIOEBuU6Amy/JLAkGD5gwNG8GWb7DEuVZe3MRS7SEheKrgCPZ
         XPkDc29QWlNhxe+LK/hpXxOTRrbdRUwJ1OTgpVk+Rvm7N59vYo3hf3dN+K8hZ4eVoXwr
         uIzApWdRxdUuiaeD3RsEzxwdu20Epnr1C2fBZpzCerixC/iEYGj2WKLUajp6umM6Y7Ml
         k8daW1WWvkrgujanJ9RjSEwwUfqNzKXlwo8Ab9pZWnXPgT3Viv0pdTwqF9JlZzFbbctf
         P/LQ==
X-Gm-Message-State: AOAM530TEsMSzsKRQU5gGbWgfncPBe6gNbRXl3+IEQn4MPtAyTwZrlpZ
        ec7vZbalSOTkP0erzKr2aDhM/p1T7D/J7X+Y1udnKQ==
X-Google-Smtp-Source: ABdhPJxCR2r6nDI4PVDe3rh8Y73ZbHsuC141WD6b3/NR927XHgDS+fSxwzsHi+NR9IvtQr3eUFW31CxBpDcjclaBphA=
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr2952802lfg.373.1640091823281;
 Tue, 21 Dec 2021 05:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20211217150348.GD16611@kili>
In-Reply-To: <20211217150348.GD16611@kili>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:03:07 +0100
Message-ID: <CAPDyKFrLYFAP6SxVLy8zsr9mpno2g47AetivTEeTOwZXMzKmUA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: clean up a debug message
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Dec 2021 at 16:04, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "0x" prefix is redundant when # flag is used.  It prints "0x0x".
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f2a14a434bef..bec4796283fe 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1307,7 +1307,7 @@ static void dw_mci_set_data_timeout(struct dw_mci *host,
>                 tmout |= (tmp & 0xFFFFFF) << 8;
>
>         mci_writel(host, TMOUT, tmout);
> -       dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> +       dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: %#08x",
>                 timeout_ns, tmout >> 8);
>  }
>
> --
> 2.20.1
>
