From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys DWC
 MSHC
Date: Mon, 16 Jul 2018 15:59:13 -0600
Message-ID: <20180716215913.GA4269@rob-hp-laptop>
References: <20180706151930.78b3024b@xhacker.debian>
 <20180706152047.0b0a4944@xhacker.debian>
 <20180711161206.GA1558@rob-hp-laptop>
 <20180712100611.5887a195@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180712100611.5887a195@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath M B <Manjunath.MB@synopsys.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 12, 2018 at 10:06:11AM +0800, Jisheng Zhang wrote:
> Hi Rob,
> 
> On Wed, 11 Jul 2018 10:12:06 -0600 Rob Herring wrote:
> 
> > On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> > > Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> > > Controller can support eMMC/SD/SDIO. Add the bindings.
> > > 
> > > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > ---
> > >  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > new file mode 100644
> > > index 000000000000..ee4253b33be2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > > @@ -0,0 +1,20 @@
> > > +* Synopsys DesignWare Cores Mobile Storage Host Controller
> > > +
> > > +Required properties:
> > > +- compatible: should be one of the following:
> > > +    "snps,dwcmshc-sdhci"  
> > 
> > Needs to note that there must also be an SoC specific compatible.
> 
> Currently, there's no SoC specific code in this driver, so the binding could
> be extended to SoC compatible if necessary. What do you think?

Doesn't matter what's in the driver, it can use this compatible.

But experience has shown that a compatible for a licensed IP is never 
sufficient. There are versions of the blocks, configuration options, and 
integration differences.

I'm not asking you to add any SoC specific compatible now unless you 
are working on a particular SoC, but just state one is needed. 

Rob
