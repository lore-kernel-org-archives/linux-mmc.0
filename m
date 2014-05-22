From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Thu, 22 May 2014 19:20:55 +0200
Message-ID: <537E31F7.1030505@gmail.com>
References: <537DC832.3020006@redhat.com> <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:52106 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaEVRVE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 13:21:04 -0400
In-Reply-To: <537DE1AA.5050606@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>
Cc: Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

Hi,


On 22.05.2014 13:38, Hans de Goede wrote:
> On 05/22/2014 12:23 PM, Chen-Yu Tsai wrote:
>> On Thu, May 22, 2014 at 5:49 PM, Hans de Goede <hdegoede@redhat.com> wrote:

snip

>>> I've been thinking a bit about this, and it is a non trivial problem since
>>> sdio devices are normally instantiated when probed, unlike ie spi devices
>>> which are instantiated from devicetree.
>>>
>>> Adding device tree instantiation of sdio devices seems like a bad idea, as
>>> then we get 2 vastly different device instantiation paths. Still we need some
>>> way to get power and clks setup before the mmc host initializes.

What about introducing some extra callbacks to mmc drivers to build
driver data and control power?

struct mmc_legacy_device {
	/* ... */
	struct device_node *of_node;
	void *driver_data;
};

struct mmc_driver {
	/* ... */
	int (*prepare)(struct mmc_legacy_device *);
	void (*unprepare)(struct mmc_legacy_device *);
};

static int my_wlan_prepare(struct mmc_legacy_device *dev)
{
	struct my_wlan_data *data;

	data = kzalloc(...);
	/* ... */

	of_*();
	clk_*();
	regulator_*();
	/* ... */

	ret = my_wlan_power_on(data);
	/* ... */

	dev->driver_data = data;	
}

static void my_wlan_unprepare(struct mmc_legacy_device *dev)
{
	struct my_wlan_data *data;

	data = dev->driver_data;

	my_wlan_power_off(data);
	/* ... */

	dev->driver_data = NULL;
	kfree(data);
}

I don't really like this, especially the fact that this would be highly
MMC-specific, while there are other interfaces that also need this
problem solved, e.g. USB/HSIC.

I had proposed another solution that would require almost no changes in
MMC core and could work for any data interface. You can find it
somewhere in the thread mentioned by Chen-Yu. Unfortunately, for reasons
that don't appeal to me, it wasn't positively received by MMC people.

>>>
>>> Therefor I would like to suggest to add a number of standard properties to
>>> mmc-bus child nodes. Making the dts for an mmc host with an sdio device which
>>> needs clks setup before it will work look like this:
>>>
>>>                 mmc3: mmc@01c12000 {
>>>                         #address-cells = <1>;
>>>                         #size-cells = <0>;
>>>                         pinctrl-names = "default";
>>>                         pinctrl-0 = <&mmc3_pins_a>;
>>>                         vmmc-supply = <&reg_vmmc3>;
>>>                         bus-width = <4>;
>>>                         non-removable;
>>>                         status = "okay";
>>>
>>>                         brcmf: bcrmf@0 {
>>>                                 reg = <0>;
>>>                                 compatible = "brcm,bcm43xx-fmac";
>>>                                 clocks = <&clk_out_a>, <&clk_out_b>;
>>>                                 clock-frequency = <32768>, <26000000>;
>>>                                 interrupt-parent = <&pio>;
>>>                                 interrupts = <10 4>; /* PH10 / EINT10 */
>>>                                 interrupt-names = "host-wake";
>>>                                 status = "okay";
>>>                         };
>>>                 };
>>>
>>> Where the "clocks" and "clock-frequency" attributes would be something
>>> which we standardize in Documentation/devicetree/bindings/mmc/mmc-bus.txt

I like the binding. It has all properties defined where they belong.

>>>
>>> These standard properties would *not* be used by the driver for the
>>> childnode device, so as to avoid the chicken and egg problem of that driver
>>> needing to enable clks, and it only getting bound to the device after
>>> the device has been discovered which requires those clocks.
>>>
>>> Instead these properties would be parsed by mmc_of_parse, and we will
>>> get enabled automatically by mmc_add_host before doing any probing.
>>>
>>> If the optional clock-frequency property is also set, then mmc_add_host
>>> will not only enable the clks but also set them to the specified
>>> frequency.
>>>

I don't like power control and parsing in MMC core, because they are
highly chip-specific. Throwing this kind of knowledge to MMC subsystem
violates separation and just won't scale as more different WLAN chips
show up. However, this is at least not enforced by design of the
bindings and so can be changed at any time in future, while having
something already working.

See above for my take on other ways of handling this.

>>> Note I've no boards which actually need the clocks, all 3 boards with
>>> sdio wifi which I've use a 26MHz crystal directly attached to the module,
>>> so once I get the oob interrupt working (this needs some work on
>>> the allwinner side) we can merge Arend's patches with the clock bits
>>> dropped for now.

Exynos4210-based TRATS and Exynos4412-based TRATS2 boards already
supported by mainline kernel have WLAN 32k clock driven by PMIC and
needs to be ungated. For the 26M clock a normal crystal is used as well
as in your case.

Best regards,
Tomasz
