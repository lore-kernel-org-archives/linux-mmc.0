Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB96DC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F27B64FCD
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhCKLRY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbhCKLQw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 06:16:52 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63561C061574
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:16:52 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id o85so392961vko.8
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZlTrXOnOwfkVp4IP+6nAkc4tSWReJL+ojzi0R++f14=;
        b=xrOn/2AKy55jqABo10rEGgLvClD7szNkoniXPhLeXJUNxBz14KRCkhNuBuTK/n0m+J
         YIi1Qciy9nId57iyQvOBmaRw8BWKGQpOgqDw6b247nCcQPDZ+0jUUqhBv2vor5owjxvg
         KavAo8XUIPX4rxVNtrsJLpFvv03n33leykXMBTOyuGWFFEyWm2iTnWuo54IRHtAWPPhl
         ERzfHqRVlmpaXy8pFDFI0LfE6d0+FMZfx+AMXwRkSLYw9nxdUO4rv8XMlgatcdXxtENs
         702STHHQ5SHW0GUUe5+s16ifoQY5cMsjaP3EOmx29K3dEY/b6uQ0r60u7CQ9WgOwUmYI
         16VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZlTrXOnOwfkVp4IP+6nAkc4tSWReJL+ojzi0R++f14=;
        b=IwGA9qF2qB239Wva2PIi6ru6wYNpWlyQBSitgx7laY/42bN6jnaM9dOX7XMLnaaVx0
         kpohOvdqHZzCHqX+eLc1VG5QdnwN4/zZwHqHStU0UNBH4Ffw0/HeOP65n8wrWzKZf2OP
         0D4o9g47Bmp410wvJdJOyRLbbExMnMmtPH7hVbGymQa8NeI+IJATb8V+87lRssxKNkdA
         5f22XYZQ6JDRFAxD8tJaNWDNtwTXVRnPaGXdtCD9PrRnNqpF8Ft816Hgdwiq1GnF/6CH
         9W2wbkYgpmIl97U2VJhS1ZzWE9HM4Shd2Ky5DX7scY1I/jNh+8FdNACe8gjwyIl+MFCi
         yvrQ==
X-Gm-Message-State: AOAM5301dffZ64tIibimk8PYTuILOV3vT7/3BjwSMKo4OVixQWsKvuvj
        4BuqoAf/oV238coDLWhvhlbUSeJvfzN4S39/GJWEAw==
X-Google-Smtp-Source: ABdhPJx5nD6+VY6q0OnqOl5s6XOx0kkRXFk6bupUgXJA2Srnp0YddIeGztSISa7PYxcs9vXwz90f3elk1mnLlhqIrg0=
X-Received: by 2002:a1f:a68d:: with SMTP id p135mr4384673vke.6.1615461411571;
 Thu, 11 Mar 2021 03:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20210309015750.6283-1-peng.zhou@mediatek.com>
In-Reply-To: <20210309015750.6283-1-peng.zhou@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:16:15 +0100
Message-ID: <CAPDyKFpsw+s7Bj0h-oOHP7VkiDoeuoN7e5e=rpQ+_yo2G=R-YQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: Mediatek: enable crypto hardware engine
To:     Peng Zhou <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Wulin Li <wulin.li@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Mar 2021 at 03:05, Peng Zhou <peng.zhou@mediatek.com> wrote:
>
> Use SMC call enable hardware crypto engine
> due to it only be changed in ATF(EL3).
>
> Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 1c90360d6cf2..225ef5519161 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -4,6 +4,7 @@
>   * Author: Chaotian.Jing <chaotian.jing@mediatek.com>
>   */
>
> +#include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -20,6 +21,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
>  #include <linux/spinlock.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
> @@ -319,6 +321,12 @@
>  #define DEFAULT_DEBOUNCE       (8)     /* 8 cycles CD debounce */
>
>  #define PAD_DELAY_MAX  32 /* PAD delay cells */
> +
> +/*--------------------------------------------------------------------------*/
> +/* SiP commands which used for crypto                                       */
> +/*--------------------------------------------------------------------------*/
> +#define MTK_SIP_MMC_CONTROL               MTK_SIP_SMC_CMD(0x273)
> +
>  /*--------------------------------------------------------------------------*/
>  /* Descriptor Structure                                                     */
>  /*--------------------------------------------------------------------------*/
> @@ -2467,6 +2475,7 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
>
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
> +       struct arm_smccc_res smccc_res;
>         struct mmc_host *mmc;
>         struct msdc_host *host;
>         struct resource *res;
> @@ -2616,6 +2625,15 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 mmc->max_seg_size = 64 * 1024;
>         }
>
> +       /*
> +        * 1: MSDC_AES_CTL_INIT
> +        * 4: cap_id, no-meaning now
> +        * 1: cfg_id, we choose the second cfg group
> +        */
> +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);
> +

No, I don't want generic arm_smccc_smc calls in generic drivers like
this. Moreover, shouldn't we "probe" the firmware to find out if this
is supported and ready to be used?

Perhaps something along the lines of what Qcom does in
drivers/mmc/host/sdhci-msm.c and drivers/firmware/qcom_scm.c?

>         host->timeout_clks = 3 * 1048576;
>         host->dma.gpd = dma_alloc_coherent(&pdev->dev,
>                                 2 * sizeof(struct mt_gpdma_desc),
> @@ -2770,9 +2788,18 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
>  {
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
> +       struct arm_smccc_res smccc_res;
>
>         msdc_ungate_clock(host);
>         msdc_restore_reg(host);
> +       /*
> +        * 1: MSDC_AES_CTL_INIT
> +        * 4: cap_id, no-meaning now
> +        * 1: cfg_id, we choose the second cfg group
> +        */
> +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +               arm_smccc_smc(MTK_SIP_MMC_CONTROL,
> +                             1, 4, 1, 0, 0, 0, 0, &smccc_res);

Ditto.

>         return 0;
>  }
>

Kind regards
Uffe
