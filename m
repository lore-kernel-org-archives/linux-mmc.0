Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B86CC4332D
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B7864F89
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhCIJDD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbhCIJCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 04:02:38 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4998C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 01:02:37 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id l27so6413850vsj.4
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mOjqeg59DhCO1NJGI6CFwmiKdDTe7R83FJmZUTJAeo=;
        b=w5apAR8EPMmNag6YyvemjSWjfJ/hnuEzTl5B8SExhz9x6nxXaAWGmiD64JgsQWoumy
         7JG3vyMhDaVAkSG4PBYKCkG6cO7GC9bc+BF6DHF6IFMom7Gkfaho+c5V6sOrSxw9nMTQ
         n63L0ZeZvPLCW66Ey23loYenxIA9d36dFgeJ1IGVMUgzPbCIpk7DsjVJG+4RCtx/aLOj
         YmYfjCIEm5SsqTClmZ2ScoSC1xXv3zpf+yfUHtelpqyQquK0cvB+gmpjfGxqi1YlwoPs
         eSlypjinXfyskMIRp19oz+CDBPJLFhUgvt25l1cqNHHYEchSk3bWrCKOu17iljE4Kmkm
         TO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mOjqeg59DhCO1NJGI6CFwmiKdDTe7R83FJmZUTJAeo=;
        b=Zx4p02UxqGazErNvBdYI+bl3IePSY72DFNOeriyaGbDV9IRKKUvTPPQ8KXDnWMRaLD
         lKQXL4oNrlBwDYIzFwTBVs5OiWVmUy+AiSppD4cSD8L2ndE4m0W17VoPq6pSmUAwFvxM
         5/fjV/JH/guEA/35weevUiJuTJ6WT5YfRHRNdSiYIQDtf8m4WqUmDz+uaRT58dGRwhSZ
         svVJr28ZSRDVadNp/qgGXK+oJDz96WbXQGUyX29T9Fgs5hUjZ+WwCzmcrcQbsHV2MNur
         AaaV/0h4YyVjhPyfI8ILDJurS6oyrU0mpGaZbkxcoLpFJoKJuhZOHjXs5ImHYCxRbjlT
         qJ+A==
X-Gm-Message-State: AOAM531vuCWMISlZ97kO7VZH+YBIuZtyq5gAMCbVP4/OKGbtPkcmmwto
        wc4UsGukZe/OeltU1hynWIMV5lpKrBj385bUoi1gfsN7jsRHsQ==
X-Google-Smtp-Source: ABdhPJxGQF7CijfR+scQTuoiyx2kIjHkpuuT+rY7LqsLLG1Lih/s8D2YCemUQD/gJValy8R3oo67L2NoZH3QLfIAV3g=
X-Received: by 2002:a67:6942:: with SMTP id e63mr3815959vsc.48.1615280557135;
 Tue, 09 Mar 2021 01:02:37 -0800 (PST)
MIME-Version: 1.0
References: <1615272478-52458-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1615272478-52458-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:02:00 +0100
Message-ID: <CAPDyKFp67w=vT2VHmtsjc1++HtEfZNyKSo-N1gmdJtB-d62m6w@mail.gmail.com>
Subject: Re: [PATCH] mmc: via-sdmmc: remove unneeded variable 'ret'
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Mar 2021 at 07:48, Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
> ./drivers/mmc/host/via-sdmmc.c:1274:5-8: Unneeded variable: "ret".
> Return "0" on line 1295
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 4f4c081..a1d0985 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1271,7 +1271,6 @@ static int __maybe_unused via_sd_suspend(struct device *dev)
>  static int __maybe_unused via_sd_resume(struct device *dev)
>  {
>         struct via_crdr_mmc_host *sdhost;
> -       int ret = 0;
>         u8 gatt;
>
>         sdhost = dev_get_drvdata(dev);
> @@ -1292,7 +1291,7 @@ static int __maybe_unused via_sd_resume(struct device *dev)
>         via_restore_pcictrlreg(sdhost);
>         via_init_sdc_pm(sdhost);
>
> -       return ret;
> +       return 0;
>  }
>
>  static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
> --
> 1.8.3.1
>
