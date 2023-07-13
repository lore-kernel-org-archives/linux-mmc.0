Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26FC0015E
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjGMOhV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMOhT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 10:37:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD461734
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 07:37:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so12022061fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 07:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689259036; x=1691851036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPi8Rde664k4OWrsk/yjT4y4yqazwgh3DlNB+1+OPRk=;
        b=0AQf6ugszcZPVHY7DwMOiA13w29AGJT5OPOCp2OF+zN86xFPJowoWVjL2xiRvqqsF4
         iRhdMPVvNexvHD9CqLBb8eCGnaaKkW4wpq53MqDi5jxJozA0WNMu8hOWmnOYernj/2IY
         bA11DqM9IxQv+R+PEm3OGM0M+gif2kxsEXVDNCcMwueZMbQsM4olsXNKpoxlDar+VA32
         Ly+ry+Ijehrjp3+zB0RYGXAUltkLzxTBJWwLGm9GOtvyE3WEU77BnO1o0I7xV1DLS2Vb
         tOhAxVRH6x/drXN9EfOv+1gRTFAlCncCJw7GD9Fz2KAjLUSEsihFKlsjacvPKmTEWOBJ
         eKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689259036; x=1691851036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPi8Rde664k4OWrsk/yjT4y4yqazwgh3DlNB+1+OPRk=;
        b=lAB4JI1An28X+xVGCBtu1qURgUofc8bP8d8NbNMqqrPYvnFWhvuezDAuoetn13Fdmx
         Bgyd5C1KlQkun192epDXQaY6hs8wJt/qITUpq90uf76F84uIgfkE/VvJsClfKsFjbrd5
         l8UGjyUccXpKtosUnkwStV3Y006e/A0R5gVwAcdhHPazOtaU8ezT5toK6Ufn4zWOTBqb
         K157DfAcAc/A3igqZex60suFvXt5T9+VyQIF5vzW5IZilUDVS1h6nsSfKOTkuoVv9jL/
         coEKinqf2NWF4/N7h79SKtcBkhuNggvT9VS9pFZMrpnkpczAeb/heB3IJ/2cU9XtK2jj
         VVIQ==
X-Gm-Message-State: ABy/qLZWZ2WvTsTJvPpkMjeI5nETEUuEReLHwagoQDqqgkh8RMAJrK6u
        LwRAC3EwThulU36qsmTlLMJcW9QyKB0jxpuyaWypLg==
X-Google-Smtp-Source: APBJJlGb+Hl5Ue9NsHUBSVMKchaqyoYb8Q3XGAg4ZgImreaHHxSMI8h/aNdlV3mV0Si2/cGZyFd6CFDg1CxrvDIwX2w=
X-Received: by 2002:a2e:9dd0:0:b0:2b6:df15:f6ad with SMTP id
 x16-20020a2e9dd0000000b002b6df15f6admr1529183ljj.18.1689259036279; Thu, 13
 Jul 2023 07:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
In-Reply-To: <8b57db8d-1d3a-883e-eb8f-ddf15f19d823@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 13 Jul 2023 16:37:04 +0200
Message-ID: <CAMRc=MdDmsUUwZqKFt6vMaL9iuRT-44XvLJrEbr9vZTxOJR1Mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Make SDIO irq truly optional
To:     Julien Delbergue <j.delbergue.foss@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 13, 2023 at 11:31=E2=80=AFAM Julien Delbergue
<j.delbergue.foss@gmail.com> wrote:
>
> The following error is printed on Logic PD's DA850 EVM:
>   davinci_mmc 1c40000.mmc: error -ENXIO: IRQ index 1 not found
>
> Depending on the board, the SDIO interrupt may not be present, so use
> the correct function to reflect that and prevent logging an error.
>
> Signed-off-by: Julien Delbergue <j.delbergue.foss@gmail.com>
> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 7138dfa065bf..fb686c0d171c 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1257,7 +1257,7 @@ static int davinci_mmcsd_probe(struct platform_devi=
ce *pdev)
>
>         host->use_dma =3D use_dma;
>         host->mmc_irq =3D irq;
> -       host->sdio_irq =3D platform_get_irq(pdev, 1);
> +       host->sdio_irq =3D platform_get_irq_optional(pdev, 1);
>
>         if (host->use_dma) {
>                 ret =3D davinci_acquire_dma_channels(host);
> --
> 2.34.1

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
