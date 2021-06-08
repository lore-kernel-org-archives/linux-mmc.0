Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84F7C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 12:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9378B608FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 12:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhFHMzF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbhFHMzF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 08:55:05 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A67C061574
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 05:53:12 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id q2so3399063vsr.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDlE8XM+AqrC8aactj8iOE9/9/UtQhGPP6ubsL853mE=;
        b=ynpc10QMwm1EgFSorofuApQoVcK7XFUqTGiG/nOznXG5OK3Vs7OJvq5di819+XZX7P
         KE41fyCrCkIn1O+QuYypb2iUsvHiElO1lrhDqRlgEjkqcpZrVQlSkxZIG/wthzCj3fOj
         htkCrvsm8PvJfnwOADdWmCPFNfL3nWvUUQBney1QxyJIaw3CT+VJ5TdluB2SKBfpXdpO
         QZlyXchlhzlevdx7DuKhficlhG+d06CvwIttQhfJf2dk1TEaZD6wNjjEFr6fsSFongIf
         sWu1mQq8ztnYQrqVoRNTv10PzYGdlu2ZCTk8ODBhRLMeYY+90Xu0zDLoKov/EJlc1iMt
         NIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDlE8XM+AqrC8aactj8iOE9/9/UtQhGPP6ubsL853mE=;
        b=ohyakZQiDuW6jPIsh1Gq9dyoSanXZuVYJ9yZOecrY7sDMg2oORjnPjgA2PLNTD1zw+
         ij9jv3e59RsvbTf4pkjFJtPq0w+Ls+pJyrn01hO2UuHC4bBJv3Pl6JB3RNrSQJDp3zWO
         qGepVvD6pW4RXGpXRAzKaTxHM+pLy8+OSq3/FQ7luYdzt/hT50ezynXwUEqlkTjYGlmR
         DvNTVme0jgh0OFchhDPu4bgPvYBN0J3EYiuN7U2ibG8deanmkyi+VMEgbKVL0wA9kj5E
         s/8dYtXF9EnArSUPymqxydP7WnbTdRJyMTUSvcJbK+l00G4HYgnTFVvmjfh9a9Qg2ZRD
         VOLA==
X-Gm-Message-State: AOAM531b1uURenVooUWyxscQ1yybx0DVC1pE616PpJwUdPUPOtJiO/Fu
        LYqg0XiTMAenHTP2ZyMASIXO56QZPJkK+RiX4yr7Kg==
X-Google-Smtp-Source: ABdhPJzXlM5//BYqNHry4rGqxcGe5fwgnxOs8PtRpsSla+nUrxQuMCRfrAnGVPJFCfoi/NqcFSD0YHHKehrlKhq2/SM=
X-Received: by 2002:a05:6102:3023:: with SMTP id v3mr11576713vsa.19.1623156789091;
 Tue, 08 Jun 2021 05:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210603182242.25733-1-rashmi.a@intel.com> <20210603182242.25733-3-rashmi.a@intel.com>
In-Reply-To: <20210603182242.25733-3-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 14:52:33 +0200
Message-ID: <CAPDyKFr-vuP_bdG-iFjJyS3ZeVDiVq+3aVERHjBo-8BHf38m9g@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5B=E2=80=9CPATCH=E2=80=9D_2=2F2=5D_phy=3A_intel=3A_Fix_for_warnings_d?=
        =?UTF-8?Q?ue_to_EMMC_clock_175Mhz_change_in_FIP?=
To:     rashmi.a@intel.com, Kishon <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Jun 2021 at 20:22, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> Since the EMMC clock was changed from 200Mhz to 175Mhz in FIP,
> there were some warnings introduced, as the frequency values
> being checked was still wrt 200Mhz in code. Hence, the frequency
> checks are now updated based on the current 175Mhz EMMC clock changed
> in FIP.
>
> Spamming kernel log msg:
> "phy phy-20290000.mmc_phy.2: Unsupported rate: 43750000"
>
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

I guess $subject patch should be queued together with patch1/2 (via
the mmc tree?), no?

Vinod, Kishion, if that's okay I need an ack from you to pick it up.

Kind regards
Uffe

> ---
>  drivers/phy/intel/phy-intel-keembay-emmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/intel/phy-intel-keembay-emmc.c b/drivers/phy/intel/phy-intel-keembay-emmc.c
> index eb7c635ed89a..0eb11ac7c2e2 100644
> --- a/drivers/phy/intel/phy-intel-keembay-emmc.c
> +++ b/drivers/phy/intel/phy-intel-keembay-emmc.c
> @@ -95,7 +95,8 @@ static int keembay_emmc_phy_power(struct phy *phy, bool on_off)
>         else
>                 freqsel = 0x0;
>
> -       if (mhz < 50 || mhz > 200)
> +       /* Check for EMMC clock rate*/
> +       if (mhz > 175)
>                 dev_warn(&phy->dev, "Unsupported rate: %d MHz\n", mhz);
>
>         /*
> --
> 2.17.1
>
