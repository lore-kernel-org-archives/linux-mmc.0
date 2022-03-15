Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C5C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348207AbiCOMYk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348176AbiCOMYi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 08:24:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752263D3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so9612848ljr.9
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoskkRaS3xKbqK2gaYIRk1KTtxNlFqgeuXFN+AZZnLY=;
        b=Q37V0853LSlk5ZhEq0VoQgmGV9DHPIeQ+ZEwwGw4B/yZytSozSz7Jj22JHt8/f5l/v
         80Ja0WVYDd3/ojuQXVwZu1FBWVl0DBDuzuyjIfzbrY8j3L5nIUrNvMAu59C3JdIkDSgC
         +7fyHRV+lyzsFAZrr2ZRRNaoxeTTc3N6kesSzMV8sr7c/WBjDIn+Gx/5jFhxjl+jb13C
         uL+qlcJIYklvdXK9XZOG4vhnLB+qLHaA0C7qwIzxBT9LnqAQ9EmTqd5ncgkURRP8ISGD
         2iQXeKrVyxy+lifc5n6aCv+UcvTmoOEXm8KM/imo2FptfV9ySDMdkrzAmlK2iRg0Xoep
         aVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoskkRaS3xKbqK2gaYIRk1KTtxNlFqgeuXFN+AZZnLY=;
        b=lkOaMg4B93d+XridgjAFZMlVyWW9bBPvlQ/GvgPjhFfq4HLoWQ/tzwYpSO1YHihE7R
         /bCoONSRoMNFVHSA2ppQB5y6y+cI9KbuhL1QKkE/c2Nqa+zY9TdZF4hU28lnrwg75yi4
         P2Cx6qiDNddGrB5KPoOJa7FUNYttwFLfu6ms1vwJE8jwTOkHuGPBJN2KIKngbuMe9G/P
         cuSwzeplmlSkY4Wm35/F2hC8I/n6R7vNBZTaXRk3aijfPye6bCu/QliDVamfivKPnoEH
         EjwK1UM/O05U6G6gaTTnbLesNHYgCqBlqCVZC2Mn6zHwhLS5qGhArcU529Wn9Ig+nvbK
         IjeQ==
X-Gm-Message-State: AOAM5304UXS11zQDXyZ0hEwF6aSV57ttW2toD2fQWaqf2dV+dWdR8ccM
        HaC0Xh/qgKVe7nzAFunsInz72/yT8yR+sKSnjXtSuQ==
X-Google-Smtp-Source: ABdhPJyw6ZJVayVjzWxqOjk9MssbxAdG+fFQBGuSUslZ2HTumnLArfhj8jb0uGkUUduJOpNoBRtgFn7mGSzSpqfF5oE=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr17257479ljj.4.1647347004620; Tue, 15 Mar
 2022 05:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220307090009.1386876-1-benchuanggli@gmail.com>
In-Reply-To: <20220307090009.1386876-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:48 +0100
Message-ID: <CAPDyKFpYSTsA5wtTA83QvAaK+Teyshz_PssddE2DJyuM-MLHMA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: Add runtime PM for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        hl.liu@genesyslogic.com.tw,
        Kevin Chang <kevin.chang@lcfuturecenter.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Mar 2022 at 10:00, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> Add runtime PM for GL9763E and disable PLL in runtime suspend. So power
> gated of upstream port can be enabled. GL9763E has an auxiliary power
> so it keep states in runtime suspend. In runtime resume, PLL is enabled
> and waits for it to stabilize.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Tested-by: Kevin Chang <kevin.chang@lcfuturecenter.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> * modify commit messages
> * Use read_poll_timeout() instead of while loop
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 97035d77c18c..c854c8db32e4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -13,6 +13,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> +#include <linux/iopoll.h>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "cqhci.h"
> @@ -873,6 +874,47 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
>  }
>
> +#ifdef CONFIG_PM
> +static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clock &= ~(SDHCI_CLOCK_PLL_EN | SDHCI_CLOCK_CARD_EN);
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +
> +static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct sdhci_host *host = slot->host;
> +       u16 clock;
> +
> +       clock = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +       clock |= SDHCI_CLOCK_PLL_EN;
> +       clock &= ~SDHCI_CLOCK_INT_STABLE;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       /* Wait max 150 ms */
> +       if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
> +                             1000, 150000, false, host, SDHCI_CLOCK_CONTROL)) {
> +               pr_err("%s: PLL clock never stabilised.\n",
> +                      mmc_hostname(host->mmc));
> +               sdhci_dumpregs(host);
> +       }
> +
> +       clock |= SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clock, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev = slot->chip->pdev;
> @@ -982,6 +1024,11 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         = sdhci_cqhci_gli_resume,
>         .suspend        = sdhci_cqhci_gli_suspend,
> +#endif
> +#ifdef CONFIG_PM
> +       .runtime_suspend = gl9763e_runtime_suspend,
> +       .runtime_resume  = gl9763e_runtime_resume,
> +       .allow_runtime_pm = true,
>  #endif
>         .add_host       = gl9763e_add_host,
>  };
> --
> 2.35.1
>
