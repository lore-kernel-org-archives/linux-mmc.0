From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO
 controller binding
Date: Mon, 8 Jul 2019 20:16:41 -0600
Message-ID: <20190709021641.GA28185@bogus>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-3-manivannan.sadhasivam@linaro.org>
 <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d164528-c797-5f94-f905-719d4f69542c@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, ulf.hansson@linaro.org, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org, linus.walleij@linaro.org, linux-clk@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 10, 2019 at 03:45:37PM +0200, Andreas Färber wrote:
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Add devicetree binding for Actions Semi Owl SoC's SD/MMC/SDIO controller.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/owl-mmc.txt       | 37 +++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.txt
> 
> Rob, should this be YAML now?

Would be nice and might get reviewed faster, but I'll leave that to Ulf 
to start requiring.

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.txt b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > new file mode 100644
> > index 000000000000..a702f8d66cec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.txt
> > @@ -0,0 +1,37 @@
> > +Actions Semi Owl SoCs SD/MMC/SDIO controller
> > +
> > +Required properties:
> > +- compatible: should be "actions,owl-mmc"
> > +- reg: offset and length of the register set for the device.
> > +- interrupts: single interrupt specifier.
> > +- clocks: single clock specifier of the controller clock.
> > +- resets: phandle to the reset line.
> > +- dma-names: should be "mmc".
> > +- dmas: single DMA channel specifier
> 
> I recall the main blocker for MMC being regulators, i.e. the I²C
> attached multi-function PMIC. Yet I don't see any such required property
> here, nor any patch series implementing it. Seems like this relies on
> U-Boot having initialized SD/eMMC? Do you intend to make them optional
> or did you want to hold off merging this one until the rest is done?
> 
> > +
> > +Optional properties:
> > +- pinctrl-names: pinctrl state names "default" must be defined.
> > +- pinctrl-0: phandle referencing pin configuration of the controller.
> > +- bus-width: see mmc.txt
> > +- cap-sd-highspeed: see mmc.txt
> > +- cap-mmc-highspeed: see mmc.txt
> > +- sd-uhs-sdr12: see mmc.txt
> > +- sd-uhs-sdr25: see mmc.txt
> > +- sd-uhs-sdr50: see mmc.txt
> > +- non-removable: see mmc.txt
> 
> I'm not convinced duplicating common properties is a good idea here, in
> particular pinctrl.

The main value is to define which common properties are valid for this 
binding (and by omission which ones aren't valid).

Rob
