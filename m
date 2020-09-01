Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1118CC433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD49620767
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjZj6y+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgIAPhC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731308AbgIAPg4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2020 11:36:56 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53391C061245
        for <linux-mmc@vger.kernel.org>; Tue,  1 Sep 2020 08:36:55 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z12so550803uam.12
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2020 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1B9nLNVLY42WxzWWaQLkKFC09iT2uTznxSa/7Ga9+ik=;
        b=EjZj6y+TjUP2e0zRcKUUQvE66STizixCKC/KAIDXV/69rk8mNQSfWyAU6WYWSKFuzu
         YdysqzXgzI2xtpYHzb6Bg9vJ2avPXngJVilLH84994hthxQshimmjhHojPFW896ik/4d
         7+SfIVuVuc/ZxqJXQpx6oVzAu/cP4B59SJR8lGPID+5gG2w4v4nOMnEQcQrCru633HNP
         zuDN+/5pNOLV30vak4kZQMnpd+VUgw2bg+XdxSwnEBkVo/zJgSOy5ArWNiN7cmol12Bb
         IqdXYacCg5YMcR4+mn8aBUmFtkx7PyrkYdutuPTIGu4pnVnQseXCdI/TJgx4fELy5snC
         I+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1B9nLNVLY42WxzWWaQLkKFC09iT2uTznxSa/7Ga9+ik=;
        b=Hueo9iN7eeUlpWKhki5H4w9Zp/sKNRVELazclm1F/N3pLFOEuVgbgdRk+/aPHgDXgu
         CSXcdtIhHNhWLli7Vw7C2KZxioww2jhDnKBomMPbGdxxfEcJHRRH28a2/MDYH0DMwtiO
         uPuqNBsEXOEnjYHoiskKtgXlr7cxL1STSZTSBhS6uREuTzJbkeVcYV7PORZNZAXh9tB2
         c+o6QnEPWzDQC3h/PMNS3hTwYKDmI3IJLV+VazQ2+pds0pZuM1N1mCSCoifCu+mVSFv8
         WDs9eWhooRJUuXd83eYP3JnTUtzbRRUFhRwTd+/e16KKx46NLOoYcGBzKlI73ljbJn3n
         dcMg==
X-Gm-Message-State: AOAM530JzQ5mBZTX1xT8jrzq8czM5B06MKlMX99kdHI2tSCNITSjkaRU
        DqYieVDBqiDrR97nFgiOd5koPpYTyXmR4140wzl6Cw==
X-Google-Smtp-Source: ABdhPJwNEOdYZ2JzAa+esqv8ikW74w5nzhA2RPqk11Z0XyL+fuHQHEnv1hhlq9RrJ7o9td9gDXMcOORUJEPmsoYSFJ0=
X-Received: by 2002:ab0:5e43:: with SMTP id a3mr1793697uah.19.1598974614146;
 Tue, 01 Sep 2020 08:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150438.228887-1-ulf.hansson@linaro.org> <20200901150654.GB30034@lst.de>
In-Reply-To: <20200901150654.GB30034@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Sep 2020 17:36:17 +0200
Message-ID: <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Sep 2020 at 17:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 01, 2020 at 05:04:38PM +0200, Ulf Hansson wrote:
> > +#ifdef CONFIG_HAS_DMA
> > +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> > +{
> > +     struct spi_device *spi = host->spi;
> > +     struct device *dev;
> > +
> > +     if (!spi->master->dev.parent->dma_mask)
> > +             return 0;
>
> I still don't think this makes sense, as the dma_mask should always
> be non-NULL here.

If that is the case, I wonder how the driver could even have worked without DMA.

Because in the existing code, host->dma_dev gets assigned to
spi->master->dev.parent->dma_mask - which seems to turn on the DMA
usage in the driver.

What am I missing?

Kind regards
Uffe
