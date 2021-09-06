Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ECC433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4247760FBF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhIFRLj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243840AbhIFRLh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 13:11:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5B5C061757
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 10:10:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c8so14548779lfi.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noINKmz3hzTGqq034jTZ5E+LdSOi2uYpC/Rle/66Vl4=;
        b=iYuhyd4uCzT8/2bOYiqWul/nZlbxsr1/PhzUk73eDC6N2l4dLguCZl2MbY01uzkgRA
         RbG+L1yM5kQiLZ3pmvpdIhRjJBRqnBNohvQRqQT5f/4IxftO5212RnLbyNyxomeQl1r4
         CY7+Y360ktzEFLIeLa4nSSw+fMsv8wixGi6JYB2AwTsc7yjcHeBazmWagk7Sd+oqZxn9
         7xxvydbz7tR3J+hjS3d9gRdPT9RbxBce8cRBPn1kkEL2cU4C3WlUjvgTiIbgrzWRV7Qx
         4NPpu9hltTXmywS3o97zRq+1YeB8PUdWLZKz4w0/MZR2JiX7yjgZk8jDSkxu7+AaJt8P
         hkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noINKmz3hzTGqq034jTZ5E+LdSOi2uYpC/Rle/66Vl4=;
        b=QCOi/zFjWGIqDf3xC1/VKAnBdmvTm1MGwMxVUKSWXwDuP9W4JnWsaYB0De9eXfx1oQ
         FquQOLcXrySKGVWsUJSityVMOdUjbZY1Twr3GdYMexN/O8F7DpgcvijlsI1m5yrbUOsb
         jQbComM9/FKg1C1w2WeBriCV6UhWOQ+iB4kDC2LYS3uLJcxZRaj6EPwTOvU0lAi0BoVy
         PC9uJPylPToGMxBZYbK5hwhvrsJmi4FA2o9DWh2hi7sJyQz5yXD1jzrgY3SQ4beSEZE6
         kcoUBQO6GT9Unc3UdZ6y1g/y79vlU5/ltvliS0VbYrXnxsWV6H3VN5qgTswtFsOyc3Sw
         Yhsg==
X-Gm-Message-State: AOAM530y5iE4LIRPI5ilKe2KRHico66W95mjCAAFMZBKMwMPL6JwFE7d
        B9uVYsYmcFtFVu9SRsJ7JKUARTWQTSN04pW+7gEpgg==
X-Google-Smtp-Source: ABdhPJxlhFOEzJRlkJCRsUZZ2Q4TuaOmHRL8uGNY7RMU3fpBcQJG/A6CDs3tVr/JkHXbcvF9vj/fRKk5UtWSuPkrEEo=
X-Received: by 2002:a05:6512:3ca5:: with SMTP id h37mr10177779lfv.254.1630948230961;
 Mon, 06 Sep 2021 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210827071537.1034-1-derong.liu@mediatek.com>
In-Reply-To: <20210827071537.1034-1-derong.liu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:09:54 +0200
Message-ID: <CAPDyKFpubTas6HMe=uzqJyQuQS9TRnDGuGjaS80ymjevN_CFMQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: mediatek: add wait dma stop done flow
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

On Fri, 27 Aug 2021 at 09:15, Derong Liu <derong.liu@mediatek.com> wrote:
>
> We found this issue on a 5G platform, during CMDQ error handling, if DMA status is active when it call msdc_reset_hw, it means mmc host hw reset and DMA transfer will be parallel, mmc host may access sram region unexpectedly.
> According to the programming guide of mtk mmc host, it needs to wait for dma stop done after set dma stop.
> This change should be applied to all SoCs.
>
> Change-Id: I9b87523f19b24ca73958bbcb83bb418413c5a180

I am dropping this tag.

> Signed-off-by: Derong Liu <derong.liu@mediatek.com>

Applied for next, thanks! I guess we should also tag this for stable
kernels, right?

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..b99330bad6a5 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -8,6 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/ioport.h>
>  #include <linux/irq.h>
>  #include <linux/of_address.h>
> @@ -2330,6 +2331,7 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +       unsigned int val = 0;
>
>         /* disable cmdq irq */
>         sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INT_CMDQ);
> @@ -2339,6 +2341,9 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>         if (recovery) {
>                 sdr_set_field(host->base + MSDC_DMA_CTRL,
>                               MSDC_DMA_CTRL_STOP, 1);
> +               if (WARN_ON(readl_poll_timeout(host->base + MSDC_DMA_CFG, val,
> +                       !(val & MSDC_DMA_CFG_STS), 1, 3000)))
> +                       return;
>                 msdc_reset_hw(host);
>         }
>  }
> --
> 2.18.0
