Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63679C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4787560551
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHRJc3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhHRJcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 05:32:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6B0C06179A
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:31:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d4so3255953lfk.9
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wmQN792uFgFwDPkYKICfghT+PGaqiPbjvKiK6teih0=;
        b=J3ffQfSz815Sl/K2kVpavtqXUgSJMbtn45l+4vReQpa373AEvxxu60Wtzj9pA5pXnL
         qHzgSA5qXvtbXpJPbLkgZ1VWB5CrlI87UYCrXvuQHkitf2JT27wLHrZkrJvrbcnyuels
         dHrA/3gkXXMLard7viT9yVXv5qV9iZPXAFne66qnjV0mtSz8HMeDmUg6y9oBtDtucKHJ
         vpPdYPQ9OSBtIgTta7Hecmzhf+0/6iTZxBfNXuBleAnSZVC39D9ZsbeOh4Q6HBw8qsrf
         8g5IaE2yNRQ6sj4bQPjRAqM3hS8z7eM6BauqazauNEwiRG8y2dOAc/yM13vIG0whE8om
         uDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wmQN792uFgFwDPkYKICfghT+PGaqiPbjvKiK6teih0=;
        b=ehzWVDWsfJ6A9ujqiBnwFMRHQAMnAamqVEKvmKGK6+gt1Sc41pWV3WWwN4kM9VSV/o
         fliH1smL4xEQBn/uSll8Zp4+sL4MOPvhCjQxB0+cTNcAV5JSq4I7e9z8tIRBV0Xd9iDO
         Dc701+KYv0CXgJc0Fcm7iHzVjlTdwNGIyhOJyYCB+h68qVTQHfMgXGPlcL0fwS15kr4I
         LTPRTCOFDPa40I6QgfEb+CKMRkTsLy1xOhoYPoq31AJdECSN82YgChqJYduNCiAh9Fyp
         XI7xjtX6AeXUzvDb3/ftOHYFj1NT/7+mcmmgOA9/iOng/BpE9P3bw6bhgdkZ2nrNVTBC
         Dbzg==
X-Gm-Message-State: AOAM533zrGwuTRJCb0GZEL1yYrrbQClwMlaCjbJtDBpk730sFwSwoq+B
        O967n4DB6CjL77Z0d28+IQtSbZ3EhkBSBEQRw2U=
X-Google-Smtp-Source: ABdhPJyikDtMGvKyVnc45taFTfJj1oEPhPKdNlXutYXnPrZDkPCod8zxHsvhQuvl010X7S2A7Ny7lB+Yx5D9xnVNkmg=
X-Received: by 2002:ac2:4143:: with SMTP id c3mr3056876lfi.295.1629279090855;
 Wed, 18 Aug 2021 02:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com>
 <20210818051128.GA8550@lst.de>
In-Reply-To: <20210818051128.GA8550@lst.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 06:31:19 -0300
Message-ID: <CAOMZO5APotsBKPkN6tFDNnK0C7w7pzJ8zTWKUx6P=Rhd9_81mQ@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 2:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 17, 2021 at 09:23:26PM -0300, Fabio Estevam wrote:
> >
> > void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
> > ....
> > WARN_ON_ONCE(!dev->coherent_dma_mask);
> >
> > Where should the coherent_dma_mask be set to avoid this problem?
>
> Looking at the ath10k code ar->dev is set by ath10k_core_create, which
> has multiple callers.
>
> For ath10k_pci_probe it is a pci_dev, whoch should always have a
> dma_mask.
> For ath10k_ahb_probe is is a device tree probed platform_device,
> which should have a dma mask.
> For ath10k_sdio_probe it is a sdio_func, which from my understanding is
> a virtual device can't do DMA itself.
> For ath10k_snoc_probe it is a platform device wit an explicit
> dma_set_mask_and_coherent and above so the dma_mask is set.
> For ath10k_usb_probe it is an usb device which can't do USB
>
> So unless I misred the driver you're using the SDIO or USB variant,
> and those are not allowed to just call dma_* functions on their
> respective devices.

Correct, on i.MX7 the ath10k Wifi chip connects via SDIO.

Is there a way to avoid the WARN_ON_ONCE(!dev->coherent_dma_mask)
to happen in this case?

Thanks
