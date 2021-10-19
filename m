Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB723C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 10:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D2261154
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 10:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhJSKp0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbhJSKpY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2021 06:45:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21501C061745
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 03:43:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o26so5335153ljj.2
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i/b/YZSKNuUJ2xKiLl2T6Ik48leNz994lleo14luhkQ=;
        b=vaE+gM4ogGjWES/SHtVx88HSgWQAXaslPk6AJvQ2vfs+VMYC7IqSEOQeJU2ck6luGe
         +C5abktFnPouMpw3nGapEH37IdHKK530X5X2hqxa6C1lGMDJg1Niub0Kxsvrvn3E0Oy4
         0LI+Sb2sYbJCVQYWlSj3uG3l6I4uQ98sXAFIHKu4RcpYjUeU3bi8htoUyDQhtua0iWJk
         scD1NZ4QGI+6qWy4WnP11o7IE4FrYemZ2ZBwObB5lnQr88UiCpceriRTn3z7Q1ZzLUa6
         t+tdblwIKltLWk2Ac/EembU6Mig4S5x4yPq5DpmeoaPgy87bbaPeTjTPnbQUfPejJmku
         M+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i/b/YZSKNuUJ2xKiLl2T6Ik48leNz994lleo14luhkQ=;
        b=6ysKES09hRHLTN9HqIQfHyWfPLhnJK3T05bpn8MewhvWvw0dUakZ58+SZr4aqDXsCJ
         qp3kgZfVYnAWadHXiBbzliO0DrQW2Q3K+Ri6SkaVHaiWxi4fMVaUEYFza1mtkagZ80pD
         3GZDFkmKhAaNZDyYoQiWg+o0mMxgDeTbDDGzEDhvlsVbvNqrW3tnSxLfMG+FhywLRMA9
         bOhZkl9FDKDOyG7PtHmzy0ahMGOkNA1OP5jtd7hN8HKdaNuyFNEbeUsMaGDGzBOoRqtU
         J9fA+TL6O58tMbBsK5TrgW7oZ3kgK3YppEa7+KC6F1QJ5argedpJ0VQAx4cA0sAnbZge
         /hvQ==
X-Gm-Message-State: AOAM531rjsOtNmiTBFv0Rh89AduPpXsbETBEDi3B3OHBK16mK5M+CD5s
        uDdWp+LBjLcuen8cazajou+bR4icFXtdZ3+BBdsKEsj1Wtc=
X-Google-Smtp-Source: ABdhPJzM9M7omIxr24XkH4sfWDyxD92tmWR//t3hGn62ModYoEb3B5aedVggmpJsiwR826wfeTvFUpyC/9nHort98Cw=
X-Received: by 2002:a2e:b550:: with SMTP id a16mr553525ljn.229.1634640190414;
 Tue, 19 Oct 2021 03:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211006171605.6861-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20211006171605.6861-1-biju.das.jz@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 12:42:34 +0200
Message-ID: <CAPDyKFrOudyqH1hszzWFS2CR7sxwfvdy7cjr8NvKVQ0_vtRbYA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: Fix internal cd irq miss with hard reset
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 Oct 2021 at 19:16, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
>
> This patch fixes internal cd irq miss after hard reset by enabling
> internal card insertion/removal interrupts.
>
> Fixes: b4d86f37eacb ("mmc: renesas_sdhi: do hard reset if possible")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Wolfram, would you mind having a look at this?

Kind regards
Uffe

> ---
> Hi All,
>
> On RZ/G2M board, if i enable internal cd, then it is missing irq after hard reset.
> Please find my test logs with card inserted during boot,
>
> case 1:- current case (no internal cd interrupt)
> root@hihope-rzg2m:~# cat /proc/interrupts | grep mmc
> 162:          0          0          0          0          0          0     GIC-0 197 Level     ee100000.mmc
> 163:        151          0          0          0          0          0     GIC-0 199 Level     ee140000.mmc
> 164:       1500          0          0          0          0          0     GIC-0 200 Level     ee160000.mmc
> root@hihope-rzg2m:~#
>
>
> case 2:- current case + patch
> root@hihope-rzg2m:~# cat /proc/interrupts | grep mmc
> 162:       1107          0          0          0          0          0     GIC-0 197 Level     ee100000.mmc
> 163:        151          0          0          0          0          0     GIC-0 199 Level     ee140000.mmc
> 164:       1106          0          0          0          0          0     GIC-0 200 Level     ee160000.mmc
> root@hihope-rzg2m:~#
>
> case 3:- with cd nterrupt as gpio
> root@hihope-rzg2m:~# cat /proc/interrupts | grep mmc
> 162:        796          0          0          0          0          0     GIC-0 197 Level     ee100000.mmc
> 163:        151          0          0          0          0          0     GIC-0 199 Level     ee140000.mmc
> 164:       1010          0          0          0          0          0     GIC-0 200 Level     ee160000.mmc
> 197:          0          0          0          0          0          0  gpio-rcar  12 Edge      ee100000.mmc cd
> root@hihope-rzg2m:~#
> ---
>  drivers/mmc/host/renesas_sdhi.h      | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 0c45e82ff0de..1199693690da 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -68,6 +68,7 @@ struct renesas_sdhi {
>         u32 scc_tappos_hs400;
>         const u8 *adjust_hs400_calib_table;
>         bool needs_adjust_hs400;
> +       bool internal_cd;
>
>         /* Tuning values: 1 for success, 0 for failure */
>         DECLARE_BITMAP(taps, BITS_PER_LONG);
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index a4407f391f66..9d828094169a 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -561,6 +561,11 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *host)
>                 /* Unknown why but without polling reset status, it will hang */
>                 read_poll_timeout(reset_control_status, ret, ret == 0, 1, 100,
>                                   false, priv->rstc);
> +
> +               if (priv->internal_cd)
> +                       tmio_mmc_enable_mmc_irqs(host, TMIO_STAT_CARD_REMOVE |
> +                                                TMIO_STAT_CARD_INSERT);
> +
>                 /* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
>                 sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
>                 priv->needs_adjust_hs400 = false;
> @@ -1017,6 +1022,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>         if (IS_ERR(priv->rstc))
>                 return PTR_ERR(priv->rstc);
>
> +       if (priv->rstc && !(host->mmc->caps & MMC_CAP_NONREMOVABLE) &&
> +           !mmc_can_gpio_cd(host->mmc))
> +               priv->internal_cd = true;
> +
>         ver = sd_ctrl_read16(host, CTL_VERSION);
>         /* GEN2_SDR104 is first known SDHI to use 32bit block count */
>         if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
> --
> 2.17.1
>
