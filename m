Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B1CC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 03:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C1A6120E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 03:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbhDMDdY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 23:33:24 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:52749 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbhDMDdY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 23:33:24 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 13D3LYpM091103;
        Tue, 13 Apr 2021 11:21:34 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr
 2021 11:31:58 +0800
Date:   Tue, 13 Apr 2021 11:31:56 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add power-gpio
 and power-switch-gpio
Message-ID: <20210413033155.GA3522@aspeedtech.com>
References: <20210408015218.20560-1-steven_lee@aspeedtech.com>
 <20210408015218.20560-2-steven_lee@aspeedtech.com>
 <CAPDyKFr=Gtwu4v22FBaax5EjRbXTNez1N2ZQxP=v0LKGFTCovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAPDyKFr=Gtwu4v22FBaax5EjRbXTNez1N2ZQxP=v0LKGFTCovw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 13D3LYpM091103
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 04/12/2021 15:38, Ulf Hansson wrote:
> On Thu, 8 Apr 2021 at 03:52, Steven Lee <steven_lee@aspeedtech.com> wrote:
> >
> > AST2600-A2 EVB provides the reference design for enabling SD bus power
> > and toggling SD bus signal voltage by GPIO pins.
> > Add the definition and example for power-gpio and power-switch-gpio
> > properties.
> >
> > In the reference design, GPIOV0 of AST2600-A2 EVB is connected to power
> > load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is connected to
> > a 1.8v and a 3.3v power load switch that providing signal voltage to
> > SD1 bus.
> > If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
> > disabled.
> > If GPIOV1 is active high, 3.3v power load switch is enabled, SD1 signal
> > voltage is 3.3v. Otherwise, 1.8v power load switch will be enabled, SD1
> > signal voltage becomes 1.8v.
> >
> > AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
> > The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and GPIOV3
> > as power-switch-gpio.
> 
> Thanks for sharing the details, it certainly helps while reviewing.
> 
> >
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 25 +++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > index 987b287f3bff..515a74614f3c 100644
> > --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> > @@ -37,6 +37,14 @@ properties:
> >    clocks:
> >      maxItems: 1
> >      description: The SD/SDIO controller clock gate
> > +  power-gpio:
> > +    description:
> > +      The GPIO for enabling/disabling SD bus power.
> > +    maxItems: 1
> > +  power-switch-gpio:
> > +    description:
> > +      The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> > +    maxItems: 1
> 
> 
> >
> >  patternProperties:
> >    "^sdhci@[0-9a-f]+$":
> > @@ -61,6 +69,14 @@ patternProperties:
> >        sdhci,auto-cmd12:
> >          type: boolean
> >          description: Specifies that controller should use auto CMD12
> > +      power-gpio:
> > +        description:
> > +          The GPIO for enabling/disabling SD bus power.
> > +        maxItems: 1
> > +      power-switch-gpio:
> > +        description:
> > +          The GPIO for toggling the signal voltage between 3.3v and 1.8v.
> > +        maxItems: 1
> >      required:
> 
> Please do not model these as GPIO pins like this. Instead, it's better
> to model them as gpio regulators, since the mmc core manages them as
> regulators.
> 
> We have a vmmc regulator (corresponding to vdd) and a vqmmc regulator
> (corresponding the signal-voltage level). These are also described in
> the common mmc DT bindings, see
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml.
> 

Thanks for the information. I will modify it.

> >        - compatible
> >        - reg
> > @@ -80,6 +96,7 @@ required:
> >  examples:
> >    - |
> >      #include <dt-bindings/clock/aspeed-clock.h>
> > +    #include <dt-bindings/gpio/aspeed-gpio.h>
> >      sdc@1e740000 {
> >              compatible = "aspeed,ast2500-sd-controller";
> >              reg = <0x1e740000 0x100>;
> > @@ -94,6 +111,10 @@ examples:
> >                      interrupts = <26>;
> >                      sdhci,auto-cmd12;
> >                      clocks = <&syscon ASPEED_CLK_SDIO>;
> > +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 0)
> > +                                     GPIO_ACTIVE_HIGH>;
> > +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 1)
> > +                                     GPIO_ACTIVE_HIGH>;
> >              };
> >
> >              sdhci1: sdhci@200 {
> > @@ -102,5 +123,9 @@ examples:
> >                      interrupts = <26>;
> >                      sdhci,auto-cmd12;
> >                      clocks = <&syscon ASPEED_CLK_SDIO>;
> > +                    power-gpio = <&gpio0 ASPEED_GPIO(V, 2)
> > +                                     GPIO_ACTIVE_HIGH>;
> > +                    power-switch-gpio = <&gpio0 ASPEED_GPIO(V, 3)
> > +                                     GPIO_ACTIVE_HIGH>;
> >              };
> >      };
> 
> Kind regards
> Uffe
