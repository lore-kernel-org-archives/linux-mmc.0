From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC v4 01/14] regulator: of: Add helper for getting all supplies
Date: Fri, 10 Jun 2016 20:49:26 +0200
Message-ID: <4549765.J0ap1g2jZL@diego>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com> <5759560A.70107@samsung.com> <20160610173056.GA16503@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:44067 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbcFJSuE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jun 2016 14:50:04 -0400
In-Reply-To: <20160610173056.GA16503@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, hzpeterchen@gmail.com

Am Freitag, 10. Juni 2016, 12:30:56 schrieb Rob Herring:
> On Thu, Jun 09, 2016 at 01:42:02PM +0200, Krzysztof Kozlowski wrote:
> > On 06/09/2016 12:29 PM, Mark Brown wrote:
> > > On Thu, Jun 09, 2016 at 11:44:18AM +0200, Krzysztof Kozlowski wrote:
> > >> Few drivers have a need of getting regulator supplies without knowing
> > >> their names:
> > >> 1. The Simple Framebuffer driver works on setup provided by bootloader
> > >> 
> > >>    (outside of scope of kernel);
> > >> 
> > >> 2. Generic power sequence driver may be attached to any device node.
> > >> 
> > >> Add a Device Tree helper for parsing "-supply" properties and returning
> > >> allocated bulk regulator consumers.
> > > 
> > > I'm still very concerned that this is just an invitation to people to
> > > write half baked regulator consumers and half baked DTs to go along with
> > > it, making it a standard API that doesn't have big red flags on it that
> > > will flag up when "normal" drivers use it is not good.  Right now this
> > > just looks like a standard API and people are going to just start using
> > > it.  If we are going to do this perhaps we need a separate header or
> > > something to help flag this up.
> > 
> > No problem, I can move it to a special header.  Actually, if you dislike
> > this as an API, it does not have to be in header at all.  I can just
> > duplicate the simplefb code.
> > 
> > > In the case of power sequences I'd expect the sequences to perform
> > > operations on named supplies - the core shouldn't know what the supplies
> > > are but the thing specifying the sequence should.
> > 
> > Hm, so maybe passing names like:
> > 
> > usb3503@08 {
> > 
> > 	reset-gpios = <&gpx3 5 GPIO_ACTIVE_HIGH>;
> > 	initial-mode = <1>;
> > 	vdd-supply = <&buck8_reg>;
> > 	foo-supply = <&buck9_reg>;
> > 	
> >         power-sequence;
> > 	
> > 	power-sequence-supplies = "vdd", "foo";
> 
> This alone would be fine as it is just one property, but then what's
> next? power-sequence-delay, power-sequence-clocks, etc. What if you
> need to express ordering relationship of supplies, clocks, gpios? We end
> up with a scripting language in DT and we don't want to have that.

Also, at least from the simple blocks I've seen so far (usb-hub chips, usb-
sata bridges), a power-supply feels more like it should be a regular phy-
supply of the usbphy connected the the host-controller.

It's similar for mmc-controllers where vmmc-supply on the controller handles 
the power-supply of the connected card and thus the current mmc power-
sequences do not handle regulators.

Reset-gpios and clock inputs are clearly properties of the actual device, but 
the supply control should probably lay with the host controller, especially as 
it is the one deciding when to power on/off things.


