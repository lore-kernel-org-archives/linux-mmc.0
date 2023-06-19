Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F108DEB64D9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 11:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFSLnu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 07:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFSLnt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 07:43:49 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9768102
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:46 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57338656a8aso6382317b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 04:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687175026; x=1689767026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwqSLWLLuuaB54tU6yiU6JkxvK/2yq0oXCsUMbHlXp4=;
        b=G5OHxQ4sW1J5s3tk1R7PXJ6CvdRkOVyGoz0PKVttD11vxNxmi7QNip0BjmzmYr0RdW
         8ddei/agPzjOeLE9yDn/k+b25zbB9BEpwVrOsQNeukDZzlGgIEnrmPaUu37wNQc/CFEg
         PIc4t+uvosfNRTAn2XyHwf+MeYDQQ1Cb8YuI1UIjaTpcgnu3cnYWER7602vzbJzii1M1
         GFx829bZcSRKR2DDIGJtEjUsh7rQC8TlvsjQlbx1RLp0PUa0XsNOfZL3TSZyQ0yORyqW
         09X4owXQsOs2rkdI9OHHxi9fVC7kPVkquV/TfUQ+y1rxqVgM4WxIXRJ5dzZlqCfNQfjD
         cwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175026; x=1689767026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwqSLWLLuuaB54tU6yiU6JkxvK/2yq0oXCsUMbHlXp4=;
        b=kbI1LvDXDjTwlhYyzSxedyE3j7c/di7m9Gc0FRzsdocbmSAKAmWqFxRUJ4+hYFfkA4
         UbuvOg2NMSlBPAsWq87w66fU9NsvFJnpwksnUcOviZF6C/oevh1nNSzXE/c0ee3bDI6/
         aeSAzfAcVb0h0bdqLIs3MYhKeIsZnbRfDWObv2UYKFnEmk1b0uw8wTM6h3Z4/gmPBZXd
         yLgftzpuCZgsWqDeKGSidE2ilMRFVkx4Ho1pRSfgnN4HKrOGOJn6Rg7UcOhc8Ozmd8tx
         M9D2DaBoLFfrQGnFg702qnzUDO3hedvARxSBwkmPZ1i4qQQTxqHThD4MRSKsqA2FiY+R
         1rpw==
X-Gm-Message-State: AC+VfDwMUn5N+xcTODUbsSooOuhlYgPQevDsh1LEio+8yJw3P+yI38yV
        q0IW5tj5l8L/Yzf7iHgUkFOAZXtD2eb1OG6jtayNAQ==
X-Google-Smtp-Source: ACHHUZ4C1cZpDLmjQnJKl7Od5wdTkYCNUxLNqqNA3XGgU02eEX+6vc1XjZsU4XFV8ETNsGRiodR7BEhVvhmumKdrewI=
X-Received: by 2002:a81:91c1:0:b0:56d:3327:825 with SMTP id
 i184-20020a8191c1000000b0056d33270825mr7274557ywg.48.1687175025972; Mon, 19
 Jun 2023 04:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230617085319.2139-1-jszhang@kernel.org>
In-Reply-To: <20230617085319.2139-1-jszhang@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Jun 2023 13:43:10 +0200
Message-ID: <CAPDyKFr+CW4SU2Q3h16cT52Y=WNa-0VHZXGHObTFmWPBrf8YxQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: litex_mmc: set PROBE_PREFER_ASYNCHRONOUS
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 17 Jun 2023 at 11:04, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> mmc host drivers should have enabled the asynchronous probe option, but
> it seems like we didn't set it for litex_mmc when introducing litex mmc
> support, so let's set it now.
>
> Tested with linux-on-litex-vexriscv on sipeed tang nano 20K fpga.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Applied for fixes, by adding both a fixes and a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/litex_mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 39c6707fdfdb..9af6b0902efe 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -649,6 +649,7 @@ static struct platform_driver litex_mmc_driver = {
>         .driver = {
>                 .name = "litex-mmc",
>                 .of_match_table = litex_match,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };
>  module_platform_driver(litex_mmc_driver);
> --
> 2.40.1
>
