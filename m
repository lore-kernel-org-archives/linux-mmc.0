From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys
 DWC MSHC
Date: Thu, 12 Jul 2018 10:06:11 +0800
Message-ID: <20180712100611.5887a195@xhacker.debian>
References: <20180706151930.78b3024b@xhacker.debian>
        <20180706152047.0b0a4944@xhacker.debian>
        <20180711161206.GA1558@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711161206.GA1558@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Manjunath M B <Manjunath.MB@synopsys.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Rob,

On Wed, 11 Jul 2018 10:12:06 -0600 Rob Herring wrote:

> On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> > Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> > Controller can support eMMC/SD/SDIO. Add the bindings.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > new file mode 100644
> > index 000000000000..ee4253b33be2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > @@ -0,0 +1,20 @@
> > +* Synopsys DesignWare Cores Mobile Storage Host Controller
> > +
> > +Required properties:
> > +- compatible: should be one of the following:
> > +    "snps,dwcmshc-sdhci"  
> 
> Needs to note that there must also be an SoC specific compatible.

Currently, there's no SoC specific code in this driver, so the binding could
be extended to SoC compatible if necessary. What do you think?

Thanks,
Jisheng
