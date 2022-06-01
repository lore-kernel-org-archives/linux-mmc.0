Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8948C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353109AbiFAMq5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbiFAMqv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:46:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DD6549
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:46:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i10so2611500lfj.0
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypan38TB2QoAzYWO+fMPZfJPmZAF9oC38F8TiawwsKI=;
        b=QKLl9jqzOPmCnoTtwZwwMFVM597CPkRIzsC7zl/r8egWnTpbQxRvlGisNM+FCgz6zq
         SzgGWfUjzldk9oesTJJ3pTNq2j0gQyWLBsTGI7TZsYGyzpEJO0skbzN8wwUT+JBhexmD
         QRHtDOHBCPRrU4J1Z7EQfEZFVmbIrGWPsvlqdv1bV2JnALQp4eu8vjDC7sdZBdvsuZx/
         Xqb1C1C7ULHIWYxfSuee1JQm+EMyl9Tg7gKE5IyXbcTgrVvTdj5a+6RPMNXcxsJRvU9j
         toEZm6RcHXYkeIEMDDh9JcsViH4cOfp337Zy731WcU6doRnwxz7AvaAtyGL736ULW/R3
         EMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypan38TB2QoAzYWO+fMPZfJPmZAF9oC38F8TiawwsKI=;
        b=N2Yv3bNIPfRlvn2AXinv/Sxsf1Y4d2eKhp8qob2pa/6q7uk1gnRe3FFO4jJGgVgnQl
         2fYOhcfx3d2pjCU8X6ac/2sOfNqmV8fYYu6urEmKL8DF7jfWLw3MOUaTaXrHHi5NQNYP
         oHTmB4GzGlVoLykOzLZOJhSNPFGSi9xCWrELyK7w7b5KnuBjzVqHcdikkXz8s+4HIvaU
         rgc4nlR42x6/ARyie42flduVqa0nxopIu85Yo/lMRzFiRv1LgpKv7zqBYqnCtME7LZD6
         f8Je6Nru6nHuglnpKVEj+p+elc+sx3j8HtyFufB9mDPivoDp9HNYf7RIrjVXRt3vcqFq
         ckIQ==
X-Gm-Message-State: AOAM530sRYCgvq/suaMEo5YPK1cp4AvEs+5qfmIIHFTVEl2pHeyu2c0n
        nIhsXvkJNGmYGDZjeXdE1SJWFdwUVZW5Te0nKgovJg==
X-Google-Smtp-Source: ABdhPJzsrIu9md7U7n1zgj7u1cLuExn4AAVdSQM0L62PSHkBkuz5iBlGUZBgl32ya7QNulKtLODAF2LpeKSeB6JV/Cs=
X-Received: by 2002:a05:6512:e93:b0:478:70ed:6dfb with SMTP id
 bi19-20020a0565120e9300b0047870ed6dfbmr33055330lfb.358.1654087608721; Wed, 01
 Jun 2022 05:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220523144255.10310-1-linmq006@gmail.com>
In-Reply-To: <20220523144255.10310-1-linmq006@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:12 +0200
Message-ID: <CAPDyKFrtNLRT8prMuVXx9RBVfVuj_yj=KTj9nHaUg0t6euxUDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: Fix refcount leak in esdhc_signal_voltage_switch
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        yangbo lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 May 2022 at 16:43, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> of_node_put() checks null pointer.
>
> Fixes: ea35645a3c66 ("mmc: sdhci-of-esdhc: add support for signal voltage switch")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index d9dc41143bb3..8b3d8119f388 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -904,6 +904,7 @@ static int esdhc_signal_voltage_switch(struct mmc_host *mmc,
>                 scfg_node = of_find_matching_node(NULL, scfg_device_ids);
>                 if (scfg_node)
>                         scfg_base = of_iomap(scfg_node, 0);
> +               of_node_put(scfg_node);
>                 if (scfg_base) {
>                         sdhciovselcr = SDHCIOVSELCR_TGLEN |
>                                        SDHCIOVSELCR_VSELVAL;
> --
> 2.25.1
>
