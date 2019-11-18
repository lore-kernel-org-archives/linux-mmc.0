From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Date: Mon, 18 Nov 2019 03:55:56 +0000
Message-ID: <MN2PR02MB6029D9F42B920927DF7813EEC14D0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
 <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
 <20191104231427.GA7606@bogus>
 <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <MN2PR02MB6029D371F580123CB32BE148C1740@MN2PR02MB6029.namprd02.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Nava kishore Manne <navam@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>, git <git@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Manish Narani
> Sent: Monday, November 11, 2019 3:38 PM
> To: Rob Herring <robh@kernel.org>
> Cc: ulf.hansson@linaro.org; mark.rutland@arm.com;
> adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-mmc@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; git <git@xilinx.com>
> Subject: RE: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
> for mmc
> 
> Hi Rob,
> 
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, November 5, 2019 4:44 AM
> > To: Manish Narani <MNARANI@xilinx.com>
> > Cc: ulf.hansson@linaro.org; mark.rutland@arm.com;
> > adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>; Jolly Shah
> > <JOLLYS@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Rajan
> Vaja
> > <RAJANV@xilinx.com>; linux-mmc@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git <git@xilinx.com>
> > Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic
> > properties for mmc
> >
> > On Fri, Nov 01, 2019 at 11:35:49AM +0530, Manish Narani wrote:
> > > Add optional properties for mmc hosts which are used to set clk delays
> > > for different speed modes in the controller.
> > >
> > > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > > ---
> > >  .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> controller.yaml
> > b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > index 080754e0ef35..87a83d966851 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > @@ -212,6 +212,98 @@ properties:
> > >      description:
> > >        eMMC HS400 enhanced strobe mode is supported
> > >
> > > +  # Below mentioned are the clock (phase) delays which are to be
> > configured
> > > +  # in the controller while switching to particular speed mode. The range
> > > +  # of values are 0 to 359 degrees.
> > > +
> > > +  clk-phase-legacy:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for Legacy Mode.
> > > +
> > > +  clk-phase-mmc-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair degrees for MMC HS.
> > > +
> > > +  clk-phase-sd-hs:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD HS.
> > > +
> > > +  clk-phase-uhs-sdr12:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR12.
> > > +
> > > +  clk-phase-uhs-sdr25:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR25.
> > > +
> > > +  clk-phase-uhs-sdr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR50.
> > > +
> > > +  clk-phase-uhs-sdr104:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SDR104.
> > > +
> > > +  clk-phase-uhs-ddr50:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for SD DDR50.
> > > +
> > > +  clk-phase-mmc-ddr52:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC DDR52.
> > > +
> > > +  clk-phase-mmc-hs200:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS200.
> > > +
> > > +  clk-phase-mmc-hs400:
> > > +    allOf:
> > > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > > +      - minimum: 0
> > > +      - maximum: 359
> > > +    description:
> > > +      Input/Output Clock Delay pair in degrees for MMC HS400.
> >
> > This can be condensed into:
> >
> > patternProperties:
> >
> > "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-
> > (sdr(12|25|50|104)|ddr50))$":
> >
> > Or if you want to divide them between SD and MMC ones, that would be
> > fine for me.
> 
> Below change should work? Please review.
> 
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,6 +333,16 @@ patternProperties:
>      required:
>        - reg
> 
> +  "^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-
> (sdr(12|25|50|104)|ddr50))$":
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Set the clock (phase) delays which are to be configured in the
> +      controller while switching to particular speed mode. These values
> +      are in pair of degrees.
> +
>  dependencies:
>    cd-debounce-delay-ms: [ cd-gpios ]
>    fixed-emmc-driver-type: [ non-removable ]
> @@ -351,6 +361,7 @@ examples:
>          keep-power-in-suspend;
>          wakeup-source;
>          mmc-pwrseq = <&sdhci0_pwrseq>;
> +        clk-phase-sd-hs = <63>, <72>;
>      };
> 
>    - |


Any comment on above change?

Thanks,
Manish
