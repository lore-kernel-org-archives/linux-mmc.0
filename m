From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties
 for Arasan SDHCI
Date: Fri, 18 Oct 2019 09:05:07 +0000
Message-ID: <MN2PR02MB602959AB68B4C88B81359F2EC16C0@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
 <1571293310-92563-5-git-send-email-manish.narani@xilinx.com>
 <20191017182255.GA7053@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191017182255.GA7053@bogus>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Nava kishore Manne <navam@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Michal Simek <michals@xilinx.com>, git <git@xilinx.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

Thank you so much for the review.
Please find my comments inline below.

Thanks,
Manish

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Thursday, October 17, 2019 11:53 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: ulf.hansson@linaro.org; mark.rutland@arm.com; adrian.hunter@intel.com;
> Michal Simek <michals@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Rajan
> Vaja <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>;
> mdf@kernel.org; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>
> Subject: Re: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties
> for Arasan SDHCI
> 
> On Thu, Oct 17, 2019 at 11:51:46AM +0530, Manish Narani wrote:
> > Add optional propeties for Arasan SDHCI which are used to set clk delays
> 
> properties
> 
> > for different speed modes in the controller.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index b51e40b2e0c5..e0369dd7fb18 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -46,6 +46,21 @@ Optional Properties:
> >      properly. Test mode can be used to force the controller to function.
> >    - xlnx,int-clock-stable-broken: when present, the controller always reports
> >      that the internal clock is stable even when it is not.
> > +  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy
> Mode.
> > +  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
> > +  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
> > +  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
> > +  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
> > +  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
> > +  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for
> SDR104.
> > +  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD
> DDR50.
> > +  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC
> DDR52.
> > +  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC
> HS200.
> > +  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC
> HS400.
> 
> Should be common?
Yes, these properties should be common.

> 
> Range of values?
As these values are in degrees, the range of values is 0 to 359 degrees.

Thanks,
Manish
