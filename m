Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC03C43334
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 21:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiGCVmt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGCVmt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 17:42:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76596558A
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 14:42:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so10816370wrc.12
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 14:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMVVNw/TspXkB20dcfkA7bJulFS5H5tiR5oe4QWMnRk=;
        b=HsqBHDtGqFr4oqOjiezat5EsmCWzI1KD9rM2XwabQ2iO0RHte1hV/Iwz/dcTBUHBGT
         eoyvrV7ZkMuQ+k4SwZYaNKCS7PMlRd1FInDGTV88ZbTVoGab2QsDW9xwV1n1Z4c9a1HN
         QJD7Np2IIDr8C+YuQ104tltO5ToXrUfHe6eh8R3blGo4wZLHq4zm0vp1/nzjqMWuParm
         aWbiAm7+UFdzvmgd+bNOr3r4/2xvTWl4SSeUyxaGyhQplfL4M8R7NX/5HleaCF9V+G/P
         G2wDNwWY3CZRX0CCy8Zra5l4T2xGBe/x1gpl6v3SkhZH9xxib1QayfmKhCjm2YM2HX3X
         DYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMVVNw/TspXkB20dcfkA7bJulFS5H5tiR5oe4QWMnRk=;
        b=TVJxOgdVy8zwJOfsCgx/XdQ0EPgYklvrAADF3cXcuthWNvFYJmO67kAVA3kMzzhuSP
         uHHmaXDUnxsuWYbYTNnP9qXQNLv6pwpLxL1IMuKH6Gw+bnK2sOVJR50ZIEfl1zD3e/j+
         Ivj94Z4HqK270gZTzSEdCh2FK4f9p67Xkz/XGtV5+CmqDGoEyxBBSnYWxrr1KIEuzCDU
         7HvwO8T7dcYwPERZTl17MGH4RBRooci2qN8YrxvfVMXWEKXIqp9yEWPLs8pG3AlABe0a
         5fNo30GkA/YTlXvl6Iw2xKOctNdjcB9uDVMjlW942DsLfNVJUxln9pzw/d/9Jfe5PHuj
         copQ==
X-Gm-Message-State: AJIora+4vRfid+/3cG82gCdXhdMmNE18xIAUtpTJ9mxmCi9X30uE7Q6B
        5L8HmF6PgscR0DVhY95qL8h3J2pf9RVvQRZLrJjAiA==
X-Google-Smtp-Source: AGRyM1uOJo6rBressjjFHOaRQyjnucznDSp/34HbzfZLcPA+9VX6yTguO55aaKzIkq0N7b83eJGgalRejb/jexIr1cU=
X-Received: by 2002:a5d:5a15:0:b0:21d:630c:a609 with SMTP id
 bq21-20020a5d5a15000000b0021d630ca609mr6998929wrb.468.1656884565041; Sun, 03
 Jul 2022 14:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-14-brad@pensando.io>
 <CAHp75Vck4xNF=OOseMssF2R7TV2t+y0AQozRDFN2E6zQ51xR0g@mail.gmail.com>
In-Reply-To: <CAHp75Vck4xNF=OOseMssF2R7TV2t+y0AQozRDFN2E6zQ51xR0g@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 14:42:34 -0700
Message-ID: <CAK9rFnxR=6G469YXtdEBpNLCHq-+_kQJg4UE+58_yhxwtfBdrA@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] mmc: sdhci-cadence: Add AMD Pensando Elba SoC support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Andy,

On Tue, Jun 14, 2022 at 4:19 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
>
> > Add support for AMD Pensando Elba SoC which explicitly controls
> > byte-lane enables on writes.  Add priv_write_l() which is
>
> enabling ?

Changed to enabling

> ...
>
> > +       void (*priv_write_l)(struct sdhci_cdns_priv *priv, u32 val,
>
> priv_writel

Changed to priv_writel

>
> > +                            void __iomem *reg);
>
> And perhaps leave it on one line.
>
> I also would swap parameters, so address goes first followed by value.

Which is the reverse of writel() parameter ordering which is value,
address.  Should I do this?

> ...
>
> > +static inline void sdhci_cdns_priv_writel(struct sdhci_cdns_priv *priv,
> > +                                         u32 val, void __iomem *reg)
> > +{
>
> > +       if (unlikely(priv->priv_write_l))
>
> First of all, why if (unlikely())-else instead of if (likely())-else?
>
> > +               priv->priv_write_l(priv, val, reg);
> > +       else
> > +               writel(val, reg);
> > +}

It was existing code and never looked at it.  This construct looks to
be widely used however this goes away with the two patch approach
below.

$ find . -name \*.c | xargs grep if | grep unlikely | wc
  18640

> Instead of branching each time you do I/O, make sure that callback is
> always set and call it unconditionally. In this case you don't need to
> have this callback, but maybe just a wrapper on `writel()`. As a
> result you may split this to two patches in the first of which you
> simply introduce a callback and a writel() wrapper which is assigned
> unconditionally to all current chips. In the next you add a new chip
> support.

Next version will separate into two patches as described

> ...
>
> > +       u32 m = (reg & 0x3);
> > +       u32 msk = (0x3 << (m));
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(msk << 3, priv->ctl_addr);
> > +       writew(val, host->ioaddr + reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
>
> Too many 3:s as magic. Is it GENMASK() or something else? Perhaps it
> needs a definition.

Definitely, changed this to be understandable by inspection.
GENMASK() for word and BIT() for byte makes this more clear.  The 3's
came from bits [6:3] are the byte-lane enables in the control reg
where the lower two bits of the address specify the byte(s) to enable.

/*  Elba control reg bits [6:3] are byte-lane enables */
#define ELBA_BYTE_ENABLE_MASK(x)        ((x) << 3)

elba_priv_write_l(...):
        writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);
        writel(val, reg);

elba_write_w(...):
        byte_enables = GENMASK(1, 0) << (reg & 0x3);
        writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
        writew(val, host->ioaddr + reg);

> ...
>
> > +       u32 m = (reg & 0x3);
> > +       u32 msk = (0x1 << (m));
> > +
> > +       spin_lock_irqsave(&priv->wrlock, flags);
> > +       writel(msk << 3, priv->ctl_addr);
> > +       writeb(val, host->ioaddr + reg);
> > +       spin_unlock_irqrestore(&priv->wrlock, flags);
>
> Ditto.

elba_write_b(...):
        byte_enables = BIT(0) << (reg & 0x3);
        writel(ELBA_BYTE_ENABLE_MASK(byte_enables), priv->ctl_addr);
        writeb(val, host->ioaddr + reg);

> ...
>
> > +       writel(0x78, priv->ctl_addr);
>
> Magic.

writel(ELBA_BYTE_ENABLE_MASK(0xf), priv->ctl_addr);

> ...
>
> > +static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> > +       .pltfm_data = {
> > +               .ops = &sdhci_cdns_ops,
> > +       },
> > +};
> > +
> > +
>
> One blank line is enough.

Removed extra blank line

> ...
>
> > +       {
> > +               .compatible = "amd,pensando-elba-sd4hc",
> > +               .data = &sdhci_elba_drv_data
>
> Leave a comma here.

Added comma

Regards,
Brad
