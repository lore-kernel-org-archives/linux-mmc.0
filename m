From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v10 0/8] Cavium MMC driver
Date: Fri, 20 Jan 2017 11:37:58 +0100
Message-ID: <20170120103758.GC3908@hardcore>
References: <20161219121552.18316-1-jglauber@cavium.com>
 <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
 <20170119145041.GA11757@hardcore>
 <0f721117-24aa-cb69-56fe-0a48f9012852@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:7632
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751906AbdATKiL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Jan 2017 05:38:11 -0500
Content-Disposition: inline
In-Reply-To: <0f721117-24aa-cb69-56fe-0a48f9012852@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Steven J . Hill" <Steven.Hill@cavium.com>

On Thu, Jan 19, 2017 at 09:47:33AM -0800, David Daney wrote:
> On 01/19/2017 06:50 AM, Jan Glauber wrote:
> [...]
> >
> >>4) GPIO powers should be modelled as GPIO regulators. I believe we
> >>have discussed this earlier as well (I don't really recall in detail
> >>about the last things). It gives us the opportunity to via the
> >>regulator framework to find out the supported voltage levels. This is
> >>the generic method which is used by mmc drivers, you need to adopt to
> >>this as well.
> >
> >I've added a fixed regulator to DT:
> >
> >        vcc_3v3: regulator-vcc_3v3 {
> >                compatible = "regulator-fixed";
> >                regulator-name = "VCC_3V3";
> 
> 
> Very minor point not really directly related to the MMC driver:
> "VCC_3V3" implies a general purpose supply for many things on the
> board.  This is not the case for these boards.  The "regulator"
> controls power only to eMMC and SD devices, so a name that conveys
> that function should be invented.

OK, I'll rename it to:

	mmc_supply_3v3: mmc_supply_3v3 {
        	compatible = "regulator-fixed";
		regulator-name = "mmc_supply_3v3";
		[...]


> Actually on some boards GPIO 8 doesn't even control a regulator, but
> instead only activates a bus isolator on the control and data
> signals to the eMMC and SD devices.  In this case we would be using
> the regulator framework only because the code is already there and
> it happens to work, not because we actually have a regulator.
> 
> >                regulator-min-microvolt = <3300000>;
> >                regulator-max-microvolt = <3300000>;
> >
> >                gpio = <&gpio_6_0 8 0>;
> >                /* enable-gpio = <&gpio_6_0 8 0>; */
> >                enable-active-high;
> >        };
> >
> >This seems to enable the gpio. Is this sufficient or do I need the
> >gpio-regulator?
> >
> 
> Does the "regulator-fixed" allow us to properly turn it on and off?

Yes, I've disabled all gpio calls from our mmc driver, with only the gpio 
settings in the regulator entry I get:

root@sff:~# cat /sys/kernel/debug/gpio 
gpiochip0: GPIOs 464-511, parent: pci/0000:00:06.0, gpio_thunderx:
 gpio-472 (                    |mmc_supply_3v3      ) out hi 

So the regulator driver enables GPIO 8 as it should.

> If not, we may have to switch to "gpio-regulator".  Which ever is
> simplest should be used.

"regulator-fixed" seems sufficient to me as we don't need the additional
power states that "gpio-regulator" supports.

> [...]
