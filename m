From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
Date: Fri, 15 Feb 2019 12:07:18 -0800
Message-ID: <20190215200718.GB15711@atomide.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190215192033.24203-4-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org
List-Id: linux-mmc@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
> From: Chunyan Zhang <zhang.chunyan@linaro.org>
> 
> sdhci-omap can support both external dma controller via dmaengine
> framework as well as ADMA which standard SD host controller
> provides.

Care to describe here also how to configure things for ADMA and
instead of DMA? Just leave out dmas property?

Regards,

Tony
