Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26372C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDD06124B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhFHNTt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:19:49 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:33466 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbhFHNTs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:19:48 -0400
Received: by mail-ua1-f50.google.com with SMTP id l12so11582146uai.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55gewmxEVl3ZVcwS6O9solrcdE7rmPK2jzo+kIX4FD0=;
        b=neZDyHARxr5BeNCs1zq64t5POX25ZtuJhEptT293O/1LdcMw2/r7jM3W4KZ29UAvDe
         3lOuwMyvZbLu+jLD5aJOeD/Ffh3UZnANgVPgJuSxNl3nqfi/UBIBneEougweUCAFb15s
         Q3ZtswmAZXSRj9OvAPLVcobj6RJyCpKdc8s/DXQwCzVfQIAoo419SBDgeIIDLMCDdvRa
         qBhyEgolrH0WTYWGZcUJMst65cdj5fTxYUiON1/pinvoQzQt1D02YO31Ds34NTh5cL+2
         v1UEokE6axgWPhiaNeHzbDpEqa+yuBQss1TIqei9rVbMaSW71CAdP349r4bL9aPVZIUA
         TDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55gewmxEVl3ZVcwS6O9solrcdE7rmPK2jzo+kIX4FD0=;
        b=p8a63yyaU0VTlaa9TqS3ftYpdT1RNcR8tt7a8GRH2s1Az/I+U8MqDLtxMB10hyKYfj
         1zMy1YtIYpHmMJhmC81zgX+AaamzKmgmFb/xe9hMttVcBMUJNPnhDiUuYiIt6Hl7IHGb
         6jo53YNt3PBWyTzl+biwgomkqs1Pz+P+bzODb/RrH876QyRAnvngV1eqpGeU3Lq2wPCf
         qbIA2LtxkkneMQqQ5gCvuOAd2AD9L13C1G2JYaurhV4Gbi6e0awpb99ny6aGv/jJDyQ/
         KVfEvnXjD0HieYXQMKwag3qM90sW7J/JlSfSt3XZHcTWij+UejO19LX4TDVmZIMpbng1
         Rekw==
X-Gm-Message-State: AOAM533Gcc8TWfQiERYvjU6Vxf0ZbU+49O5UrPlpKMm6Ww/fW8tt609K
        SxC/VLEQBKZ4MlyYGook/lS/ssg5Z/aMLQJ+h7rykQ==
X-Google-Smtp-Source: ABdhPJy6odpm9e0WdZi5O6ao3QWO6eK4K6fn+yzP4auEjAWP5zDPJ0u6N2tJXgGh8Q6s/WG/tNXLav/XYUY+CJHagq8=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr12673740uak.19.1623158206210;
 Tue, 08 Jun 2021 06:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com> <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:09 +0200
Message-ID: <CAPDyKFoSsLxg-6cFXc+Lapbz5bGCJ0xzpE5H8VrLfFSMfrn8zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-sprd: use sdhci_sprd_writew
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Jun 2021 at 11:54, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The sdhci_sprd_writew() was defined by never used in sdhci_ops:
>
>     drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 5dc36efff47f..11e375579cfb 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -393,6 +393,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
> +       .write_w = sdhci_sprd_writew,
>         .write_b = sdhci_sprd_writeb,
>         .set_clock = sdhci_sprd_set_clock,
>         .get_max_clock = sdhci_sprd_get_max_clock,
> --
> 2.27.0
>
