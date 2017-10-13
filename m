From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 4/5] mmc: dw_mmc: Fix the DTO timeout calculation
Date: Fri, 13 Oct 2017 09:02:24 +0800
Message-ID: <90e49214-e7da-8b83-7f45-a0bbb18d6709@rock-chips.com>
References: <20171012201118.23570-1-dianders@chromium.org>
 <20171012201118.23570-5-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171012201118.23570-5-dianders@chromium.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, amstan@chromium.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, linux-samsung-soc@vger.kernel.org, kernel@esmil.dk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 2017/10/13 4:11, Douglas Anderson wrote:
> Just like the CTO timeout calculation introduced recently, the DTO
> timeout calculation was incorrect.  It used "bus_hz" but, as far as I
> can tell, it's supposed to use the card clock.  Let's account for the
> div value, which is documented as 2x the value stored in the register,
> or 1 if the register is 0.
> 
> NOTE: This was likely not terribly important until commit 16a34574c6ca
> ("mmc: dw_mmc: remove the quirks flags") landed because "DIV" is
> documented on Rockchip SoCs (the ones that used to define the quirk)
> to always be 0 or 1.  ...and, in fact, it's documented to only be 1
> with EMMC in 8-bit DDR52 mode.  Thus before the quirk was applied to
> everyone it was mostly OK to ignore the DIV value.
> 
> I haven't personally observed any problems that are fixed by this
> patch but I also haven't tested this anywhere with a DIV other an 0.
> AKA: this problem was found simply by code inspection and I have no
> failing test cases that are fixed by it.  Presumably this could fix
> real bugs for someone out there, though.
> 
> Fixes: 16a34574c6ca ("mmc: dw_mmc: remove the quirks flags")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
> 
> Changes in v2:
> - Fix the DTO timeout calculation new for v2
> 
>   drivers/mmc/host/dw_mmc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 50148991f30e..6bc87b1385a9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1936,10 +1936,16 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
>   static void dw_mci_set_drto(struct dw_mci *host)
>   {
>   	unsigned int drto_clks;
> +	unsigned int drto_div;
>   	unsigned int drto_ms;
> +	unsigned long irqflags;
>   
>   	drto_clks = mci_readl(host, TMOUT) >> 8;
> -	drto_ms = DIV_ROUND_UP(drto_clks, host->bus_hz / 1000);
> +	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> +	if (drto_div == 0)
> +		drto_div = 1;
> +	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +			       host->bus_hz);
>   
>   	/* add a bit spare time */
>   	drto_ms += 10;
> 
