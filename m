From: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 4/4] clk: rockchip: remove CLK_IGNORE_UNUSED flag for
 aclk_emmc_grf on rk3399
Date: Wed, 31 Aug 2016 11:15:18 +0800
Message-ID: <7520496e-890c-1f60-6c44-c71ed7c97ad9@rock-chips.com>
References: <1472607448-4462-1-git-send-email-shawn.lin@rock-chips.com>
 <1472607448-4462-5-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472607448-4462-5-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On 2016年08月31日 09:37, Shawn Lin wrote:
> aclk_emmc_grf is used for accessing corecfg_* of emmc stuff within
> GRF block. We don't need to add CLK_IGNORE_UNUSED for it now as the
> emmc driver will enable/disable it explicitly when needed.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

This patchset test result:

localhost driver # cat /sys/kernel/debug/clk/clk_summary | grep emmc
           gpll_aclk_emmc_src              1            1 
594000000          0 0
              aclk_emmc                    3            5 
198000000          0 0
                 aclk_emmcgrf              1            2 
198000000          0 0
                 aclk_emmc_noc             1            1 
198000000          0 0
                 aclk_emmccore             0            0 
198000000          0 0
           clk_emmc                        1            2 
148500000          0 0
              emmc_cardclock               0            0 
148500000          0 0
           cpll_aclk_emmc_src              0            0 
800000000          0 0

After unbind driver.
localhost driver # cat /sys/kernel/debug/clk/clk_summary | grep emmc
           gpll_aclk_emmc_src              1            1 
594000000          0 0
              aclk_emmc                    1            2 
198000000          0 0
                 aclk_emmcgrf              0            0 
198000000          0 0
                 aclk_emmc_noc             1            1 
198000000          0 0
                 aclk_emmccore             0            0 
198000000          0 0
           clk_emmc                        0            0 
148500000          0 0
           cpll_aclk_emmc_src              0            0 
800000000          0 0

And aclk_emmcgrf(Bit 10, when high, enable clock) had gate.
localhost driver # mem r 0xff760380
0x00000415

It works sane, so

Tested-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

> ---
>
> Changes in v2: None
>
>   drivers/clk/rockchip/clk-rk3399.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index ede6c47..908f684 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -934,7 +934,7 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>   			RK3399_CLKGATE_CON(32), 8, GFLAGS),
>   	GATE(ACLK_EMMC_NOC, "aclk_emmc_noc", "aclk_emmc", CLK_IGNORE_UNUSED,
>   			RK3399_CLKGATE_CON(32), 9, GFLAGS),
> -	GATE(ACLK_EMMC_GRF, "aclk_emmcgrf", "aclk_emmc", CLK_IGNORE_UNUSED,
> +	GATE(ACLK_EMMC_GRF, "aclk_emmcgrf", "aclk_emmc", 0,
>   			RK3399_CLKGATE_CON(32), 10, GFLAGS),
>   
>   	/* perilp0 */


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
