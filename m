From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sdhci-of-at91: add the
 microchip,sdcal-inverted property
Date: Tue, 15 Oct 2019 17:25:40 -0500
Message-ID: <20191015222540.GA13117@bogus>
References: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 8 Oct 2019 14:34:31 +0200, Nicolas Ferre wrote:
> Add the specific microchip,sdcal-inverted property to at91 sdhci
> device binding.
> This optional property describes how the SoC SDCAL pin is connected.
> It could be handled at SiP, SoM or board level.
> 
> This property read by at91 sdhci driver will allow to put in place a
> software workaround that would reduce power consumption.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
