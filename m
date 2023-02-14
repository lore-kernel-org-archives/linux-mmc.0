Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F46C05027
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 12:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjBNMTG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjBNMTC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 07:19:02 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460A265BF
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:01 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id j184so5091296pfg.10
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cAUnKTSg8HM8rsQy6BohzZgXbeIp3TlhBYPt31b6Ae8=;
        b=dOntUdoPt4KtjO0xRQ2RJOCldhDjTb/BgVsjm0cRpeaQfzpHwJTN6OYB8L4CrdiMCQ
         yOpuMfp0GMQWzi0aQ8h3XAiIo9YDY66wC0uIRsSZLPpalct3zuKSLTLt5uw3c+vRoIi6
         kZWT2VWDlSMAOKNx8rxW1MCuGOqdAdmD92ly68a5Vh3EW89eTmiJsQF8UfFRVuC8eQby
         rC2rhBmwnfLE2FiYcCPRBmDiB3jCQGYpt4IvJpd1AOjZ11+kVI5KoJczR8VLE3UAEVhW
         vM9VvXxDniGthC55iHe1bua+Ye6IuK26rR1Y+wLSIOVIkPJF710XacfG2rDelFY6A1mZ
         T0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAUnKTSg8HM8rsQy6BohzZgXbeIp3TlhBYPt31b6Ae8=;
        b=R3970VckRp5xalsFkLgE7ahMXMXiuy6jjc3tEOZvlBv7x76zUyrXRHdnDydyoOEbk4
         jLPcdyWcKXsZQ7XFmAiP2bZKA092E6sD82FYjkpk8lh1c0q1qymNDH7EP09Guv0dzExi
         gqzOBxeBn2z5pj6BW7S67f/zHAKHUD/2DqRKO6bVgBHq/8PSagFS5Ic2wOach3gcLaG4
         0zbleON0d0VGQbcIRiokQh2zYgYffo1xhzvVOfDUjrlTAyNx+BnmHPACqSnLhOVpebVY
         O/9MSTzx0PTa9bjWZuA9exUIGjVhmROw6xm/KctraP6BZtC7NCD+ycdbrEpUSyAKGZFs
         Iw/A==
X-Gm-Message-State: AO0yUKXK6qSaTGgqSW1/S41EdECR1TL6pGkwCnuyScJkxnVM3qDXvQY8
        W23JQv33qocwUXOFlXZG/P8YchHRmFAoY3Jr73u7o4Hj6WV3vg==
X-Google-Smtp-Source: AK7set9vWN7YaYkuFsDNMiCF06DKol561mu12vcAVC+pKP2ioHYPeoRdHu7RF0E9LWcWOIPCTNRnxFRrd8Ct+QwGlKs=
X-Received: by 2002:aa7:96fc:0:b0:5a8:bc1e:dea3 with SMTP id
 i28-20020aa796fc000000b005a8bc1edea3mr358646pfq.56.1676377140832; Tue, 14 Feb
 2023 04:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20230210143843.369943-1-saproj@gmail.com>
In-Reply-To: <20230210143843.369943-1-saproj@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:24 +0100
Message-ID: <CAPDyKFrARWb33bH0L7PsmcKN-BWVY5iWott1+EXUPMY_aT1nxg@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: set maximum request/block/segment sizes
To:     Sergei Antonov <saproj@gmail.com>
Cc:     linux-mmc@vger.kernel.org, jonas.jensen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Feb 2023 at 15:38, Sergei Antonov <saproj@gmail.com> wrote:
>
> Per datasheet: maximum block length is 2048 bytes,
> data length field is in bits 0-23 of the Data Length Register.
>
> Also for DMA mode we have to take into account rx/tx buffers' sizes.
>
> In my tests this change doubles SD card I/O performance on big files.
> Before the change Linux used default request size of 4 KB.
>
> Signed-off-by: Sergei Antonov <saproj@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/moxart-mmc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 52ed30f2d9f4..2d002c81dcf3 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -611,6 +611,9 @@ static int moxart_probe(struct platform_device *pdev)
>         mmc->f_max = DIV_ROUND_CLOSEST(host->sysclk, 2);
>         mmc->f_min = DIV_ROUND_CLOSEST(host->sysclk, CLK_DIV_MASK * 2);
>         mmc->ocr_avail = 0xffff00;      /* Support 2.0v - 3.6v power. */
> +       mmc->max_blk_size = 2048; /* Max. block length in REG_DATA_CONTROL */
> +       mmc->max_req_size = DATA_LEN_MASK; /* bits 0-23 in REG_DATA_LENGTH */
> +       mmc->max_blk_count = mmc->max_req_size / 512;
>
>         if (IS_ERR(host->dma_chan_tx) || IS_ERR(host->dma_chan_rx)) {
>                 if (PTR_ERR(host->dma_chan_tx) == -EPROBE_DEFER ||
> @@ -628,6 +631,8 @@ static int moxart_probe(struct platform_device *pdev)
>                 }
>                 dev_dbg(dev, "PIO mode transfer enabled\n");
>                 host->have_dma = false;
> +
> +               mmc->max_seg_size = mmc->max_req_size;
>         } else {
>                 dev_dbg(dev, "DMA channels found (%p,%p)\n",
>                          host->dma_chan_tx, host->dma_chan_rx);
> @@ -646,6 +651,10 @@ static int moxart_probe(struct platform_device *pdev)
>                 cfg.src_addr = host->reg_phys + REG_DATA_WINDOW;
>                 cfg.dst_addr = 0;
>                 dmaengine_slave_config(host->dma_chan_rx, &cfg);
> +
> +               mmc->max_seg_size = min3(mmc->max_req_size,
> +                       dma_get_max_seg_size(host->dma_chan_rx->device->dev),
> +                       dma_get_max_seg_size(host->dma_chan_tx->device->dev));
>         }
>
>         if (readl(host->base + REG_BUS_WIDTH) & BUS_WIDTH_4_SUPPORT)
> --
> 2.34.1
>
