Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A11C11F6B
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCE161D5E
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhF2PMF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbhF2PMD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 11:12:03 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07966C061766
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id f34so8492099uae.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWnyvaCFYrQUvUf/DppyzuRMkB2N+0Lh3KJRoVipZ24=;
        b=vqoVo5UI+V43vKQ8qbyO4O/K/xl3pebszcvw5em50U51NIRcoB2sAxcrVlxPPr30Cv
         8yP2Spsdk7oqeGV6rtB9Kxc0h4h2SAMyGZiIZs1Nncz+aZWpoJ19wth8nuUbbqE9P25L
         TByfixycf4Xn0993xNiVWkTV1fdRtBpu9ad4kC5rBK4dVzMFJfcexcWT7sLj789GcMO/
         dgm2FbOgOEOwyfvdY1M+CXWKTc/QP2AabI/3wX5S117giilCFSKfZCTpmCH1EdkW8tRX
         cB4j7vfeZX+B7EWJoa55JXKqrpLsuciTPVu2iHNwFhTRNcmrwWptjZBuk4/gawtRHqMn
         vDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWnyvaCFYrQUvUf/DppyzuRMkB2N+0Lh3KJRoVipZ24=;
        b=X7NODlFBiWnbo2iByAqjv0WnEFfg57NC/MnzbflnWnuYpCJU+H4w54hQxluacNvuHE
         b9yBNmBvVHhCiZFsNqJQxnvsYKx1Z3yNO3UjZZUorjxmS55bpf7A+M9cZTFfQWEIuaiL
         M2Gqf1buoLVhUSFVwPmsLg1uQDund5JEgPkrwDt1llqplTGdRkoimjmt2tLSam1YqZQH
         3hSVr9MUSqEXHczCClQNR2kuaAgcWW1NBwj2np4pbDXcRAcCeNktwxA9MPk2x+P8Dy6d
         Wr2FGbWFDaO+pJNbHNNiC8hi572XIzj0Il5SlRNhHRN/NvNHpu7eVNC0EDhxQh/wv+Ws
         EPhw==
X-Gm-Message-State: AOAM5328K8yxUFD6FsnfmFL1Aw+StR64ewGBUE5/KX1gzRP0pU4a+iN2
        6MyO/AaYgct/3IVZwAlDk6U3KyGEW//zmUl9oMTbxg==
X-Google-Smtp-Source: ABdhPJw4PLuYCh019JddZ2xmj3gq5hMooToY9sbdhNG5LzAFJ8NBGRt0DRgvO6olgaNzg+NxuxFSxx2ZyaGg5g9n06E=
X-Received: by 2002:ab0:6296:: with SMTP id z22mr3693991uao.129.1624979375207;
 Tue, 29 Jun 2021 08:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210611101948.18972-1-tiwai@suse.de>
In-Reply-To: <20210611101948.18972-1-tiwai@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:08:58 +0200
Message-ID: <CAPDyKFqeXERLc9=p79OVRjUfC+BM_5JqOWS+6Riuu0YRwvWOtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Clear unused bounce buffer at DMA mmap
 error path
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Jun 2021 at 12:19, Takashi Iwai <tiwai@suse.de> wrote:
>
> When DMA-mapping of the bounce buffer fails, the driver tries to fall
> back, but it leaves the allocated host->bounce_buffer although its
> size is zero.  Later on, the driver checks the use of bounce buffer
> with host->bounce_buffer pointer, and it tries to use the buffer
> incorrectly, resulting in Oops.
>
> This patch clears the release the unused buffer and clears the
> bounce_buffer pointer for addressing the problem.
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> v1->v2: correct the device pointer to mmc_dev(mmc)
>
>  drivers/mmc/host/sdhci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bf238ade1602..c80bc6c4ebf3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4072,9 +4072,13 @@ static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
>                                            bounce_size,
>                                            DMA_BIDIRECTIONAL);
>         ret = dma_mapping_error(mmc_dev(mmc), host->bounce_addr);
> -       if (ret)
> +       if (ret) {
> +               devm_kfree(mmc_dev(mmc), host->bounce_buffer);
> +               host->bounce_buffer = NULL;
>                 /* Again fall back to max_segs == 1 */
>                 return;
> +       }
> +
>         host->bounce_buffer_size = bounce_size;
>
>         /* Lie about this since we're bouncing */
> --
> 2.26.2
>
