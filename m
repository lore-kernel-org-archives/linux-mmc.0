Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38346C433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5FE6146D
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhEGRW7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 13:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhEGRW7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 7 May 2021 13:22:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D44C61468;
        Fri,  7 May 2021 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620408119;
        bh=tAp8HMPCWwh+NHuRDeCEmS0cp+aQxiTRacpv+7HZQaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jMWuPbnOx6U5JZ6lRhEBYIFqNUnKAwzdc5WQfVuFRGqAC2rekeI9FxYRtfcVBjKuM
         97WoLmGZ1f1xezdG2Mm7GDXQkdgtPie37cHlyxL9E/d3wzas81leEO2jGQJfrcrRhb
         KMnBTLrq4TULos6RHk2OFJ8hDdyR7n71XyrFno4m3EGZkyLY2UtBu6XtEZYVn/YFIs
         qSdkZX5JN5kVDZCJS+nczGgDSWspBE1R0IFRCuHst3zdUpb/WuylLIZmfWww8BVmvf
         gZmhsm6y0H/21HbZdM+/lpZu4oq+aFbW0Neda4grx0UZ4qNgcsshKrMsuDKlwCUkqe
         3dlNkERzA9Iww==
Received: by mail-ej1-f54.google.com with SMTP id zg3so14734578ejb.8;
        Fri, 07 May 2021 10:21:59 -0700 (PDT)
X-Gm-Message-State: AOAM530dUcU8tJvGu6A6BR8DKMZbvx6yS9b7b8DE4zNzjlpO77kd/M8q
        2b+oTGn9SCLkXhoY+XUMadMlALZx5iBxHvPcpw==
X-Google-Smtp-Source: ABdhPJxlHzBX1kiOwdryT4JxLp1ZW5TdkQ+pgCxGNOoI/UqgbP1iECA3RgBAMWk0XjgD5TeZd/KBEkXxO5L1SMOtnxE=
X-Received: by 2002:a17:906:a0c6:: with SMTP id bh6mr11119997ejb.359.1620408117401;
 Fri, 07 May 2021 10:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-2-steven_lee@aspeedtech.com> <20210507011324.GA1119409@robh.at.kernel.org>
 <20210507031348.GA23749@aspeedtech.com>
In-Reply-To: <20210507031348.GA23749@aspeedtech.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 May 2021 12:21:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
Message-ID: <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: mmc: sdhci-of-aspeed: Add an example
 for AST2600-A2 EVB
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Hongweiz@ami.com" <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 6, 2021 at 10:14 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> The 05/07/2021 09:13, Rob Herring wrote:
> > On Thu, May 06, 2021 at 06:03:08PM +0800, Steven Lee wrote:
> > > AST2600-A2 EVB has the reference design for enabling SD bus
> > > power and toggling SD bus signal voltage by GPIO pins.
> > >
> > > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> > > power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> > > connected to a 1.8v and a 3.3v power load switch that providing
> > > signal voltage to
> > > SD1 bus.
> > >
> > > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > > disabled.
> > > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> > > signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> > > enabled, SD1 signal voltage becomes 1.8v.
> > >
> > > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> > > GPIOV3 as power-switch-gpio.
> > >
> > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > ---
> > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 +++++++++++++++++-
> > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > index 987b287f3bff..de7e61b3d37a 100644
> > > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > @@ -45,10 +45,16 @@ patternProperties:
> > >
> > >      properties:
> > >        compatible:
> > > -        enum:
> > > -          - aspeed,ast2400-sdhci
> > > -          - aspeed,ast2500-sdhci
> > > -          - aspeed,ast2600-sdhci
> > > +        oneOf:
> > > +          - items:
> > > +              - enum:
> > > +                  - aspeed,ast2400-sdhci
> > > +                  - aspeed,ast2500-sdhci
> > > +                  - aspeed,ast2600-sdhci
> > > +          - items:
> > > +              - enum:
> > > +                  - aspeed,ast2600-sdhci
> > > +              - const: sdhci
> >
> > Why are you adding 'sdhci'. That's not useful as a compatible given how
> > many quirks different implementations have.
> >
> >
>
> It is for passing the dtbs_check of the second example.
> Without this definition, many device trees have the following
> error:
>
> ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> Additional items are not allowed ('sdhci' was unexpected)

I would probably fix the dts files then. Does anything depend on 'sdhci'?

Rob
