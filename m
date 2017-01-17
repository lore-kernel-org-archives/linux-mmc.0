From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Tue, 17 Jan 2017 21:33:40 +0100
Message-ID: <20170117203340.dx6k4zof2omcbz4y@ninjato>
References: <20170117195940.25092-1-chris.brandt@renesas.com>
 <20170117195940.25092-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117195940.25092-3-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 17, 2017 at 02:59:39PM -0500, Chris Brandt wrote:
> In the case of a single clock source, you don't need names. However,
> if the controller has 2 clock sources, you need to name them correctly
> so the driver can find the 2nd one.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index a1650ed..258b98c 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -25,8 +25,29 @@ Required properties:
>  		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
>  		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
>  
> +- clocks: Most controllers only have 1 clock source per cahnnel. However, some

channel.

> +	  have 2. If 2 clocks are specified, you must name them as "core" and

Maybe "However, some have a second clock dedicated to card detection."?
