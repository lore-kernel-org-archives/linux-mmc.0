Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A93FC7EE22
	for <linux-mmc@archiver.kernel.org>; Tue,  9 May 2023 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbjEIKKq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 May 2023 06:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbjEIKKm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 06:10:42 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A601100CB
        for <linux-mmc@vger.kernel.org>; Tue,  9 May 2023 03:10:36 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a79671a4dso86996557b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2023 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683627035; x=1686219035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef9WZn+vGlhv+lG0ytwmAyd399ywtt6jDc14qY1cjbQ=;
        b=p3+RN0+ELfyNijCECaZOoeyk8YzW732gDG9012If8DTmU+vsd+GZ7KQoqMig/2NkFZ
         G6kuvsvfbW+TggxzfLcjLS0Xc5wVxhgY5HhGioXdQluRE5rEoIo8qz+xMf9jL6LJ6RYf
         BFL7QdrFiIFSQoYIGe/63iTzD8jZ2XsEBDYpF23mMhqoJKT/R9Z5xrKMbvu5cdq7eKZR
         v+hBDQfdYh6EBETO81ypxFhtxBjosxGbf/m+pj+2q7x2MJxFvTSxXww0TI+NtyQpG9L4
         Rk8uOrtNjHjilNeZecVefaXDIWOm02rvuzcLiuVkYnTj9IEr31edmYHYO/YKPWES8TBz
         MpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683627035; x=1686219035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef9WZn+vGlhv+lG0ytwmAyd399ywtt6jDc14qY1cjbQ=;
        b=T2Vw1qNOe67M4Zd54WmdwBf7W6lw1kTo9BM1x7mZzvFozFUDNObhl0hyKUltBljBbD
         HQl5PwFm9iVnL0WReGuKxxHJo6XDnJtBjqkPq/ycSP/EOH6t8mkp7K+qcoVKfKbd0cbB
         2U/Y2fuBMtacGPWAr9rrdp6ahC2sAikrs/u5ENfpdoR3pdnFeU4ELcputE6glExKWfOq
         51gJKnZROS99/jBeyNdFZHbgRbTUe7eIk9AuiTatnBCbOIaww8/Bx1cWBoS2D/mdwdCI
         kSi4m8d5ckjB3LH5D7EY6JNGLJWCZbI7JN2MKUGYRY6R91wQQAx8+7PBqUngk0kaVMcG
         6gNQ==
X-Gm-Message-State: AC+VfDw/qekHJ5NiNAM85nW/CU/LUQA12swX4dZUKUDySJlTqmp0Ows8
        xsHd0ulJJIQRw+d32W/OLf0cBBh1gpJcitYO6X3h3bOz2bE/1Hgf
X-Google-Smtp-Source: ACHHUZ5ROOThUciJ/bW45KiAyJ5q1WTcqQ3hQ1OyXaOc7IZn6H20BGlbr6FJvp9UK8j69N6A0xEzvEBd8QMC3TXzFVA=
X-Received: by 2002:a0d:c641:0:b0:54f:23a:4c64 with SMTP id
 i62-20020a0dc641000000b0054f023a4c64mr15218292ywd.2.1683627035369; Tue, 09
 May 2023 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230505221506.1247424-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230505221506.1247424-1-u.kleine-koenig@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 12:09:59 +0200
Message-ID: <CAPDyKFrRt-bygnLrPB7rdvHRmsC4zeA+KfxPZDs9NZQnLSEm7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Make dw_mci_pltfm_remove() return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-mmc@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 6 May 2023 at 00:15, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> dw_mci_pltfm_remove() returned zero unconditionally. Make it return void
> instead which makes its semantics a bit clearer.
>
> Convert the drivers that use this function as .remove() callback to
> .remove_new() which has the right prototype. This helps getting rid of
> the platform_driver's remove callback that returns an int (which is
> error prone). The other users didn't check the return value anyhow.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-bluefield.c | 2 +-
>  drivers/mmc/host/dw_mmc-k3.c        | 2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c     | 5 ++---
>  drivers/mmc/host/dw_mmc-pltfm.h     | 2 +-
>  drivers/mmc/host/dw_mmc-starfive.c  | 2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mm=
c-bluefield.c
> index 10baf122bc15..4747e5698f48 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -52,7 +52,7 @@ static int dw_mci_bluefield_probe(struct platform_devic=
e *pdev)
>
>  static struct platform_driver dw_mci_bluefield_pltfm_driver =3D {
>         .probe          =3D dw_mci_bluefield_probe,
> -       .remove         =3D dw_mci_pltfm_remove,
> +       .remove_new     =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_bluefield",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 0311a37dd4ab..e8ee7c43f60b 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -470,7 +470,7 @@ static const struct dev_pm_ops dw_mci_k3_dev_pm_ops =
=3D {
>
>  static struct platform_driver dw_mci_k3_pltfm_driver =3D {
>         .probe          =3D dw_mci_k3_probe,
> -       .remove         =3D dw_mci_pltfm_remove,
> +       .remove_new     =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_k3",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pl=
tfm.c
> index 13e55cff8237..567dce73f205 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -122,18 +122,17 @@ static int dw_mci_pltfm_probe(struct platform_devic=
e *pdev)
>         return dw_mci_pltfm_register(pdev, drv_data);
>  }
>
> -int dw_mci_pltfm_remove(struct platform_device *pdev)
> +void dw_mci_pltfm_remove(struct platform_device *pdev)
>  {
>         struct dw_mci *host =3D platform_get_drvdata(pdev);
>
>         dw_mci_remove(host);
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
>
>  static struct platform_driver dw_mci_pltfm_driver =3D {
>         .probe          =3D dw_mci_pltfm_probe,
> -       .remove         =3D dw_mci_pltfm_remove,
> +       .remove_new     =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dw_mmc",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.h b/drivers/mmc/host/dw_mmc-pl=
tfm.h
> index 2d50d7da2e36..64cf7522a3d4 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.h
> +++ b/drivers/mmc/host/dw_mmc-pltfm.h
> @@ -10,7 +10,7 @@
>
>  extern int dw_mci_pltfm_register(struct platform_device *pdev,
>                                 const struct dw_mci_drv_data *drv_data);
> -extern int dw_mci_pltfm_remove(struct platform_device *pdev);
> +extern void dw_mci_pltfm_remove(struct platform_device *pdev);
>  extern const struct dev_pm_ops dw_mci_pltfm_pmops;
>
>  #endif /* _DW_MMC_PLTFM_H_ */
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc=
-starfive.c
> index dab1508bf83c..fd05a648a8bb 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -172,7 +172,7 @@ static int dw_mci_starfive_probe(struct platform_devi=
ce *pdev)
>
>  static struct platform_driver dw_mci_starfive_driver =3D {
>         .probe =3D dw_mci_starfive_probe,
> -       .remove =3D dw_mci_pltfm_remove,
> +       .remove_new =3D dw_mci_pltfm_remove,
>         .driver =3D {
>                 .name =3D "dwmmc_starfive",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
> --
> 2.39.2
>
