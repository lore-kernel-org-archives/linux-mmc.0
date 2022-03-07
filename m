Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C4EC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Mar 2022 12:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbiCGMS7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiCGMSz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2022 07:18:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3693EB82
        for <linux-mmc@vger.kernel.org>; Mon,  7 Mar 2022 04:18:01 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id w27so25851155lfa.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2022 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DH+oocjZoheS2ppzlV3GMLdC/wnkrMQ+M6DhJ2OkEzo=;
        b=g708jxdHQUWcHu5206IcwS0xblL+SDdIq9n4R9CDqFeF5xNyeTcEOUcAqUVvzZDz8V
         hQn+nU+0TDuRJLO8SuFKWAJ+9W0CE8OPVyPeDvyG6SJISgOoEwburixXTLjO635V9Xl6
         eb6vEZ2sOM+IMYzzk65k+um889M6lSU+PdFr5zBazLPAiaWCBfJOHDI1el+dl8DtqFti
         HbpqegtfT0Zi9oKXVlX/XPgr0WUans98HRzlt836rH+FoCRKnF4RUK82+xTHJsq3QpnE
         hY7rL4SEc2ZEEr4fTMmSEyyYjnWLgSB/c0F2zPhxewUkASzctE4WEcfQDsD8dewD605S
         AO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DH+oocjZoheS2ppzlV3GMLdC/wnkrMQ+M6DhJ2OkEzo=;
        b=r/I7I3kuVFQGajGkqwM1/hmVkfPusALjQabUgfYsfw4DS4680Sqy5CouJHC8p8zWiD
         wEqwgbUV0CMeAhKboh3kr6uSK57iTd+8FfnfH4e6CvcaBTzU1qXFakug4kTNG35cnSA4
         wFIuj3zKp8zYJm89fD3MGvRgfVCAC5e8dfQd4Vj/W6+f10JDA0OXnhpZGpwm7xpDFOWF
         3dWkzxCgR6XlGV6giLfE7GoRvUg7+YVcYkrnmd8a7/a3kO5stvnJSCZTnerEW+tXmyER
         W7F2uwALZZU+Dilg5RXUr1/lh+D2MRYlOSv0yiiDGoxW9NnzygiGpL3DAjudHZywkHo1
         ZjEQ==
X-Gm-Message-State: AOAM532Y5Po08p+WnlFYjVToTzAAgvK8EgzRE7mhSk2Sl1V5XiBgSxOT
        NyG0302yMF6lNkbtrZDD7pYk9+xOOiTJEykT0Q/EhA==
X-Google-Smtp-Source: ABdhPJwbfy+LHJAnH3WR3mpkDHlEFZcuNi7GqXx9Xn7uVcgj3VU5VVdqiFlAV+K811utx5kneHGx2bTp2eJ1bDPK9e8=
X-Received: by 2002:a05:6512:260b:b0:445:c54c:4157 with SMTP id
 bt11-20020a056512260b00b00445c54c4157mr7377045lfb.254.1646655478490; Mon, 07
 Mar 2022 04:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20220305215835.2210388-1-pgwipeout@gmail.com> <20220305215835.2210388-2-pgwipeout@gmail.com>
In-Reply-To: <20220305215835.2210388-2-pgwipeout@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Mar 2022 13:17:22 +0100
Message-ID: <CAPDyKFpE-oSa1+rORK12X5uZLV4147hOiVZPG=j15b4QCU3muw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: host: dw_mmc: support setting f_min from host drivers
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>, robin.murphy@arm.com,
        linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 5 Mar 2022 at 22:58, Peter Geis <pgwipeout@gmail.com> wrote:
>
> Host drivers may not be able to support frequencies as low as dw-mmc
> supports. Unfortunately f_min isn't available when the drv_data->init
> function is called, as the mmc_host struct hasn't been set up yet.
>
> Support the host drivers saving the requested minimum frequency, so we
> can later set f_min when it is available.
>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++++++-
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 42bf8a2287ba..0d90d0201759 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2898,7 +2898,12 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
>         if (host->pdata->caps2)
>                 mmc->caps2 = host->pdata->caps2;
>
> -       mmc->f_min = DW_MCI_FREQ_MIN;
> +       /* if host has set a minimum_freq, we should respect it */
> +       if (host->minimum_speed)
> +               mmc->f_min = host->minimum_speed;
> +       else
> +               mmc->f_min = DW_MCI_FREQ_MIN;
> +
>         if (!mmc->f_max)
>                 mmc->f_max = DW_MCI_FREQ_MAX;
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 7f1e38621d13..4ed81f94f7ca 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -99,6 +99,7 @@ struct dw_mci_dma_slave {
>   * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
>   *     rate and timeout calculations.
>   * @current_speed: Configured rate of the controller.
> + * @minimum_speed: Stored minimum rate of the controller.
>   * @fifoth_val: The value of FIFOTH register.
>   * @verid: Denote Version ID.
>   * @dev: Device associated with the MMC controller.
> @@ -201,6 +202,7 @@ struct dw_mci {
>
>         u32                     bus_hz;
>         u32                     current_speed;
> +       u32                     minimum_speed;
>         u32                     fifoth_val;
>         u16                     verid;
>         struct device           *dev;
> --
> 2.25.1
>
