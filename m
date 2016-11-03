From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 09/13] mmc: dw_mmc: remove the "clock-freq-min-max" property
Date: Thu, 03 Nov 2016 09:20:15 +0100
Message-ID: <20823767.hqlyMd1aKN@diego>
References: <20161103062135.10697-1-jh80.chung@samsung.com> <20161103062135.10697-10-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20161103062135.10697-10-jh80.chung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

Am Donnerstag, 3. November 2016, 15:21:31 schrieb Jaehoon Chung:
> Remove the "clock-freq-min-max" property.
> There is "max-frequency" property in drivers/mmc/core/host.c
> It can be used for getting maximum frequency.
> 
> And minimum clock value is assigned to 100K by default.
> Because MMC core should check the initial clock value from
> 400K to 100K until finding correct value.
> It's why Minimum value puts 100K by default.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  3 ---
>  drivers/mmc/host/dw_mmc.c                                  | 13
> ++++--------- 2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
> 4e00e85..21c8251 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -56,9 +56,6 @@ Optional properties:
>    is specified and the ciu clock is specified then we'll try to set the ciu
> clock to this at probe time.
> 
> -* clock-freq-min-max: Minimum and Maximum clock frequency for card output
> -  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz
> by default. -

I'd think devicetree people will protest about simply removing this property 
without deprecating it first - to be backwards compatible with old devicetrees.

Especially as this property was added already back in 2013, so has been in use 
for quite some time.


Heiko
