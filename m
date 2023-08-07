Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E87C001B0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 15:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjHGP1P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 11:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjHGP1M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 11:27:12 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF9E10FC
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 08:27:04 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so5264762276.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2023 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691422024; x=1692026824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRItn2cF5TQNt64raTRsWPd5Q0EJhD3/KF9OeDZ1Jek=;
        b=MUElYBBzp1nPLlNHE6f/TMFiwNBEnp4Jh6A6+RXtQRmfIPxPveRZ6FSfvExGpHEGoB
         RiwQQQxoK/oWcZ1+Ls05mu9ejhCXsQ2dUL1r0Kc6+JldzbZTVfBMJ+14l7tCB3/VFwM8
         Y/DaiHPImTPCgI+S4a/8uWx8qZVK9u5sqRdc5zw9BXE9M2F6fPwyWWl4t+ZkK2PtuTFi
         /GwylrICjRXYosRcN3l5CqE5HrLmurEEGMIsJmx1k7ga9EPPnKZgoAL+d6Rqmp/IiGy8
         7SDUc8lLFjCOfstH631w+MQ/5F4gCNV69IDXo0Uogb/QrQvPBTD+I+H4+Rxdi65+8hhl
         /NgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422024; x=1692026824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRItn2cF5TQNt64raTRsWPd5Q0EJhD3/KF9OeDZ1Jek=;
        b=XwuZG9eG93WFpKrGE74h2u0s3OE1CqJizT7uHaEKw5gMO/HCObdct4fApVjZb/zdXY
         2l5dG8+9Tkcn7eWolHqMMFZbiGGKVx9ggyyD0xl7P1Lv5L5BseeSWtESBWLNrpnfrqXl
         H0Gsnbgds1/bJCPHhoaUHC6tdfTE3C03lWRSuQyc93qzo4fTuthEWLymzVBxpLu3ni6M
         p6EO/nwIip3QLujPGo53RWkxWcPIIfTfl8HjjIs0tzZCApE37kBfl4I8M9LshSWx3EPW
         4g1Ks1IH2Lcgg1065XL1c0i5cN1nMpBnpaBSYWHsoPMJZleTxZJB5VZQHKTbYeAk9qt/
         eTCw==
X-Gm-Message-State: AOJu0YzfBB5cZ/3YHXuCX7eBEedjYThzn4WaWHLnFmHkt+3pTNxHQjhG
        0c9j0wFwtevT4aeEr4cASmjDP/HTTryzxaFeeoNOFcfU5wN4TbMdmAA=
X-Google-Smtp-Source: AGHT+IEnVXumr0NCmry9RyuOxY6r32vIR+eeIv8r9xUwQJax2apeM8tRM+axH69DYQH98HK4UUlOM0RO2JbMTbOXpMg=
X-Received: by 2002:a25:2396:0:b0:c12:29ac:1d36 with SMTP id
 j144-20020a252396000000b00c1229ac1d36mr10222700ybj.7.1691422023820; Mon, 07
 Aug 2023 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com>
In-Reply-To: <20230727070051.17778-1-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 17:26:27 +0200
Message-ID: <CAPDyKFr5smUN5VHCo-O_iFB=qzHFg5Gn9d6wm3bw+5UEy9n=Ww@mail.gmail.com>
Subject: Re: [PATCH v3 01/62] mmc: sunxi: Convert to platform remove callback
 returning void
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 Jul 2023 at 09:01, Yangtao Li <frank.li@vivo.com> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Normally I would prefer one patch per host driver, but in this series
the changes are so trivial that it just becomes more difficult for me
to manage.

Please squash all changes that convert from using ->remove() to
.remove_new() into one single patch for the mmc host drivers. Note
that, I discovered there are some additional cleanups being part of
the series, those deserve to be submitted indepently of this.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 69dcb8805e05..d3bd0ac99ec4 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1486,7 +1486,7 @@ static int sunxi_mmc_probe(struct platform_device *=
pdev)
>         return ret;
>  }
>
> -static int sunxi_mmc_remove(struct platform_device *pdev)
> +static void sunxi_mmc_remove(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc =3D platform_get_drvdata(pdev);
>         struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> @@ -1499,8 +1499,6 @@ static int sunxi_mmc_remove(struct platform_device =
*pdev)
>         }
>         dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
>         mmc_free_host(mmc);
> -
> -       return 0;
>  }
>
>  #ifdef CONFIG_PM
> @@ -1556,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver =3D =
{
>                 .pm =3D &sunxi_mmc_pm_ops,
>         },
>         .probe          =3D sunxi_mmc_probe,
> -       .remove         =3D sunxi_mmc_remove,
> +       .remove_new     =3D sunxi_mmc_remove,
>  };
>  module_platform_driver(sunxi_mmc_driver);
>
> --
> 2.39.0
>
