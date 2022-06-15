Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356200AbiFOReH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiFORdG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 13:33:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD2F6554
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:02 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id d19so14061326lji.10
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jun 2022 10:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn84S9DZzXxuly9v146DUPCGGjqgx99QTtCb7s6xuUs=;
        b=NFIV6fKm7Y9uSgvDnJB+dClVCg5cH8LbPheNuIlMpEInJU/Uqhcp+J8Y9PlgjkfjeP
         4yCbYyX0WeMNUQjeJbiFilRt7njH25a3ObFEPKG/OgDdzb/9nTQavwgPZQmIYkJq29o9
         cA1M4US1DoTNT2ePaURbfvZ6M4VAgPKwOORogeFGaYg/GJ4eMicg61E/avW6MFEtI6nh
         wTpHoSwqUnpSS2b7ZZEibAh5pPSO+J9vQQ9R5/52wkxlxryZRpyJ8Oesl4yWNZqJEI98
         qjK3TrX/SvMBqUf8vmjf37f0wBem4JOV5+gol04Rqk4RHMaF7Ee2AUS/sgLo2elMWfAL
         AOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn84S9DZzXxuly9v146DUPCGGjqgx99QTtCb7s6xuUs=;
        b=mI1qKOr2WbAIXBzBTkTRFeOS0Wl56csstv8ry3SzYh1EPAlE3JAcOtpIyz1JKsEfIu
         iwRAtVbaS2GkiWv058BqkLRBCKghmtnTT4qKT7ip/pJFge3upWwk73osP6DzNgl9rAji
         f/RdnWER1PaKZ0SG2JOVgbi2QjUuJ5BlGdtZYGMs8r2+YGRP0Lxd93yXKlpaiyiiuX6D
         duOvN+wRxi6lwTUORPghHqbSIZxdPiqdLFQgVIk8kGMR+psJC+uyZzWAkItA3R3uX7Uw
         vXTXam0bveoEf8OuD9c6H8OzHAhbsPsnledC+T29SzX//OBf1X6ADn+RCoZ445WhlzpA
         vy9w==
X-Gm-Message-State: AJIora/SG+9tGicGLywN8I+OZ4E6pa4kbsQ6yuCkQ18Koq3rL4lva04f
        mG050+Smtfcfd19FewUnlbu+NVtJ+08M6gBpuCD5yA==
X-Google-Smtp-Source: AGRyM1txepgaizMwVw73ONVyUnmhvFi3eeueNr1BNnbmn6/tCWPAL2c1jjq1+2UsozQMb4jMoAzAccnZApQZiPMWBIg=
X-Received: by 2002:a05:651c:1a1e:b0:258:f021:8020 with SMTP id
 by30-20020a05651c1a1e00b00258f0218020mr440285ljb.273.1655314381160; Wed, 15
 Jun 2022 10:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220608090152.179395-1-weiyongjun1@huawei.com>
In-Reply-To: <20220608090152.179395-1-weiyongjun1@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Jun 2022 10:32:23 -0700
Message-ID: <CAPDyKFqkLCmYLvOfPUMpw=GObGGMaCVEeYYgDDuLWp2wpNgBfg@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: debugfs: Fix file release memory leak
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Liangliang Lu <quic_luliang@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Sayali Lokhande <quic_sayalil@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jun 2022 at 01:43, Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> When using single_open() for opening, single_release() should be
> used instead of seq_release(), otherwise there is a memory leak.
>
> Fixes: c835a6debf06 ("mmc: debugfs: Add debug fs entry for mmc driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 75e98ec88fb9..fe6808771bc7 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -295,6 +295,7 @@ static const struct file_operations mmc_err_stats_fops = {
>         .open   = mmc_err_stats_open,
>         .read   = seq_read,
>         .write  = mmc_err_stats_write,
> +       .release = single_release,
>  };
>
>  void mmc_add_host_debugfs(struct mmc_host *host)
>
