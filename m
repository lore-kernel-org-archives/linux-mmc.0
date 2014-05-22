From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Thu, 22 May 2014 18:23:58 +0800
Message-ID: <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
References: <537DC832.3020006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:43282 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbaEVKYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 May 2014 06:24:19 -0400
In-Reply-To: <537DC832.3020006@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Figa <tomasz.figa@gmail.com>, Jyri Sarha <jsarha@ti.com>

Hi,

On Thu, May 22, 2014 at 5:49 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Arend asked me to test these 2 patches for adding devicetree support to brcmfmac sdio devices:
> "dt: bindings: add bindings for Broadcom bcm43xx sdio devices"
> "brcmfmac: add device tree support for SDIO devices"
> https://groups.google.com/forum/#!msg/linux-sunxi/Zph6zDTnAcw/_-wOO-gnIuQJ
>
> Getting this to do anything at all meant also adding this patch:
>
> "mmc: Add SDIO function devicetree subnode parsing"
> https://lkml.org/lkml/2014/4/3/522
>
> So that the card / sdio-func devices would actually get their of_node
> pointer set to the child node under the mmc controller describing
> the sdio wifi module.
>
> But that does not solve the entire problem. Listing the oob-interrupt info
> in the child node works fine. But listing the brcm,wlan-supply gpio does
> not. Since these sdio wifi modules are typically soldered onto the
> board, there mmc controller device tree node has non-removable; set,
> so the mmc subsystem will try to initialize the sdio device as soon
> as the mmc driver loads, and if that fails will never look at it again.
>
> So we need to have the brcm,wlan-supply gpio driven high *before* the mmc
> host driver initializes. In case of the brcm,wlan-supply property, this
> is actually a problem which we've already solved in a number of dts files
> for allwinner boards, simply create a fixed-regulator with an enable/disable
> gpio, and set that as vmmc-supply for the mmc-host for the sdio wifi.
>
> However the "brcmfmac: add device tree support for SDIO devices" patch
> also adds support for 2 devicetree controlled clocks. Assuming these need
> to be ungated before the sdio module will respond to mmc commands, we have
> the same problem.

Olof posted an RFC series on this very matter:

  http://www.spinics.net/lists/linux-mmc/msg24411.html

There was a lengthy discussion, however I don't think the matter was settled.

CC-ed everyone from that discussion.

> I've been thinking a bit about this, and it is a non trivial problem since
> sdio devices are normally instantiated when probed, unlike ie spi devices
> which are instantiated from devicetree.
>
> Adding device tree instantiation of sdio devices seems like a bad idea, as
> then we get 2 vastly different device instantiation paths. Still we need some
> way to get power and clks setup before the mmc host initializes.
>
> Therefor I would like to suggest to add a number of standard properties to
> mmc-bus child nodes. Making the dts for an mmc host with an sdio device which
> needs clks setup before it will work look like this:
>
>                 mmc3: mmc@01c12000 {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&mmc3_pins_a>;
>                         vmmc-supply = <&reg_vmmc3>;
>                         bus-width = <4>;
>                         non-removable;
>                         status = "okay";
>
>                         brcmf: bcrmf@0 {
>                                 reg = <0>;
>                                 compatible = "brcm,bcm43xx-fmac";
>                                 clocks = <&clk_out_a>, <&clk_out_b>;
>                                 clock-frequency = <32768>, <26000000>;
>                                 interrupt-parent = <&pio>;
>                                 interrupts = <10 4>; /* PH10 / EINT10 */
>                                 interrupt-names = "host-wake";
>                                 status = "okay";
>                         };
>                 };
>
> Where the "clocks" and "clock-frequency" attributes would be something
> which we standardize in Documentation/devicetree/bindings/mmc/mmc-bus.txt
>
> These standard properties would *not* be used by the driver for the
> childnode device, so as to avoid the chicken and egg problem of that driver
> needing to enable clks, and it only getting bound to the device after
> the device has been discovered which requires those clocks.
>
> Instead these properties would be parsed by mmc_of_parse, and we will
> get enabled automatically by mmc_add_host before doing any probing.
>
> If the optional clock-frequency property is also set, then mmc_add_host
> will not only enable the clks but also set them to the specified
> frequency.
>
> Note I've no boards which actually need the clocks, all 3 boards with
> sdio wifi which I've use a 26MHz crystal directly attached to the module,
> so once I get the oob interrupt working (this needs some work on
> the allwinner side) we can merge Arend's patches with the clock bits
> dropped for now.
>
> Still I want to get a discussion going on this, so that when the time
> comes that we do need it we know how to deal with this, or ideally
> already have code in place to deal with it.


Cheers
ChenYu
