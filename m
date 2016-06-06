From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v3 06/12] power: pwrseq: simple: Add support for
 regulator and generic property
Date: Mon, 6 Jun 2016 11:22:40 +0800
Message-ID: <20160606032239.GC16012@shlinux2>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-7-git-send-email-k.kozlowski@samsung.com>
 <20160603020218.GA19436@rob-hp-laptop>
 <5751797C.3020607@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33514 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbcFFD20 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2016 23:28:26 -0400
Content-Disposition: inline
In-Reply-To: <5751797C.3020607@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Jun 03, 2016 at 02:35:08PM +0200, Krzysztof Kozlowski wrote:
> On 06/03/2016 04:02 AM, Rob Herring wrote:
> > On Wed, Jun 01, 2016 at 10:02:15AM +0200, Krzysztof Kozlowski wrote:
> >> Some devices need real hard-reset by cutting the power.  During power
> >> sequence turn off and on the regulator, if it is provided.
> >>
> >> Additionally add support for instantiating the pwrseq-simple device on a
> >> generic property 'power-sequence'.  The device will attach itself to the
> >> node containing the property and parse the node's properties like
> >> reset-gpios, ext-supply etc.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> ---
> >>  .../bindings/power/pwrseq/pwrseq-simple.txt        | 29 +++++++-
> >>  drivers/power/pwrseq/pwrseq_simple.c               | 85 +++++++++++++++++++++-
> >>  2 files changed, 107 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> >> index ce0e76749671..a8c3f13ee83f 100644
> >> --- a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> >> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-simple.txt
> >> @@ -1,11 +1,17 @@
> >> -* The simple MMC power sequence provider
> >> +* The simple power sequence provider
> >>  
> >> -The purpose of the simple MMC power sequence provider is to supports a set of
> >> +The purpose of the simple power sequence provider is to supports a set of
> >>  common properties between various SOC designs. It thus enables us to use the
> >>  same provider for several SOC designs.
> >>  
> >> -Required properties:
> >> -- compatible : contains "mmc-pwrseq-simple".
> >> +The driver supports two types of bindings:
> >> +1. Separate node
> >> +   Required properties:
> >> +   - compatible : contains "mmc-pwrseq-simple".
> > 
> > Please note that this is not recommended for new users.
> 
> Sure.
> 
> > 
> >> +
> >> +2. Property for any node
> >> +   Required properties:
> >> +   - power-sequence
> >>  
> >>  Optional properties:
> >>  - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
> >> @@ -16,6 +22,7 @@ Optional properties:
> >>    See ../clocks/clock-bindings.txt for details.
> >>  - clock-names : Must include the following entry:
> >>    "ext_clock" (External clock provided to the card).
> >> +- ext-supply : External regulator supply
> > 
> > What happens when there are 2 supplies?
> > 
> > I'd prefer the name not be genericish and use the real supply names. 
> > Then the power seq code should just turn on all supplies it finds. If 
> > the order or timing to turn on matters, then sorry, no generic sequence.
> 
> Understood. I'll change the code to use any supply.
> 
> As for the genericness of this approach, Sylwester Nawrocki pointed an
> old thread:
> [PATCH v6 0/4] Runtime Interpreted Power Sequences
> https://lkml.org/lkml/2012/9/12/127
> 
> How do you like that approach?
> 

Rob, I am trying to implement the dts layout you suggested (see below),
but I find it is very hard to it due to the device is still not created,
without device, it is hard to manage the resources under this device (
Eg, de-initialization for probe deferral case). So, a common driver
is suitable for this power sequence case.

&usbotg1 {
        vbus-supply = <&reg_usb_otg1_vbus>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_usb_otg1_id>;
        status = "okay";

        #address-cells = <1>;
        #size-cells = <0>;
        hub: genesys@1 {
                compatible = "usb5e3,608";
                reg = <1>;
                reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
                reset-duration-us = <10>;
                clocks = <&clks IMX6SX_CLK_CKO>;
        };
};

-- 

Best Regards,
Peter Chen
