Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF301C636CC
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Feb 2023 23:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBMXtr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Feb 2023 18:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbjBMXtp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2023 18:49:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF09193DC
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so1871660pjb.1
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 15:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=odhaLSQAYuADLGZm4pIKzQ/pEf5/tb+uT7nEOsNGavM=;
        b=Lj9Ycve+GsNdexadAYK76iYELe+/kM1HkNXPFV4Mos+c8Ct7WaNiL7j8biV4RgX01a
         I0UIQLsIhl3BbTQZS4c0IVZKnXFhEHepYbdaJIr3lUXLRn2zmE0/c1326/4cIQULtX58
         1t7+DoCg/GpprokQZ6IT+NEluMrkYHxf1wSgvqfaTvmpIHDLxCXhdCicDfLNG2mz8koT
         owlYHD5Q40cDOGb7JBpXBt7FyQfoXncyAxhsnMGAClOOYCVRGesFm8XRf3Oo2J2K28ry
         KWx4tZ4XSqHkVEe96Ong6XaLP40qvlnP+GNBaNLQyzmNgiJ86Lpa4SOQb1VVWDecGEbo
         Ng1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odhaLSQAYuADLGZm4pIKzQ/pEf5/tb+uT7nEOsNGavM=;
        b=d6lWr4n25NiZSRdG5mft1Es9HptCmX15xMFnWMGkCh5bW0is3aOMNhHWnnxtVt3h8/
         d54sumtpYqcoQvjUbg67AJgpth/w9FxdkLv4VT4cfxUSZ2VR44Qbb0xfvzGj7GZFqvUN
         /R7FMcp5k0t95De1UM87yx073GTcW1LeRk32RgZzUCmukG1twZNrOpu+4gRq0eJcui5r
         JL2PCB+NoetwYDv2cvZgpUsak2pR2wZPH+G34lk2US5BISKpvfcCQmmAv5bL02BNywY0
         PFOX6h5r/yxVWd1ruG900yh7c5ivTQFjMJ/k+FoCKDje3YmSE+BphQ9vMtBH+cs/NISa
         HPZA==
X-Gm-Message-State: AO0yUKWYHNPUVvCYxVicUZjqXg5NBoM/LVI/GOf9jcd+i3Rpv+AknRvG
        KcgWH0wjCdNLBNRxFZdKbGOAH9OOiSGow1DtVlR3XQBbk+ryhQ==
X-Google-Smtp-Source: AK7set9J/arpZcJrTEQTjyjRO/G9/8RYV08onHtTsJP9yMNQ5kU9PJJaQwXlv+rezCo79c8EhGdFoW4OypK42lPb4DQ=
X-Received: by 2002:a17:90a:c710:b0:233:ce0b:5f78 with SMTP id
 o16-20020a17090ac71000b00233ce0b5f78mr1761621pjt.32.1676332156798; Mon, 13
 Feb 2023 15:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20230131210229.68129-1-paul@crapouillou.net>
In-Reply-To: <20230131210229.68129-1-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 00:48:40 +0100
Message-ID: <CAPDyKFon1_0HPZLZTVvy+oEukWaMGuXtt+3YBQBrcbguy5U3-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Work around bug on JZ4760(B)
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Jan 2023 at 22:02, Paul Cercueil <paul@crapouillou.net> wrote:
>
> On JZ4760 and JZ4760B, SD cards fail to run if the maximum clock
> rate is set to 50 MHz, even though the controller officially does
> support it.
>
> Until the actual bug is found and fixed, limit the maximum clock rate to
> 24 MHz.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 319a2a79c9a0..eb8e9607b086 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1104,6 +1104,16 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
>         mmc->ops = &jz4740_mmc_ops;
>         if (!mmc->f_max)
>                 mmc->f_max = JZ_MMC_CLK_RATE;
> +
> +       /*
> +        * There seems to be a problem with this driver on the JZ4760 and
> +        * JZ4760B SoCs. There, when using the maximum rate supported (50 MHz),
> +        * the communication fails with many SD cards.
> +        * Until this bug is sorted out, limit the maximum rate to 24 MHz.
> +        */
> +       if (host->version == JZ_MMC_JZ4760 && mmc->f_max > JZ_MMC_CLK_RATE)
> +               mmc->f_max = JZ_MMC_CLK_RATE;
> +
>         mmc->f_min = mmc->f_max / 128;
>         mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>
> --
> 2.39.1
>
