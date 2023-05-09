Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9AC77B75
	for <linux-mmc@archiver.kernel.org>; Tue,  9 May 2023 09:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjEIJ37 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 May 2023 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjEIJ3u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2023 05:29:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C356EF2
        for <linux-mmc@vger.kernel.org>; Tue,  9 May 2023 02:29:48 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9ef06cb784so7258695276.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 May 2023 02:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683624588; x=1686216588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIuHokypvWm/IYbI4WWTbZbJNrdYy9622yc37Rs0HcY=;
        b=D9fDFwqsVuqVXdUmjfM20BJDxU0MKubgg7ROKoxXzbJKbbvYVl3ZqjVNH7TqqSDpO/
         NeV7IRmJtHQ8S8woeCTqU+k34DbDwTzLHRVpYyfwYln2WLkx4IFGKJ2FYT948a/d8Evb
         KWrYlIYmt1NUvXYJAAU3tWHofuZOK+1QuBm9cfiw3q7aVU8hzZxImVH1pYq9U+9aJIQ+
         5wazl1lybJjUgMTcO84ymoDQVg0ffm7ox9UKNd2NHAvDmcnsZ1zlFlCKofci8wIPQ6Xz
         m842mLMeYBXMvryFh2Np0oZgxpBf8aI9Y4xW/mOOfsYLxXU2ylu6LE6PRnsEEV1r75Ij
         42fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683624588; x=1686216588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIuHokypvWm/IYbI4WWTbZbJNrdYy9622yc37Rs0HcY=;
        b=bviHWLoheaOtwqCSvuMTYIa4QcmZQsNdD1+PGi3vwCCvwupK3LXJa/CDSth5ZTZZhs
         h3wWopXFqkuVYRk+gWCSbYldM7g/5VUz7FN3QrnTtdyq2gI88oSj9fmfbSNEVWAhbzqz
         u9IKPQxSIXxN1S2JjnR2DvyQIwxQXyZNAKTTsLUyt83VAEC+OX4pIMFyHpZzQjK8lWP5
         GlIDBHQY4t1AEA3KTuuo/cCoVAjuppDecpqc3Od+ztqArpi7N1R1HAAERqdMKm44e/BW
         ltZORSVdeT0M6kAvKHiR4sJBJqZDlk3PBBXCNUE71BFgHwmLi9SwQtqTaqGEoW5YBbjC
         PArQ==
X-Gm-Message-State: AC+VfDxT/f0cwEvnUxxdPPQJEdOvW4hM++A2mS8G3fHfgMCdR2pl3oXk
        y0HgLE7N+UNi6YuXlLbk2xZIf/vidyNNk4BvxF2ejQ==
X-Google-Smtp-Source: ACHHUZ71iTfkcXGJZvdKmvPuaTPkPvF22/hZesnDPRnZh7PA7OSLKjrHtHGb839UQSzfT9m9mHIG92NLR6Wn6pkkz4U=
X-Received: by 2002:a25:dc43:0:b0:b92:388e:d2f4 with SMTP id
 y64-20020a25dc43000000b00b92388ed2f4mr12985810ybe.24.1683624587954; Tue, 09
 May 2023 02:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230419063048.10516-1-wenbin.mei@mediatek.com>
In-Reply-To: <20230419063048.10516-1-wenbin.mei@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 May 2023 11:29:11 +0200
Message-ID: <CAPDyKFreikcPGVyhbrfU6LA+fATiA6M5M-5H6EhEHU3DbjkNVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: reduce CIT for better performance
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Apr 2023 at 08:30, Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> CQHCI_SSC1 indicates to CQE the polling period to use when using
> periodic SEND_QUEUE_STATUS(CMD13) polling.
> The default value is 0x1000, now change it to 0x40, which can
> improve the performance of some eMMC devices.

Rather than just providing hexadecimal numbers, would you mind
explaining a bit what it translates into?

For example, "the default value 0x1000 that corresponds to x ms...,
... lets' decrease it to 0x40 that corresponds to x ms".

Moreover, it would be nice to have a comment in the code too,
explaining what 0x40 translates into.

Other than this, this looks good to me.

Kind regards
Uffe

>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index edade0e54a0c..483353ea3a99 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2453,6 +2453,7 @@ static void msdc_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static void msdc_cqe_enable(struct mmc_host *mmc)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> +       struct cqhci_host *cq_host = mmc->cqe_private;
>
>         /* enable cmdq irq */
>         writel(MSDC_INT_CMDQ, host->base + MSDC_INTEN);
> @@ -2462,6 +2463,8 @@ static void msdc_cqe_enable(struct mmc_host *mmc)
>         msdc_set_busy_timeout(host, 20 * 1000000000ULL, 0);
>         /* default read data timeout 1s */
>         msdc_set_timeout(host, 1000000000ULL, 0);
> +
> +       cqhci_writel(cq_host, 0x40, CQHCI_SSC1);
>  }
>
>  static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
> --
> 2.25.1
>
