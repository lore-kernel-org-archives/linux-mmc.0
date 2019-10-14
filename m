From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: sdhci-of-at91: new compatible string
 and update properties
Date: Mon, 14 Oct 2019 13:11:35 -0500
Message-ID: <20191014181135.GA4428@bogus>
References: <20191011103340.26749-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191011103340.26749-1-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@microchip.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, claudiu.beznea@microchip.com, Eugen.Hristev@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 11 Oct 2019 12:33:37 +0200, Ludovic Desroches wrote:
> There is a new compatible string for the SAM9X60 sdhci device. It involves
> an update of the properties about the clocks stuff.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
> 
> Changes:
> - v2: remove the extra example and fix node label
> 
> This patch conflicts with Nicolas' one: "dt-bindings: sdhci-of-at91: add
> the microchip,sdcal-inverted property". Let me know which one has to be
> rebased or you can handle it.
> 
> Ludovic
> 
> 
>  .../devicetree/bindings/mmc/sdhci-atmel.txt       | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
