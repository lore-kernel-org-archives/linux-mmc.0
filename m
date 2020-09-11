Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EBEC43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 03:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B721D7E
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 03:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="f7hAImC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIKDeO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDeL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 23:34:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBCC061573;
        Thu, 10 Sep 2020 20:34:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so8532361edr.3;
        Thu, 10 Sep 2020 20:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdWC82PKEhEwsaXh3LAxl47RN5F/LTuAnkpnqIreE2Q=;
        b=f7hAImC+A8EN07tWzuoorjAACjNBmgZj9nxMqSY+DSMKQiuC5kczlXpOVkgrBoMLSt
         EFCR7nxnwQhkOKl8k72xV56bOooIo3JMF0iY4Ddg4LHP1XqouEAEAF+KMEWCU/7k4LsE
         ERbh2VMLY3LELI+NF8FJ8mJZhyE4tJiJL4hT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdWC82PKEhEwsaXh3LAxl47RN5F/LTuAnkpnqIreE2Q=;
        b=iUFE9/v8Coje5M9MEvR17/uSMdjYB5WKBZfdxp25Q7P4zeNUaLV0oa9r+tH/OPlxPB
         /f4ZRZl1TbuTsp6U0k3rOHEtA/KYb6TNw0YViwLs9N/xu/1YKlHQthF7pMp/KnbdRnj7
         dlieoly8MV4FEIBH0Eoeo4NtFqLVEg8D3doFBCO/VigGgil133wv8uER6gUkYWBLxxRJ
         hbJDj0fAXk4qnQSDWkQYFvxS6stvYVNoOZ4ePxzL+S7SbpJt4dlV/rcJ1JTMiHT3Dtpf
         RL8d9c9t69TOO6rPmoC+qjANUTxVUMO+Jtav9VlQ3wzfpdotIaKsIUtFmIp6HP9wf/WK
         lMCg==
X-Gm-Message-State: AOAM533C4NEVkyTpESzpb0WTOBsb0lmbrVNbAuh1jqFw67ZTC4CX4jv5
        sLzXGjvYloc1e2+H90phpnNbS4FOqp5yOzxbDIA=
X-Google-Smtp-Source: ABdhPJzirNmav2/bABf0JzFPct9kmYu46AR/LeQQE+jKnkBIwfXqohIwEIaiJFyCSYJ6pnUxr1+sNEUyJ5DTAAnD4rk=
X-Received: by 2002:aa7:d959:: with SMTP id l25mr12310657eds.383.1599795249576;
 Thu, 10 Sep 2020 20:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910105440.3087723-1-andrew@aj.id.au> <20200910105440.3087723-3-andrew@aj.id.au>
 <CACPK8Xf-jys=F0Uqg-hYH-eDThmd5yOSNeC7+vLhra3GdOK1Zw@mail.gmail.com> <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
In-Reply-To: <57d48d7a-7cea-4be7-92bd-8f3b93f84a06@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 03:33:56 +0000
Message-ID: <CACPK8XemZ2YG+nFBwy7sDoo8==YvnVYxt+1mx8QfBCxotG7K6g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Sep 2020 at 02:49, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Fri, 11 Sep 2020, at 11:32, Joel Stanley wrote:
> > On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Allow sample phase adjustment to deal with layout or tolerance issues.
> > >
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 137 +++++++++++++++++++++++++++--
> > >  1 file changed, 132 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index 4f008ba3280e..641accbfcde4 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c

> > > +static void
> > > +aspeed_sdc_configure_phase(struct aspeed_sdc *sdc,
> > > +                          const struct aspeed_sdhci_phase_desc *phase,
> > > +                          uint8_t value, bool enable)
> > > +{
> > > +       u32 reg;
> > > +
> > > +       spin_lock(&sdc->lock);
> >
> > What is the lock protecting against?
> >
> > We call this in the ->probe, so there should be no concurrent access going on.
>
> Because the register is in the "global" part of the SD/MMC controller address
> space (it's not part of the SDHCI), and there are multiple slots that may have
> a driver probed concurrently.

That points to having the property be part of the "global" device tree
node. This would simplify the code; you wouldn't need the locking
either.

>
> >
> >
> > > +       reg = readl(sdc->regs + ASPEED_SDC_PHASE);
> > > +       reg &= ~phase->enable_mask;
> > > +       if (enable) {
> > > +               reg &= ~phase->value_mask;
> > > +               reg |= value << __ffs(phase->value_mask);
> > > +               reg |= phase->enable_value << __ffs(phase->enable_mask);
> > > +       }
> > > +       writel(reg, sdc->regs + ASPEED_SDC_PHASE);
> > > +       spin_unlock(&sdc->lock);
> > > +}
> > > +
> > >  static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > >  {
> > >         struct sdhci_pltfm_host *pltfm_host;
> > > @@ -155,8 +195,58 @@ static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > >         return (delta / 0x100) - 1;
> > >  }
> > >
> > > +static int aspeed_sdhci_configure_of(struct platform_device *pdev,
> > > +                                    struct aspeed_sdhci *sdhci)
> > > +{
> > > +       u32 iphase, ophase;
> > > +       struct device_node *np;
> > > +       struct device *dev;
> > > +       int ret;
> > > +
> > > +       if (!sdhci->phase)
> > > +               return 0;
> > > +
> > > +       dev = &pdev->dev;
> > > +       np = dev->of_node;
> > > +
> > > +       ret = of_property_read_u32(np, "aspeed,input-phase", &iphase);
> > > +       if (ret < 0) {
> > > +               aspeed_sdc_configure_phase(sdhci->parent, &sdhci->phase->in, 0,
> > > +                                          false);
> >
> > Will this clear any value that eg. u-boot writes?
>
> No, see the 'enable' test in aspeed_sdc_configure_phase()

OK, so this branch will never cause any change in the register? Best
to drop it then.

>
> >
> > The register should be left alone if the kernel doesn't have a
> > configuration of it's own, otherwise we may end up breaking an
> > otherwise working system.
>
> Right, I can rework that.
