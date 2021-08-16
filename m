Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA29CC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF0361AA3
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbhHPK2N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhHPK2M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 06:28:12 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D1C061764
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 03:27:41 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id u39so1323669uad.10
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 03:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRH4TVFPj1g2bLXry7U6Q5PGawo78fbiYn7oa4P7TUE=;
        b=wUONjgu57oYf3OfxDDScC3ZokM5dNXLU+0GsEWRZ3QVzsyATXYqT58BpdtitRkQkIH
         9j4dHB+IpVqScnNr9gIh/8BBpPPN1oyuqGiBT28prUs0TV2sjtlrXSEKM44kpi29mtgm
         hsFDminvf3C0rKryy/W0IFmoq+mJr3YJ2W9yriAbTRxX9XMEUC0KHf/vO6t4PmpcBVwV
         eHlohxqA6fWnbXgZMYVKahwwM+7oOdp60WFDNSxi1+1S4L3v05kNYa3zKRhdV51s5eyf
         6A1sXyDRMjedq0EvnMhnzh20FFACX3TsDX7epWJFWhh3U9Q8UvF+J3vSXdfACqnJmYBH
         0W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRH4TVFPj1g2bLXry7U6Q5PGawo78fbiYn7oa4P7TUE=;
        b=RxlTgWD7/dKgtuo5qJrDYWDGs1bPocgfvlLw5VcZjZ+hD1lOhNLs0cixcgr1NmAgDs
         PlFQGP0EqruZqyo6YwioEg7uW8eQc8NGwNr+zmizl4b4YmiMsgAWcodZvsMuwBbGpvRw
         C6oipQlMBIDqWTCVuWhYRRvyOGvoYsnAxRxzcPj9qbu5x12VwMcGY+aZWiSD5oiZSZy7
         aEcWBeAroLf551iIV7gVzB8HkQGhBkIqrzFcAYJDYsUXZzy1oa5dGrqvLGvE1BCX8nID
         ZRRcFNiLt25PxIiUVM1D3peqd8eezNCDaI1/Ma9iAoSTgJyugRLAsnhznwHwn5mQ9Jj8
         r6eQ==
X-Gm-Message-State: AOAM532cTOmApPtztpZ8DBZHr0wW4YsV+Rp5emywTtJpscx1yZ3LB8B5
        +iNofycW4bWuACPlspVPn6aRSjS8tTWLW7lIMHey4g==
X-Google-Smtp-Source: ABdhPJx12b+Bqmk2bxuZlUu8XnA8FFpwLQVJjtElcHZQSIpFTlWvmHagxQPgWDu9OhRbbdZgmffyA5kUa3yLHHrPYLQ=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr8092627uaf.129.1629109660385;
 Mon, 16 Aug 2021 03:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210809072315.1127-1-derong.liu@mediatek.com>
In-Reply-To: <20210809072315.1127-1-derong.liu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 12:27:04 +0200
Message-ID: <CAPDyKFq3_eia7cvo-1Ajj5wcrfEHtp_EsMp27uL4dC_n+vPWZQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mediatek: add wait dma stop done flow
To:     Derong Liu <derong.liu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wsp_upstream@mediatek.com, Peng Zhou <peng.zhou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 Aug 2021 at 09:25, Derong Liu <derong.liu@mediatek.com> wrote:
>
> We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.
>
> According to the programming guide of mtk mmc host,it needs to wait for dma stop done after set dma stop.
> This change should be applied to all SoCs.
>
> Signed-off-by: Derong Liu <derong.liu@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..1dfd2842471b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2339,6 +2339,8 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
> +                       cpu_relax();

I suggest you look into using readl_poll_timeout() - as we don't want
to hang indefinitely, no matter what.

>                 msdc_reset_hw(host);
>         }
>  }
> --
> 2.18.0

Kind regards
Uffe
