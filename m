From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Mon, 20 Jun 2016 19:26:51 +0800
Message-ID: <20160620112651.GA26936@shlinux2>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32826 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbcFTLd0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2016 07:33:26 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Stephen Boyd <stephen.boyd@linaro.org>, oscar@naiandei.net, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linux USB List <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, troy.kisky@boundarydevices.com, Javier Martinez Canillas <javier@osg.samsung.com>, Philipp Zabel <p.zabel@pengutronix.>

On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
> On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > Add binding doc for generic usb power sequence driver, and update
> > generic usb device binding-doc accordingly.
> >
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
> >  .../devicetree/bindings/usb/usb-device.txt         |  2 ++
> >  2 files changed, 33 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> > new file mode 100644
> > index 0000000..8ad98382
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> > @@ -0,0 +1,31 @@
> > +The power sequence for generic USB Devices
> > +
> > +Some hard-wired USB devices need to do power sequence to let the
> > +device work normally, the typical power sequence like: enable USB
> > +PHY clock, toggle reset pin, etc. But current Linux USB driver
> > +lacks of such code to do it, it may cause some hard-wired USB devices
> > +works abnormal or can't be recognized by controller at all. The
> > +power sequence will be done before this device can be found at USB
> > +bus.
> > +
> > +Required properties:
> > +- compatible : contains "usb-pwrseq-generic".
> 
> In case I have not been clear, no.
> 
> I am not going to accept anything along the lines of the current mmc
> pwrseq. I am basically okay with Krzysztof's proposal as it is *only*
> an added property and not a duplication of information. I'd suggest
> you figure out how to make the kernel work with that rather than
> trying to work-around whatever kernel limitations there are.
> 

I see.

Would you agree with below:

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

		power-sequence;
		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
		reset-duration-us = <10>;
		clocks = <&clks IMX6SX_CLK_CKO>;

		#address-cells = <1>;
		#size-cells = <0>;
		ethernet: asix@1 {
			compatible = "usbb95,1708";
			reg = <1>;

			power-sequence;
			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
			reset-duration-us = <15>;
			clocks = <&clks IMX6SX_CLK_IPG>;
		};
	};
};

If the node has property "power-sequence", the pwrseq core will create
related platform device, and the driver under pwrseq driver will handle
power sequence stuffs. The property below "power-sequence" will be
handled at pwrseq driver.

-- 

Best Regards,
Peter Chen
