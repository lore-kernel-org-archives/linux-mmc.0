Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B8DC433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 02:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834D361155
	for <linux-mmc@archiver.kernel.org>; Mon, 10 May 2021 02:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhEJCfH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 9 May 2021 22:35:07 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:16069 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhEJCfH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 9 May 2021 22:35:07 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14A2KSJh015471;
        Mon, 10 May 2021 10:20:28 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 May
 2021 10:32:31 +0800
Date:   Mon, 10 May 2021 10:32:28 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     Andrew Jeffery <andrew@aj.id.au>,
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
        "Ryan Chen" <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: mmc: sdhci-of-aspeed: Add an example
 for AST2600-A2 EVB
Message-ID: <20210510023228.GA6883@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-2-steven_lee@aspeedtech.com>
 <20210507011324.GA1119409@robh.at.kernel.org>
 <20210507031348.GA23749@aspeedtech.com>
 <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLywL6J_uVVquhOMevb6Geed-A2o7fzHQPKvVQxe4gscA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14A2KSJh015471
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 05/08/2021 01:21, Rob Herring wrote:
> On Thu, May 6, 2021 at 10:14 PM Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > The 05/07/2021 09:13, Rob Herring wrote:
> > > On Thu, May 06, 2021 at 06:03:08PM +0800, Steven Lee wrote:
> > > > AST2600-A2 EVB has the reference design for enabling SD bus
> > > > power and toggling SD bus signal voltage by GPIO pins.
> > > >
> > > > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
> > > > power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
> > > > connected to a 1.8v and a 3.3v power load switch that providing
> > > > signal voltage to
> > > > SD1 bus.
> > > >
> > > > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > > > disabled.
> > > > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
> > > > signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
> > > > enabled, SD1 signal voltage becomes 1.8v.
> > > >
> > > > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > > > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
> > > > GPIOV3 as power-switch-gpio.
> > > >
> > > > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > > > ---
> > > >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 101 +++++++++++++++++-
> > > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > index 987b287f3bff..de7e61b3d37a 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > > > @@ -45,10 +45,16 @@ patternProperties:
> > > >
> > > >      properties:
> > > >        compatible:
> > > > -        enum:
> > > > -          - aspeed,ast2400-sdhci
> > > > -          - aspeed,ast2500-sdhci
> > > > -          - aspeed,ast2600-sdhci
> > > > +        oneOf:
> > > > +          - items:
> > > > +              - enum:
> > > > +                  - aspeed,ast2400-sdhci
> > > > +                  - aspeed,ast2500-sdhci
> > > > +                  - aspeed,ast2600-sdhci
> > > > +          - items:
> > > > +              - enum:
> > > > +                  - aspeed,ast2600-sdhci
> > > > +              - const: sdhci
> > >
> > > Why are you adding 'sdhci'. That's not useful as a compatible given how
> > > many quirks different implementations have.
> > >
> > >
> >
> > It is for passing the dtbs_check of the second example.
> > Without this definition, many device trees have the following
> > error:
> >
> > ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> > Additional items are not allowed ('sdhci' was unexpected)
> 
> I would probably fix the dts files then. Does anything depend on 'sdhci'?
> 

The build error is caused by my second example.
My example is refer to the aspeed-g6.dtsi to append "sdhci" after
"aspeed,ast2600-sdhci"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-g6.dtsi?h=v5.12#n561

As long as the second example is removed, the following error won't show in the dtbs_check result.

```
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml
  CHECK   arch/arm/boot/dts/aspeed-ast2500-evb.dt.yaml
  DTC     arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
  CHECK   arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc@1e740000: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc@1e740000: sdhci@1e740100:compatible: Additional items are not allowed ('sdhci' was unexpected)
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc@1e740000: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
/home/slee/aspeed/patch_up/linux/arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml: sdc@1e740000: sdhci@1e740200:compatible: Additional items are not allowed ('sdhci' was unexpected)
        From schema: /home/slee/aspeed/patch_up/linux/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml

```

> Rob
