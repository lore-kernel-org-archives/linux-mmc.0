Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42382C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274E360238
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 13:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhHRNia (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbhHRNi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 09:38:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71499C061764
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 06:37:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y7so5213683ljp.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qeLGhEUm2fqgovV3rHdwAwD0qbiDIwzIYXkXiw7KcI=;
        b=LhxiOQshZXAVof4f5rqnjQLm1KQIm5vTmoKpi/0oapO0FdwcTl2MJY9O32zPww5FY4
         z8ZLU4nJghZGEK5540OQa05FGdXHM3oIy/6q+f8HGOZBf72gXKjxf2FNjmJ5/+PNtgBW
         IeNbyQOk9p8gHV/hfTLlPoXS13s++P9YTq2QtSjjrgGFdlCQrjxNp8ELROeAkAmHqhvE
         YgZw7jBTblHAZtqfQ/cPCPGKtN8VFMZlkTVeMouUXx676qrjG6/DgPcV42MaQB+f6MPD
         Xd15laChSDYtS+gjRRc0P7EwQmrmXDR3drsvyknrSbTbXxq+ikKxedq8Khhwn5jCkTz9
         t7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qeLGhEUm2fqgovV3rHdwAwD0qbiDIwzIYXkXiw7KcI=;
        b=VdnFssxx7fU950bj+mNzD+JpD26qm/an5Ni3wNYc52Fe/FnIe3w+dxl43QF4DzKEKd
         wHAgq+a+OjGuxFrcAB0NYhLdIDNGlbRSEHZxI6qpiYmCCy0mKiE4KedfDEsbbSMrnK7j
         0ec/mfGaLZw/R9uGs/KnOVKXBa8IedmEzj1Y+FCt6A7/Zk38Ex8/YxpRrK7TeuffRY5f
         B98MONTQ3pWr5vQuR0CUrehJeuuppYy9xWn/5w1nrT89bBVxng4nMyW5ZxJuNyfYoGav
         w4raa93sOhsVso0GwcKWlTIiXArVwXCN85w8AzEmaucJOZXEbzS9KAo4kzwSBJEI2Hvi
         4WNA==
X-Gm-Message-State: AOAM5313y99Q1fx1eUeDFZq92iwUFeWWvcCnq5HZoZJDIP6+fLAYcAVz
        UGTlfG4kUvSBKN7oUdZ91MTh2z1fKaQ1ZoXVd9c=
X-Google-Smtp-Source: ABdhPJwTzY5tBpkyYYpCo95/ARt0AoceuxAfd2DiomIfbbVKrZPxVhvjT0+HD7+hzfBi/eQjS5pnyzy7LmcuJses120=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr7916970ljh.264.1629293869832;
 Wed, 18 Aug 2021 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
 <20210818051128.GA8550@lst.de> <CAOMZO5APotsBKPkN6tFDNnK0C7w7pzJ8zTWKUx6P=Rhd9_81mQ@mail.gmail.com>
 <20210818132800.GA6269@lst.de>
In-Reply-To: <20210818132800.GA6269@lst.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 10:37:38 -0300
Message-ID: <CAOMZO5AhZ04cJ8R5Twr+qff8jR2iO5qWufxLPnF7Qhi2=etcoA@mail.gmail.com>
Subject: Re: imx7: dev->coherent_dma_mask NULL warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Christoph,

On Wed, Aug 18, 2021 at 10:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 18, 2021 at 06:31:19AM -0300, Fabio Estevam wrote:
> > Correct, on i.MX7 the ath10k Wifi chip connects via SDIO.
> >
> > Is there a way to avoid the WARN_ON_ONCE(!dev->coherent_dma_mask)
> > to happen in this case?
>
> The way to avoid it is by stoppind to use dma_alloc_attrs/coherent
> on a device that is not DMA capable.

Understood, thanks.

Maybe something like this (untested)?
https://pastebin.com/xTZqtRqD

Kalle,

From an ath10k driver perspective: would you have any suggestions as
to how to stop calling
dma_alloc_coherent() for the SDIO and USB cases?

Thanks
