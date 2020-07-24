Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418FC433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEBA206E3
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovkwk+3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgGXKGx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKGw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 06:06:52 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98AC0619D3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 03:06:52 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id m6so4586958vsl.12
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nx9Us6fvE/iUsMsXh7T0pNo8U/ECZ5BCyqR2VoGQYII=;
        b=ovkwk+3I/iXk5jeFsY/WfnMEn0KEmtJFr5cU2ehK7tZhja2S1NphgiLhEvk7cqabv8
         N/1LOxgGvFFkl5RHpq3VVezuT9G15haWTj1gtmF3+1EdOBR+sjZ9vRynRxsvYGxi7H0b
         nfWNe4y7aUhgWKpJ8jYDqcRl0RqZSBCdG1xdVuNmHPy8y/Ga3m9NkM4JNtDnpP1Ozxl3
         X+IIXCu3HpzX8bjyf5z1qVyriIzXccruUVD6bROhwWklNyLoivuFVHmX4AcUb+tQqUiA
         yoBeN4/sGSiWq6/f3tA+cBJDO+tV0Tuy8UmlH76iiA0d+kwCaS/6NNHIR6P6t3dhKhGx
         iyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nx9Us6fvE/iUsMsXh7T0pNo8U/ECZ5BCyqR2VoGQYII=;
        b=cRhmDn6k7e61XETouPd2XeTMKQB8rCvskdlH7oKSAB3qB9k96YL39n3XfujvlkHw5x
         JKFznYG+g+fiLyGxhgoK/iI8k96Pvp/j82l5mOC45yxs7YWBnqLo7lcw10aqtAFMG+/K
         /psM+QVubVVoC5qC91J+XE8ZfPJ3urIqr7oKS16cw2eokp/grul7W/Qfo1VTdt9ntTf/
         MQQNSB6APIrfbkNhJilRGPA+7svgPAPj5KUuMKGuLSvCkVUSPPoc+QhyEgBZ5aSmL3gu
         SJtn0ulvay6OA2YGxNIj2SpjQ7OBL7W08CAX/HLiricZ1aT6v1n8hjLT0UUUXTvsfSnD
         fUqw==
X-Gm-Message-State: AOAM530T/X7Ln2ydqvo2txP44Iwqy/Re8DjFy7CisjiA2gMOSsw+8oof
        S3kK2l07pLkksJQ0tUsrzuOU701pQWM0RZkufvydJA==
X-Google-Smtp-Source: ABdhPJzjAIzGCHxSmawe/s8/Yy73C5qRzVM8Z655PkkXpf4XprbiEn9AMqVYCsAPbxBykzM4342UssUmkeVanoFaBEc=
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr6577066vsg.35.1595585211891;
 Fri, 24 Jul 2020 03:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org> <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
In-Reply-To: <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 12:06:15 +0200
Message-ID: <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Rui Feng <rui_feng@realsil.com.cn>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Jul 2020 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> > +       /* Continue with the SD express init, if the card supports it. */
> > +       resp &= 0x3000;
> > +       if (pcie_bits && resp) {
> > +               if (resp == 0x3000)
> > +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> > +               else
> > +                       host->ios.timing = MMC_TIMING_SD_EXP;
> > +
> > +               /*
> > +                * According to the spec the clock shall also be gated, but
> > +                * let's leave this to the host driver for more flexibility.
> > +                */
> > +               return host->ops->init_sd_express(host, &host->ios);
> > +       }
> > +
> >         return 0;
> >  }
>
> Does this need an additional handshake or timeout to see if the
> device was successfully probed by the nvme driver?
>
> It looks like the card would just disappear here if e.g. the nvme driver
> is not loaded or runs into a runtime error.

You are correct! In principle, the card would not be detected (it
doesn't disappear as it never gets registered). Instead, it's left in
"half-initialized" state, waiting for the nvme driver to take over.

I simply didn't want to go that far, to introduce synchronizations
steps between the nvme driver and mmc driver, but rather started
simple. Perhaps we can discuss these things as improvements on top
instead?

What do you think?

Kind regards
Uffe
