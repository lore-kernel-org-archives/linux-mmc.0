From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
Date: Mon, 18 Feb 2019 08:20:33 -0800
Message-ID: <20190218162033.GF15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
 <20190215200718.GB15711@atomide.com>
 <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190218 13:38]:
> Hi Tony,
> 
> On 16/02/19 1:37 AM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
> >> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> >>
> >> sdhci-omap can support both external dma controller via dmaengine
> >> framework as well as ADMA which standard SD host controller
> >> provides.
> > 
> > Care to describe here also how to configure things for ADMA and
> > instead of DMA? Just leave out dmas property?
> >
> That's correct. If dmas property is populated, then use external DMA.
> Otherwise use ADMA/SDMA depending on what you read from the CAPS register.

OK thanks.

Tony
