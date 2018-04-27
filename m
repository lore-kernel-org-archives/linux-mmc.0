From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 13/14] dt-bindings: sdhci-omap: Add pinctrl bindings
Date: Fri, 27 Apr 2018 09:26:11 -0500
Message-ID: <20180427142611.n5qysqpc2cvfcmnw@rob-hp-laptop>
References: <20180427114723.2687-1-kishon@ti.com>
 <20180427114723.2687-14-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180427114723.2687-14-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 27, 2018 at 05:17:22PM +0530, Kishon Vijay Abraham I wrote:
> Add pinctrl binding rquired to get the mux mode and IODelay
> values from devicetree.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
