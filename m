Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2364EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjGMLHZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjGMLHY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:07:24 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B16E211F
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:21 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57a6df91b1eso4887447b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246440; x=1691838440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIs4kvIJEkr4354hkiVElFaIrSw+1f+1C7JGvLV2E0c=;
        b=rC5oN/0ZOjlh9nIEKTrSw/4yWn5nZFno0feRyd2ea3PAY1AorYEYC9oZHbq5i3bxR4
         TPYH6aGWqYrQWNlNkpY/WnJBIGu/NGqhquyDOarBfohVG712czsLTwmREtUEeysno/S7
         2iROprpkvHjRL63HD7Sb0dyD0proZYDcgKZWW3xFzvkoR2xFKIUAQu7lnORuXoSiLrYF
         yXygJ8WQFozjgpEX4cGxfJgHo5TN8ctimCNYBKDy7Ft+qxMxJ3sBGFyPMjxoaNvNwlv/
         7ctlDTCaD95YavNfh5fGx/NxKXoaJDmMJCcfQeE9yzdPC2iRgMqVHxcl6OaKtwWEj4Vu
         k3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246440; x=1691838440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIs4kvIJEkr4354hkiVElFaIrSw+1f+1C7JGvLV2E0c=;
        b=BFuOJHMhwgcJKaOnjvkBg4RW9dhxel/DKvWMHjgjrdkkVnO+pii+I7t5hYfIDttkTW
         PT9EEySaN6otiZjDO3KlOwajkShvEHjKsCef9fjPkGO2a3dumjHQgrTx0wXFUTVOgd1Y
         wv3tRYJQ86IpCcfanWzk4jTMu177/9LdIvHnm48dpgyC8IsWRYn8QP0U5Xech/C/tsVw
         09pSeEs2y4ZpMc56d7Frr+XVOrz5dtX36/JPIhSFnebOAiRUsFLWuJO5KlN3jbGP5KeM
         4Tm/G4CB0KyousaFQU+b/KuOCnsGWWg31R7gCC/sH0r4RvfumsJxye2yuGrp4daJQbPc
         /pig==
X-Gm-Message-State: ABy/qLYR7zaS8lb+nhxgFJwa7+/b8v1yGjzPwxcwYZh+Kd+XMZSGw3Q6
        DYn1VUSWDr4WkdlSQlE3W4yRLTTNM68osEAfpYVMdw==
X-Google-Smtp-Source: APBJJlHzloQARqnstuXsXKkbjA0jEn0zvmhh3Yn/4jCscB6SAvEma4YZoW4MGj2Mz5CooecdPjv5GdOq6/GgDKwhMf8=
X-Received: by 2002:a0d:d94f:0:b0:573:a763:5876 with SMTP id
 b76-20020a0dd94f000000b00573a7635876mr1140592ywe.51.1689246440589; Thu, 13
 Jul 2023 04:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230704131939.22562-1-frank.li@vivo.com>
In-Reply-To: <20230704131939.22562-1-frank.li@vivo.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:44 +0200
Message-ID: <CAPDyKFpyfNTZrR6h=TEpibkq=uoCiAnNnfos307_TBGEkor7eA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mxcmmc: Use devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Jul 2023 at 15:19, Yangtao Li <frank.li@vivo.com> wrote:
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxcmmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 668f865f3efb..f3a72569dd1a 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -989,7 +989,6 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         pr_info("i.MX/MPC512x SDHC driver\n");
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
> @@ -1000,7 +999,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>
>         host = mmc_priv(mmc);
>
> -       host->base = devm_ioremap_resource(&pdev->dev, res);
> +       host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>         if (IS_ERR(host->base)) {
>                 ret = PTR_ERR(host->base);
>                 goto out_free;
> --
> 2.39.0
>
