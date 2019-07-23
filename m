From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Date: Tue, 23 Jul 2019 08:23:25 +0000
Message-ID: <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722215404.GA28292@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "heiko@sntech.de" <heiko@sntech.de>, Michal Simek <michals@xilinx.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "christoph.muellner@theobroma-systems.com" <christoph.muellner@theobroma-systems.com>, "philipp.tomsich@theobroma-systems.com" <philipp.tomsich@theobroma-systems.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "scott.branden@broadcom.com" <scott.branden@broadcom.com>, "ayaka@soulik.info" <ayaka@soulik.info>, "kernel@esmil.dk" <kernel@esmil.dk>, "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>, Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>, Nava kishore Manne <navam@xilinx.com>, "mdf@kernel.org" <mdf@kernel.org>, "olof@lixom.net" <olof@lixom.net>l
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

Thanks a lot for the review!


> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, July 23, 2019 3:24 AM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; heiko@sntech.de; Michal
> Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> <navam@xilinx.com>; mdf@kernel.org; olof@lixom.net; linux-
> mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> rockchip@lists.infradead.org
> Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update
> documentation for SD Card Clock
>=20
> On Mon, Jul 01, 2019 at 10:59:41AM +0530, Manish Narani wrote:
> > The clock handling is to be updated in the Arasan SDHCI. As the
> > 'devm_clk_register' is deprecated in the clock framework, this needs to
> > specify one more clock named 'clk_sdcard' to get the clock in the drive=
r
> > via 'devm_clk_get()'. This clock represents the clock from controller t=
o
> > the card.
>=20
> Please explain why in terms of the binding, not some driver calls.
Okay.

>=20
>=20
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++=
-
> ----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index 1edbb04..15c6397 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -23,6 +23,10 @@ Required Properties:
> >    - reg: From mmc bindings: Register location and length.
> >    - clocks: From clock bindings: Handles to clock inputs.
> >    - clock-names: From clock bindings: Tuple including "clk_xin" and "c=
lk_ahb"
> > +		 Apart from these two there is one more optional clock which
> > +		 is "clk_sdcard". This clock represents output clock from
> > +		 controller and card. This must be specified when #clock-cells
> > +		 is specified.
> >    - interrupts: Interrupt specifier
> >
> >  Required Properties for "arasan,sdhci-5.1":
> > @@ -36,9 +40,10 @@ Optional Properties:
> >    - clock-output-names: If specified, this will be the name of the car=
d clock
> >      which will be exposed by this device.  Required if #clock-cells is
> >      specified.
> > -  - #clock-cells: If specified this should be the value <0>.  With thi=
s property
> > -    in place we will export a clock representing the Card Clock.  This=
 clock
> > -    is expected to be consumed by our PHY.  You must also specify
> > +  - #clock-cells: If specified this should be the value <0>. With this
> > +    property in place we will export one clock representing the Card
> > +    Clock. This clock is expected to be consumed by our PHY. You must =
also
> > +    specify
>=20
> specify what?
I think this line was already there, I missed to correct it, Will update in=
 v3.

>=20
> The 3rd clock input I assume? This statement means any existing users
> with 2 clock inputs and #clock-cells are in error now. Is that correct?
Yes, this is correct. So far there was only one vendor using '#clock-cells'=
  which is Rockchip. I have sent DT patch (02/11) for that also.
Here this is needed as earlier implementation isn't correct as suggested by=
 Uffe. (https://lkml.org/lkml/2019/6/20/486) .

Thanks,
Manish
