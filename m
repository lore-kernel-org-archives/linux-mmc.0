Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD5FC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BDF610CF
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhHROsh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhHROsh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 10:48:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179A1C061764
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 07:48:02 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c12so5594983ljr.5
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UmaovXnVmqDv/oCMxYwI2AhRfxNkF+Bsj0AIpnN1uFk=;
        b=VbZdcyCzaNRgw0tc2ZUkvURsPLxhWIdO1MPVCGRVlGJ/msXf5Zgx/QeZJ887VMmkoX
         aSWs7SevCyUa7jYW37NMWgsmNihbu1vHwu/u9yQ8ZAKQqaTkD0VTXHk9DZUmNDaGoYKf
         vU/3eAz4otbOmyssZIzzwk/A4ym8sBxHzpxMrk0pN/O/ZaV0tzI6maVrM5QiVMAYNJlc
         zIVDI/ijP5S10jwwB/TGf/5Y6smbfr6QnOVB9eOIoZwzqyndPJxxoIwsEdPDFrFSPeko
         dNBNvLgNCOZBBvuIaew69ppGk7hOxJSR0LsBrkzFeCJqDkt8X89kdrFVRQovSU5JEf49
         dtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmaovXnVmqDv/oCMxYwI2AhRfxNkF+Bsj0AIpnN1uFk=;
        b=KopGraDkVEeRYGQ9NrejAtrxmXLzSZB690QTu3AQZSesjEN4vWR8yK3I20y40jLAJN
         1ZDZx1G47EWW2EvgODeB6s5683pea7bxi9vi75sdaFrFQ3b4PX6+/rzLjfw8t7pkfJ3X
         jpslqMsi+qrKNxpu6pvifcWpZTr/ylZPHtM3SnZUdKXrRd9XzJktcFGTPtYWhSbsd3m8
         tzDlp+Q9a5ihPUu/ehnBTvLoV6JqpvIjGo+HT7gunMmzE7RLYqoD+91aPfrt/rmB7uTD
         H6Rki74+8Ob3XE0jWO8lgVgZeGXerN5sHxRNBgXEu7j9fXXPKVJeSNZoiz8AyeMJN4OZ
         jbsw==
X-Gm-Message-State: AOAM532ZdR53zWlytCVINVsRd/+cEsBCUHQ0KPTRaei2xSo5QQRZALdr
        sM1REgdp/BzFxSVJo40wtdJ9UdetSceBTgpjLSY=
X-Google-Smtp-Source: ABdhPJx/0jpBYqy7evFhHoUnrLr+UPBej7dLhblD8ydJOQWmdzPTrVYqMM8In3Ljpl6oNzehDH3S8Ue58YRyF0pTVCM=
X-Received: by 2002:a2e:9881:: with SMTP id b1mr8234118ljj.53.1629298080481;
 Wed, 18 Aug 2021 07:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
 <20210818051128.GA8550@lst.de> <CAOMZO5APotsBKPkN6tFDNnK0C7w7pzJ8zTWKUx6P=Rhd9_81mQ@mail.gmail.com>
 <20210818132800.GA6269@lst.de> <CAOMZO5AhZ04cJ8R5Twr+qff8jR2iO5qWufxLPnF7Qhi2=etcoA@mail.gmail.com>
In-Reply-To: <CAOMZO5AhZ04cJ8R5Twr+qff8jR2iO5qWufxLPnF7Qhi2=etcoA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 11:47:49 -0300
Message-ID: <CAOMZO5A=DgmGgqTWDfXdgoPgoH2XO68FS73RvwwK=3dgUAZyUg@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 10:37 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Christoph,
>
> On Wed, Aug 18, 2021 at 10:28 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Aug 18, 2021 at 06:31:19AM -0300, Fabio Estevam wrote:
> > > Correct, on i.MX7 the ath10k Wifi chip connects via SDIO.
> > >
> > > Is there a way to avoid the WARN_ON_ONCE(!dev->coherent_dma_mask)
> > > to happen in this case?
> >
> > The way to avoid it is by stoppind to use dma_alloc_attrs/coherent
> > on a device that is not DMA capable.
>
> Understood, thanks.
>
> Maybe something like this (untested)?
> https://pastebin.com/xTZqtRqD

Tested it on the board and this seems to work fine. I will submit a
proper patch.

Thanks
