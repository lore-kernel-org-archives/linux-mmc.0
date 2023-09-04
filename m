Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE388C83F3E
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Sep 2023 12:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbjIDMWQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Sep 2023 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbjIDMWQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Sep 2023 08:22:16 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E0F1B7
        for <linux-mmc@vger.kernel.org>; Mon,  4 Sep 2023 05:22:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7bb34576b9so1223557276.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Sep 2023 05:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693830132; x=1694434932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtWz4Zjn1UW6f/Bp4thXGCFf7baahobrbXRCy95Pavs=;
        b=UhsS0EBIvwrlU0X3g+ma8zg/cvrCUw/0Tb3iGQV7qei6X2rBwYCyCxB5l2bt4/9QJ5
         5OWZbprpt47hee50lCQjvOHS3mS6+79bgqbs+RCM88Ve57xdFafnOxrz3Y/BiJP4MGQk
         mt/GkjzyqdL2rAaPUkn68JKl3MupsPiLcJ+ZINv0fGWdSDSLMr1g1id2qXH8m874qTTO
         F8iUnYfEZLFFR95i+gqvj8HQkXntlMJihwjYZce0OUQhrDO3iBluabciB14sfx+Jd4ES
         j8B9JcUTira4CUbMelNFojR93n+yCXhniRFntiu2gsFXvreadrUG0LhZC5O720UGbBpE
         qZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693830132; x=1694434932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtWz4Zjn1UW6f/Bp4thXGCFf7baahobrbXRCy95Pavs=;
        b=JNoMZkjGqIH7/VMYqsTJEBBtjC/GzKm0CbBh+mSBwPzUO+EI+KakfIgJ2blu1t/ols
         4jxNH0xSktwZBEuOEd4Z1xKYsA2HxmbPocps+zcyW1oBLcceMXFZyYEmPjV7paGekNV7
         mP92enaRjDvGZFIuGASuQ0/dOdTXRsQDz4RSQOGLdecfrX6Ao1zkAv9EyNf2TVWVnE4T
         XG1PHRSAPa4gQ0YzfMA02y3zgVXQKWllqQz7Qgzm5ImePTHtBXasFOYloUukNxeJm/LA
         yNMHY5EcuV5MRcu3ys03VpXzvf1UKPRics5HV5O9yjIjOnAzcYJGyXopA8fQTunuZz4o
         4H6g==
X-Gm-Message-State: AOJu0Yz4AbBbinPy/1Q9nKY0dS4hV5g+PbHWl7BITKpoJqoOJfpskV+Y
        Qp/bFGxAsceQLd8q/2bSqfXFrkfmrfnQJIlE3is3c5M/2YChaAVy2qx+gA==
X-Google-Smtp-Source: AGHT+IHPwKOL/2Z9FQ4y0NEX4i5C+ax07Yhv4XOcJCyrKvr2TbeaxnBIPI7R8RJYi9WrH6gCRPBTH43bpu9g6ij4cKI=
X-Received: by 2002:a25:c509:0:b0:d74:6163:db8c with SMTP id
 v9-20020a25c509000000b00d746163db8cmr11092688ybe.41.1693830131892; Mon, 04
 Sep 2023 05:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120836.1057900-1-yann.gautier@foss.st.com> <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
In-Reply-To: <CACRpkdacRe5cPoSFJyEdo6nZrtmUHTNqMxf55CntvsdpFqhhrQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Sep 2023 14:21:35 +0200
Message-ID: <CAPDyKFqJzoBiG4c2NbXA_6YDNsAh4W0TO-SP9+C2Qw40TKVH7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: add SDIO in-band interrupt mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Sept 2023 at 16:10, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> Hi Yann/Christophe,
>
> thanks for your patch!
>
> On Fri, Sep 1, 2023 at 2:08=E2=80=AFPM Yann Gautier <yann.gautier@foss.st=
.com> wrote:
>
> > From: Christophe Kerello <christophe.kerello@foss.st.com>
> >
> > Add the support of SDIO in-band interrupt mode for STM32 variant.
> > It allows the SD I/O card to interrupt the host on SDMMC_D1 data line.
> >
> > Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> > Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> (...)
> > +++ b/drivers/mmc/host/mmci.h
> > @@ -332,6 +332,7 @@ enum mmci_busy_state {
> >   * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER =
register
> >   * @dma_lli: true if variant has dma link list feature.
> >   * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
> > + * @use_sdio_irq: allow SD I/O card to interrupt the host
>
> The documentation tag should be one line up (compare to the members...)
>
> > @@ -376,6 +377,7 @@ struct variant_data {
> >         u32                     start_err;
> >         u32                     opendrain;
> >         u8                      dma_lli:1;
> > +       u8                      use_sdio_irq:1;
>
> 1. bool use_sdio_irq;
>
> 2. supports_sdio_irq is more to the point don't you think?
>     Especially since it activates these two callbacks:
>
> > +       void (*enable_sdio_irq)(struct mmci_host *host, int enable);
> > +       void (*sdio_irq)(struct mmci_host *host, u32 status);
>
> Further: all the Ux500 variants support this (bit 22) as well, so enable =
those
> too in their vendor data. All I have is out-of-band signaling with an GPI=
O IRQ
> on my Broadcom chips but I think it works (maybe Ulf has tested it in the
> far past).

For the ux500 variant there is a HW problem. After running some stress
tests, we may end up being stuck waiting for an SDIO IRQ to be
delivered. Even if the SDIO irqs should be considered level triggered,
it looked like it was implemented in the HW as an edge triggered IRQ.

The downstream workaround consisted of re-routing the DAT1 to a GPIO
at runtime suspend (we wanted that for optimal power save support
anyway) - and manually checking if the DAT1 line was asserted, before
enabling the GPIO line for an irq. This worked perfectly fine as a
workaround, with the limitation that one may observe a little bit of
hick-up in the traffic occasionally.

That said, the out-of-band IRQs is what works best for the ux500 variants.

Kind regards
Uffe
