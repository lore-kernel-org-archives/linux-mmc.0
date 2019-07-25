From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update documentation
 for SD Card Clock
Date: Thu, 25 Jul 2019 15:00:53 +0200
Message-ID: <CAPDyKFostBKYipTkCsDbggsrux7w8BPqARx7fwRsL1XqEEX2NQ@mail.gmail.com>
References: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
 <1561958991-21935-2-git-send-email-manish.narani@xilinx.com>
 <20190722215404.GA28292@bogus>
 <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <MN2PR02MB602907616249FF19C1A737D8C1C70@MN2PR02MB6029.namprd02.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Manish Narani <MNARANI@xilinx.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "kernel@esmil.dk" <kernel@esmil.dk>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jolly Shah <JOLLYS@xilinx.com>, "tony.xie@rock-chips.com" <tony.xie@rock-chips.com>, "philipp.tomsich@theobroma-systems.com" <philipp.tomsich@theobroma-systems.com>, "heiko@sntech.de" <heiko@sntech.de>, Rob Herring <robh@kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nava kishore Manne <navam@xilinx.com>, "scott.branden@broadcom.com" <scott.branden@broadcom.com>, "ayaka@soulik.info" <ayaka@soulik.info>, "mdf@kernel.org" <mdf@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead>
List-Id: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 10:23, Manish Narani <MNARANI@xilinx.com> wrote:
>
> Hi Rob,
>
> Thanks a lot for the review!
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, July 23, 2019 3:24 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; heiko@sntech.de; Michal
> > Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> > christoph.muellner@theobroma-systems.com; philipp.tomsich@theobroma-
> > systems.com; viresh.kumar@linaro.org; scott.branden@broadcom.com;
> > ayaka@soulik.info; kernel@esmil.dk; tony.xie@rock-chips.com; Rajan Vaja
> > <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Nava kishore Manne
> > <navam@xilinx.com>; mdf@kernel.org; olof@lixom.net; linux-
> > mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > rockchip@lists.infradead.org
> > Subject: Re: [PATCH v2 01/11] dt-bindings: mmc: arasan: Update
> > documentation for SD Card Clock
> >
> > On Mon, Jul 01, 2019 at 10:59:41AM +0530, Manish Narani wrote:
> > > The clock handling is to be updated in the Arasan SDHCI. As the
> > > 'devm_clk_register' is deprecated in the clock framework, this needs to
> > > specify one more clock named 'clk_sdcard' to get the clock in the driver
> > > via 'devm_clk_get()'. This clock represents the clock from controller to
> > > the card.
> >
> > Please explain why in terms of the binding, not some driver calls.
> Okay.
>
> >
> >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 15 ++++++++++-
> > ----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > index 1edbb04..15c6397 100644
> > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > @@ -23,6 +23,10 @@ Required Properties:
> > >    - reg: From mmc bindings: Register location and length.
> > >    - clocks: From clock bindings: Handles to clock inputs.
> > >    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
> > > +            Apart from these two there is one more optional clock which
> > > +            is "clk_sdcard". This clock represents output clock from
> > > +            controller and card. This must be specified when #clock-cells
> > > +            is specified.
> > >    - interrupts: Interrupt specifier
> > >
> > >  Required Properties for "arasan,sdhci-5.1":
> > > @@ -36,9 +40,10 @@ Optional Properties:
> > >    - clock-output-names: If specified, this will be the name of the card clock
> > >      which will be exposed by this device.  Required if #clock-cells is
> > >      specified.
> > > -  - #clock-cells: If specified this should be the value <0>.  With this property
> > > -    in place we will export a clock representing the Card Clock.  This clock
> > > -    is expected to be consumed by our PHY.  You must also specify
> > > +  - #clock-cells: If specified this should be the value <0>. With this
> > > +    property in place we will export one clock representing the Card
> > > +    Clock. This clock is expected to be consumed by our PHY. You must also
> > > +    specify
> >
> > specify what?
> I think this line was already there, I missed to correct it, Will update in v3.
>
> >
> > The 3rd clock input I assume? This statement means any existing users
> > with 2 clock inputs and #clock-cells are in error now. Is that correct?
> Yes, this is correct. So far there was only one vendor using '#clock-cells'  which is Rockchip. I have sent DT patch (02/11) for that also.
> Here this is needed as earlier implementation isn't correct as suggested by Uffe. (https://lkml.org/lkml/2019/6/20/486) .

I am not sure how big of a problem the backwards compatible thingy
with DT is, in general we must not break it. What do you say Manish?

As a workaround, would it be possible to use
of_clk_get_from_provider() somehow to address the compatibility issue?
Or maybe there is another clock API that can help.

Kind regards
Uffe
